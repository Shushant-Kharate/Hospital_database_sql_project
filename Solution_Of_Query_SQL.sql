
#1. Show first name, last name, and gender of patients1 whose gender is 'M'
select First_name, Last_name, Gender 
from patients1 
where gender="M";

#2. Write a query to find the first_name, last name and birth date of patients1 who has height greater than 160 and weight greater than 70
select First_name, Last_name, Birth_date 
from patients1 
where height>160 
and 
weight>70;

#3. Show all columns for patients1 who have one of the following patient_ids: 1,3,6,8,10
select * from patients1 where patient_id in (1, 3, 6, 8, 10);

#4. Show the total amount of male patients1 and the total amount of female patients1 in the patients1 table.Display the two results in the same row.
select 
count(case when gender = 'M' then 1 end) as Male_patients1,
count(case when gender = 'F' then 1 end) as Female_patients1
from patients1;

#5. Show unique first names from the patients1 table which only occurs once in the list. For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
select distinct(First_name) from patients1;

#6. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions1 to least admissions1
select day(Admission_date) as Day,
count(*) as Number_of_admission 
from admissions1 
group by Day 
order by Number_of_admission desc;
select count(*) from admissions1;

#7. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select 
concat(p.first_name, " ", p.last_name) as patient_name,
a.diagnosis,
concat(d.first_name, " ", d.last_name) as doctor_name
from patients1 as p
inner join admissions1 as a on p.patient_id = a.patient_id
inner join doctors1 as d on a.attending_doctor_id = d.doctor_id;

#8. Display the total amount of patients1 for each province. Order by descending.
select pr.Province_name, count(*) as Number_of_patients1 
from province_names1 as pr 
inner join 
patients1 as pa 
on pr.province_id=pa.province_id 
group by pr.province_name 
order by Number_of_patients1 desc;

#9. Show patient_id, first_name, last_name from patients1 whos diagnosis is 'Dementia'.Primary diagnosis is stored in the admissions1 table.
select pa.First_name, pa.Last_name, ad.diagnosis from admissions1 as ad inner join patients1 as pa on pa.patient_id=ad.patient_id; 

#10. Show all of the patients1 grouped into weight groups. Show the total amount of patients1 in each weight group. Order the list by the weight group decending.
#For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select count(*) as Number_of_patients1, 
floor(weight/10)*10 as Criteria 
from  patients1 
group by criteria;

#11. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients1 who have a diagnosis as
# 'Presence of right artificial elbow joint' and the doctor's first name is 'Devin'.
select pa.patient_id, pa.First_name, pa.Last_name, do.speciality 
from admissions1 as ad 
inner join patients1 as pa 
on pa.patient_id=ad.patient_id 
inner join doctors1 as do 
on ad.attending_doctor_id=do.doctor_id where ad.diagnosis="Presence of right artificial elbow joint" and do.First_name= "Devin";


#12. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
#- First_name contains an 'r' after the first two letters.
#- Identifies their gender as 'F'
#- Born in February, November, or December
#- Their weight would be between 160kg and 180kg
#- Their patient_id is an even number
#- They are from the city 'Bagay'
select *
from patients1
where 
First_name like '__s%'
and gender = 'F'
and month(birth_date) in (2, 11, 12)
and weight between 160 and 180
and patient_id%2=0
and city = "Bagay";

#13. Show the provinces that has more patients1 identified as 'M' than 'F'. Must only show full province_name
select pn.province_name
from province_names1 pn
inner join patients1 p on pn.province_id = p.province_id
group by pn.province_name
having SUM(case when gender = 'M' then 1 else 0 end) > 
       SUM(case when gender = 'F' then 1 else 0 end);
       
#14. Show the first_name, last_name, and the total number of admissions1 handled by each doctor.
select do.first_name, do.last_name, count(*) 
from admissions1 
ad inner join doctors1 as do 
on do.doctor_id=ad.attending_doctor_id 
group by do.first_name, do.last_name;

#15. Show all allergies ordered by popularity. Exclude 'NKA' and NULL values from the result.
select allergies, count(*) as Popularity 
from patients1 
group by allergies 
order by Popularity desc;

#16. Show patient_id, weight, height, and isObese from the patients1 table.
select patient_id, weight, height, weight/((height/10)*(height/10)) as BMI 
from patients1 
where weight/((height/10)*(height/10))>30 
group by patient_id, weight, height;

#17. Calculate is Obese as a boolean (0 or 1) based on the formula: weight (kg) / (height in meters)^2 ≥ 30.
select 
patient_id,
weight,
height,
(weight / ((height / 10.0) * (height / 10.0))) as BMI,
case when (weight / ((height / 10.0) * (height / 10.0))) >= 30 
then 1 else 0
end as is_obese
from patients1;


#18. Show patient_id, first_name, last_name, and the attending doctor's specialty.
select pa.Patient_id, pa.First_name, pa.Last_name, do.Speciality 
from patients1 as pa 
inner join admissions1 as ad 
on pa.patient_id=ad.patient_id 
inner join doctors1 as do 
on ad.attending_doctor_id=do.doctor_id;

#19. Only include patients1 diagnosed with 'Epilepsy' and whose attending doctor's first name is 'Lisa'.
select pa.First_name, pa.Last_name, ad.Diagnosis 
from admissions1 as ad 
inner join doctors1 as do 
on do.doctor_id=ad.attending_doctor_id 
inner join patients1 as pa 
on pa.patient_id=ad.patient_id 
where ad.diagnosis like "%Epilepsy%" 
and do.first_name="Lisa";

#20. For patients1 who have gone through admissions1, display their patient_id and a temporary password.
# The password must be a combination of:
# 1. patient_id
# 2. the length of the patient’s last_name (numerical)
# 3. the year of their birth_date
# in that exact order.
select patient_id, 
concat(patient_id, length(last_name), year(birth_date)) as Password 
from patients1;

#21. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
select first_name, last_name, 'Patient' as role from patients1
union 
select first_name, last_name, 'Doctor' from doctors1;