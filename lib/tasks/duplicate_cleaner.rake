namespace :duplicate_cleaner do
  desc "TODO"
  task delete_duplicates: :environment do
    delete_duplicates
  end
  
end

def delete_duplicates
  duplicates = Duplicate.offset(10).limit(5)
  duplicates.transaction do
    duplicates.each do |duplicate|
   
      kept_borehole = duplicate.boreholes.includes(:handler).find_by(handlers:{manual_remediation:"KEEP"})
      deleted_boreholes = duplicate.boreholes.includes(:handler).where(handlers:{manual_remediation:"DELETE"})
      # deleted_borehole = deleted_boreholes.first
      deleted_boreholes.each do |deleted_borehole|
        
        deleted_borehole.entity.stratigraphies.update_all(eno:kept_borehole.eno)
        
        deleted_borehole.entity.samples.update_all(eno:kept_borehole.eno)
          # kept_borehole.entity.stratigraphies
          ##
        fix_constrained_model(deleted_borehole.entity.remarkws,kept_borehole.eno)
        fix_constrained_model(deleted_borehole.entity.resfacs_remarks,kept_borehole.eno)
        fix_constrained_model(deleted_borehole.entity.entity_attributes,kept_borehole.eno)
          # deleted_borehole.entity.entity_attributes
          # kept_borehole.entity.entity_attributes.size
      
          ## deleted_borehole.entity.entity_attributes.update_all(eno:kept_borehole.eno)
          ## deleted_borehole.entity.entity_attributes.update_all(eno:kept_borehole.eno)   
          ##
     
        deleted_borehole.entity.sidetrack.delete unless deleted_borehole.entity.sidetrack.nil?
        deleted_borehole.entity.well.delete unless deleted_borehole.entity.sidetrack.nil?
        deleted_borehole.entity.delete unless deleted_borehole.entity.nil?
      end
    end
  end
end

def fix_constrained_model(delete,keep_eno)
  delete.transaction do
    delete.each do |d|
      begin
        d.eno = keep_eno
        d.save
      rescue
          d.delete
      end
    end
  end
end



def backup_data
  duplicates = Duplicate.all
  models = Entity.reflections.keys
  duplicates.each do |duplicate|
    boreholes = duplicate.boreholes.includes(:handler).where(handlers:{manual_remediation:"DELETE"})
    boreholes.each do |borehole|
      begin
        entity = borehole.entity 
        puts borehole.eno
        # entity = Borehole.first.entity
        models.each do |model|
          model_instance = entity.send(model)
          case 
          when model_instance.is_a?(ActiveRecord::Base)
            backup_instance(model_instance)
          when model_instance.is_a?(ActiveRecord::Associations::CollectionProxy)
            model_instance.each do |mi|
              backup_instance(mi)
            end
          when model_instance.is_a?(NilClass)
            "Nil object found"
          else 
            "Blabla"
          end
        end
        rescue ActiveRecord::RecordNotFound => ex
          puts ex
        end
    end
  end
end

def backup_instance(instance)
  class_name = instance.class.to_s
  backup_class_name = "Borehole#{class_name}"
  backup_class = backup_class_name.constantize
  attributes=remove_dodgy_attributes(instance.attributes)
  object = backup_class.find_or_initialize_by(attributes)
  object.save
end

def remove_dodgy_attributes(attributes)
  if attributes["attribute"]
    attributes["a_attribute"] = attributes.delete "attribute"
    
  end
  return attributes
end
