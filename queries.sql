/* тяжелый
Ключевые навыки: 'PostgreSQL', 'C/C++', 'JavaScript'
Для каждого найти вакансию с максимальной зарплатой (если зарплата null, считать равной нулю), для которой требуется данный ключевой навык.
Вывести названия вакансий, зарплату и ключевой навык.
*/

-- работает, но без оконных функций
-- select _jks.job_name, _jks.job_salary, key_skills.name as key_skill
-- from (select job.name as job_name, job.salary as job_salary, hks.id_key_skills as id_ks
--       from job
--                join has_key_skills hks on job.id_job = hks.id_job
--                join
--            (select ks.id_key_skills, max(job.salary) as max_salary
--             from job
--                      join has_key_skills hks on job.id_job = hks.id_job
--                      join key_skills ks on hks.id_key_skills = ks.id_key_skills
--             where ks.name in ('PostgreSQL', 'C/C++', 'JavaScript')
--             group by ks.id_key_skills) as jks
--            on hks.id_key_skills = jks.id_key_skills and job.salary = jks.max_salary) as _jks
--          join key_skills on key_skills.id_key_skills = _jks.id_ks;


select hh1.name as job_name, hh1.salary as salary, key_skills.name as key_skill from
(select ks.id_key_skills, job.name, job.salary, max(job.salary) over (partition by ks.id_key_skills) as m
            from job
                     join has_key_skills hks on job.id_job = hks.id_job
                     join key_skills ks on hks.id_key_skills = ks.id_key_skills
            where ks.name in ('PostgreSQL', 'C/C++', 'JavaScript')) as hh1
                    join key_skills on key_skills.id_key_skills = hh1.id_key_skills
where m = salary;


/* средний
Вывести названия и id всех компаний, у которых есть хотя-бы какие-то льготы и есть описание.
Отсортировать по id.
*/

select distinct c.id_company, c.name
from has_benefits hb
         join company c on hb.id_company = c.id_company
where c.description is not NULL
order by c.id_company;


/* средний
Вывести id, ФИО всех пользователей и язык, у которых в хотя бы одном резюме (у одного пользователя может быть несколько
резюме) есть уровень владения английским C1 или выше ('Английский C1', 'Английский C2') (скопировать названия отсюда).
Отсортировать по id.
*/

select _user.id_user, _user.full_name, languages.name
from _user
         join resume on _user.id_user = resume.id_user
         join speak on speak.id_resume = resume.id_resume
         join languages on speak.id_languages = languages.id_languages
where name in ('Английский C1', 'Английский C2')
order by id_user;


/* средний
Вывести id резюме и названия вакансий, статус отклика между которыми 'Принято' и зарплата >= 100000.
Отсортировать по id.
*/

select resume.id_resume, job.name from resume join has_responses on resume.id_resume = has_responses.id_resume
join job on has_responses.id_job = job.id_job
where job.salary >= 100000 and has_responses.status = 'Принято'
order by id_resume;


/* легкий
Вывести id резюме, место обучения и год окончания, где он <=1980 (у одного резюме может быть несколько мест обучения,
вывести все подходящие).
Отсортировать по id.
*/

select id_resume, studying_place, date_finish from education
where date_finish <= 1980
order by id_resume;


/* легкий
Вывести все id резюме и места работы, где указана специальность 'Заведующий складом'.
Отсортировать по id.
*/

select id_resume, place from experience where specialization='Заведующий складом'
order by id_resume;


/* легкий
Вывести id пользователя и отзывы (плюсы и минусы), у которых длина плюсов (char_length) более чем в 4 раза
превышает длину минусов.
Отсортировать по id.
*/

select id_user, advantages, disadvantages from reviews
where char_length(advantages) > 4 * char_length(disadvantages);
