require 'date'
require 'csv'


def comm_serv_file_RnW
#input is a csv, output is new .csv file
  newfile = File.open('community_service_update.csv', "w")
    
    CSV.foreach ('Community_service_scrubbed.csv') do |row|
      if row[0] == "Name"
        header = row.join(",")
        newfile.print header << ",Hours Remaining,Days Remaining\n"
      else
        hours = hours_remaining(row)
        days = days_left(row, Date.today)
        risk = risk_factor(hours, days,row)
        row[7] = risk
         row[6] = "" if row[6]=="1.1.70"
        days = "Data Missing" if days <-10000 
        hours = "Data Missing" if row[4]== nil or row[5]== nil 
        new = (row.push(hours, days)).join(",")
        newfile.print "#{new}\n"
      end
    end
  
  newfile.close
end

def hours_remaining(array)
#input is array, output is a float
    assigned = array[4].to_f
    completed = array[5].to_f
  
    remaining_hours = assigned - completed
 
end

def clean_date(row)
#input is .csv array, output is changed string in position 6, if applicable
  if row[6] == nil || (row[6].include? "?")
    row[6] = "1.1.70"
  end
  
  row
end

def days_left(row, date)
#input is an array of  strings coming from the .csv, output is an integer
  row_with_revised_date = clean_date(row)
  today = (date).to_s #format YYYY/MM/DD
  
  max_date = row[6] #formatted MM/DD/YYYY/
  
  modified_max_date_array = max_date.split(".")
    
  modified_max_date = modified_max_date_array[2] + "." + modified_max_date_array[0] + "." + modified_max_date_array[1]
      
  days = (Date.parse(modified_max_date)) - (Date.parse(today))
  
  days_left = days.to_i
end




def risk_factor(hours, days,row)
  #input two variables, output is a single variables
     days = -1 if days == 0
    risk = hours/days.to_f
    if row[4] == nil or row[5] == nil or row[6] == "1.1.70"
      risk_factor = "Data missing"
    elsif risk == 0 
      risk_factor = "Hours Completed"
    elsif risk <0
      risk_factor = "High Risk"
    else
    risk = (hours / days).round(2)
    
    end
  
    
end

comm_serv_file_RnW