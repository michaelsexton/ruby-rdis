class DirSurveyStation < ActiveRecord::Base
  establish_connection "oracle_#{Rails.env}"
  
	self.table_name = "deviant.dir_srvy_station"
  self.primary_key = :eno
	#set_date_columns :entrydate, :qadate, :lastupdate, :effective_date, :acquisition_date, :expiry_date
	belongs_to :entity

end