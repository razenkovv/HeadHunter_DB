CREATE TABLE company
(
    name VARCHAR(300),
    description VARCHAR,
    id_company  SERIAL,
    PRIMARY KEY (id_company)
);

CREATE TABLE benefits
(
    id_benefits SERIAL,
    name        VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_benefits)
);

CREATE TABLE _user
(
    full_name        VARCHAR(100) NOT NULL,
    phone            VARCHAR(20)  NOT NULL,
    email            VARCHAR(100) NOT NULL,
    password         VARCHAR(30)  NOT NULL,
    desired_district VARCHAR(100),
    telegram         VARCHAR(30),
    facebook         VARCHAR(30),
    vk               VARCHAR(30),
    sms              BOOLEAN      NOT NULL,
    push             BOOLEAN      NOT NULL,
    date_of_birth    VARCHAR(25)  NOT NULL,
    id_user          SERIAL,
    PRIMARY KEY (id_user)
);

CREATE TABLE resume
(
    description     VARCHAR,
    email           VARCHAR(50)  NOT NULL,
    specialization  VARCHAR(500) NOT NULL,
    expected_salary INT,
    id_resume       SERIAL,
    id_user         INT          NOT NULL,
    PRIMARY KEY (id_resume),
    FOREIGN KEY (id_user) REFERENCES _user (id_user)
);

CREATE TABLE education
(
    studying_place VARCHAR(500) NOT NULL,
    degree         VARCHAR(50)  NOT NULL,
    specialization VARCHAR(500),
    date_finish    INT          NOT NULL,
    id_education   SERIAL,
    id_resume      INT          NOT NULL,
    PRIMARY KEY (id_education),
    FOREIGN KEY (id_resume) REFERENCES resume (id_resume)
);

CREATE TABLE employer
(
    full_name    VARCHAR(100) NOT NULL,
    phone        VARCHAR(20)  NOT NULL,
    email        VARCHAR(50)  NOT NULL,
    address      VARCHAR(200),
    id_employer  SERIAL,
    id_company   INT          NOT NULL,
    PRIMARY KEY (id_employer),
    FOREIGN KEY (id_company) REFERENCES company (id_company)
);

CREATE TABLE experience
(
    specialization VARCHAR(500) NOT NULL,
    date_start     VARCHAR(25)  NOT NULL,
    place          VARCHAR(500) NOT NULL,
    date_finish    VARCHAR(25)  NOT NULL,
    id_experience  SERIAL,
    id_resume      INT          NOT NULL,
    PRIMARY KEY (id_experience),
    FOREIGN KEY (id_resume) REFERENCES resume (id_resume)
);

CREATE TABLE industry
(
    name        VARCHAR(200) NOT NULL,
    id_industry SERIAL,
    PRIMARY KEY (id_industry)
);

CREATE TABLE job
(
    salary              INT,
    address             VARCHAR(200),
    required_experience VARCHAR(25) NOT NULL,
    name                VARCHAR(200) NOT NULL,
    description         VARCHAR,
    schedule            VARCHAR(50),
    date_of_publication VARCHAR(25) NOT NULL,
    id_job              SERIAL,
    id_employer         INT         NOT NULL,
    PRIMARY KEY (id_job),
    FOREIGN KEY (id_employer) REFERENCES Employer (id_employer)
);

CREATE TABLE key_skills
(
    name          VARCHAR(200) NOT NULL,
    id_key_skills SERIAL,
    PRIMARY KEY (id_key_skills)
);

CREATE TABLE languages
(
    name         VARCHAR(50) NOT NULL,
    id_languages SERIAL,
    PRIMARY KEY (id_languages)
);

CREATE TABLE reviews
(
    id_reviews    SERIAL,
    advantages    VARCHAR NOT NULL,
    disadvantages VARCHAR NOT NULL,
    id_company    INT     NOT NULL,
    id_user       INT     NOT NULL,
    PRIMARY KEY (id_reviews),
    FOREIGN KEY (id_company) REFERENCES company (id_company),
    FOREIGN KEY (id_user) REFERENCES _user (id_user)
);

CREATE TABLE speak
(
    id_speak     SERIAL,
    id_languages INT NOT NULL,
    id_resume    INT NOT NULL,
    PRIMARY KEY (id_speak),
    FOREIGN KEY (id_languages) REFERENCES languages (id_languages),
    FOREIGN KEY (id_resume) REFERENCES resume (id_resume)
);

CREATE TABLE has_benefits
(
    id_has_benefits SERIAL,
    id_company      INT NOT NULL,
    id_benefits     INT NOT NULL,
    PRIMARY KEY (id_has_benefits),
    FOREIGN KEY (id_company) REFERENCES company (id_company),
    FOREIGN KEY (id_benefits) REFERENCES benefits (id_benefits)
);

CREATE TABLE has_key_skills
(
    id_has_key_skills SERIAL,
    id_job            INT NOT NULL,
    id_key_skills     INT NOT NULL,
    PRIMARY KEY (id_has_key_skills),
    FOREIGN KEY (id_job) REFERENCES job (id_job),
    FOREIGN KEY (id_key_skills) REFERENCES key_skills (id_key_skills)
);

CREATE TABLE has_responses
(
    id_has_responses SERIAL,
    date             VARCHAR(25) NOT NULL,
    status           VARCHAR(25) NOT NULL,
    id_job           INT         NOT NULL,
    id_resume        INT         NOT NULL,
    PRIMARY KEY (id_has_responses),
    FOREIGN KEY (id_job) REFERENCES job (id_job),
    FOREIGN KEY (id_resume) REFERENCES resume (id_resume)
);

CREATE TABLE has_specified_industry
(
    id_has_specified_industry SERIAL,
    id_company                INT NOT NULL,
    id_industry               INT NOT NULL,
    PRIMARY KEY (id_has_specified_industry),
    FOREIGN KEY (id_company) REFERENCES company (id_company),
    FOREIGN KEY (id_industry) REFERENCES industry (id_industry)
);