require 'date'
require 'csv'

def comm_serv_file_RnW
#probaitoners = CSV.read("Community_service_scrubbed.csv")
data = []
#comm_serv_org = File.open("Community_service_scrubbed.csv","r")
filename = "community_service_update.csv"
file_new= File.open(filename,"w") 
 
    CSV.foreach('Community_service_scrubbed.csv', :headers=>true) do |row|
data << row
hours_given = row[4].to_f
hours_completed = row[5].to_f
if row[6] == nil
	row[6] = "01.01.1960"
end	

max_date = row[6].split(".")
formatted_max_date = max_date[1].to_s + "-" + max_date[0].to_s + "-" + max_date[2].to_s
puts formatted_max_date 
todays_date = Date.today
days_remaining = Date.parse(formatted_max_date) - todays_date
hours_remaining =  hours_given - hours_completed

def risk_factor(hours_remaining,days_remaining)
hours_remaining.to_f / days_remaining.to_f
end

def hours_remaining(assigned,completed)
assigned.to_f - complete.to_f

end

def days_remaining(max_days,today_date)
max_days.to_f - today_date.to_f
	 
end

warning =  risk_factor(hours_remaining,days_remaining)

 file_new.puts row.to_csv.chomp + "," + hours_remaining.to_s + "," + warning.round(3).to_s 

end
end

comm_serv_file_RnW