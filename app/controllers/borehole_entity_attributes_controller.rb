class BoreholeEntityAttributesController < ApplicationController
  def index
    @columns = BoreholeEntityAttribute.column_names
    @borehole_entity_attributes = BoreholeEntityAttribute.all
    respond_to do |format|
      format.xlsx
    end
  end
end