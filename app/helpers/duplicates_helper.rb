module DuplicatesHelper

	
  
	def get_wells_row(well)
    if well.nil?
      row=  Array.new(9)
		else
			row = [well.welltype,well.operator,well.purpose,well.status,well.classification,well.start_date, well.completion_date, well.originator, well.total_depth]
			
		end
    return row
	end

	def get_row_class(auto_remediation)
		case auto_remediation
		when "DELETE"
			return :delete
		when "KEEP"
			return :keep
		when nil
			return :unknown
		end
	end
  
  
  def create_duplicate_pattern(boreholes)
    ary=Array.new
    keep = boreholes.joins(:handler).where(:handlers=>{:auto_remediation => 'KEEP'})
    keep.each do |k|
      h=Hash.new
      delete = boreholes.joins(:handler).where(:handlers=>{:auto_transfer => k.eno})
      h[:keep] = k
      h[:delete] =delete
      ary.push(h)
    end
    return ary
    
  end 
end
