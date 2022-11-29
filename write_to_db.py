from sqlalchemy import create_engine
import pandas as pd
import psycopg2

path = 'D:\\мифи\\5_семестр\\базы данных\\data\\database\\'

table_names = ['Company.csv', 'Benefits.csv', '_User.csv', 'Resume.csv', 'Education.csv', 'Employer.csv',
               'Experience.csv', 'Industry.csv', 'Job.csv', 'Key_skills.csv', 'Languages.csv', 'Reviews.csv',
               'Speak.csv', 'Has_benefits.csv', 'Has_key_skills.csv', 'Has_responses.csv', 'Has_specified_industry.csv']

for name in table_names:
    df = pd.read_csv(path + name)
    df.columns = [c.lower() for c in df.columns]
    engine = create_engine('postgresql://postgres:superuser@localhost:5432/HeadHunter')
    df.to_sql(name.replace('.csv', '').lower(), engine, if_exists="append", index=False)

# df = pd.read_csv('D:\\мифи\\5_семестр\\базы данных\\data\\HeadHunter_database\\Key_skills.csv')
# df.columns = [c.lower() for c in df.columns]
# engine = create_engine('postgresql://postgres:superuser@localhost:5432/HeadHunter_database')
# df.to_sql('key_skills', engine, if_exists="append", index=False)
