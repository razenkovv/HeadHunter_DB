/* 
Ключевые навыки: 'PostgreSQL', 'C/C++', 'JavaScript'
Для каждого найти вакансию с максимальной зарплатой, для которой требуется данный ключевой навык. 
Вывести названия вакансий, зарплату и ключевой навык. 
*/

select _jks.job_name, _jks.job_salary, key_skills.name as key_skill
from (select job.name as job_name, job.salary as job_salary, hks.id_key_skills as id_ks
      from job
               join has_key_skills hks on job.id_job = hks.id_job
               join
           (select ks.id_key_skills, max(job.salary) as max_salary
            from job
                     join has_key_skills hks on job.id_job = hks.id_job
                     join key_skills ks on hks.id_key_skills = ks.id_key_skills
            where ks.name in ('PostgreSQL', 'C/C++', 'JavaScript')
            group by ks.id_key_skills) as jks
           on hks.id_key_skills = jks.id_key_skills and job.salary = jks.max_salary) as _jks
         join key_skills on key_skills.id_key_skills = _jks.id_ks
