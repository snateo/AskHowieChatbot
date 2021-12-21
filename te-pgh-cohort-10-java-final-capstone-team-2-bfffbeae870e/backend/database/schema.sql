BEGIN TRANSACTION;

DROP TABLE IF EXISTS responses_links;
DROP TABLE IF EXISTS links;
DROP TABLE IF EXISTS keywords;
DROP TABLE IF EXISTS responses;
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE "responses" (
        r_id SERIAL PRIMARY KEY,
        title CHARACTER VARYING NOT NULL,
        description CHARACTER VARYING NOT NULL,
        img_text CHARACTER VARYING,
        img_url CHARACTER VARYING
);
        
CREATE TABLE "keywords" (
        keyword CHARACTER VARYING NOT NULL PRIMARY KEY,
        r_id INT NOT NULL,
        CONSTRAINT r_id FOREIGN KEY (r_id) REFERENCES responses (r_id)
);

CREATE TABLE "links" (
        l_id SERIAL NOT NULL PRIMARY KEY,
        name CHARACTER VARYING UNIQUE NOT NULL,
        txt CHARACTER VARYING NOT NULL,
        url CHARACTER VARYING NOT NULL
);

CREATE TABLE "responses_links" (
        r_id INT NOT NULL,
        l_id INT NOT NULL,
        CONSTRAINT l_id FOREIGN KEY (l_id) REFERENCES links (l_id),
        CONSTRAINT r_id FOREIGN KEY (r_id) REFERENCES responses (r_id),
        PRIMARY KEY (r_id, l_id)
        );

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('kenton','$2a$10$O412a/41UuKOjg0TWOb/geach7N3eTlvrsKffUK4L1HXOf1gw57DG', 'ROLE_USER');


COMMIT TRANSACTION;

INSERT INTO responses (title, description)
VALUES ('Pathway', 'I will give you a link to the Pathway Resource Page, but please ask if you would like to know anything more specific!');
INSERT INTO links (name, txt, url)
VALUES ('pathway', 'Pathway Resources Page','https://sites.google.com/techelevator.com/pathwayresourcepage/home');
INSERT INTO keywords (keyword, r_id)
VALUES ('pathway', (SELECT r_id FROM responses WHERE title = 'Pathway'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'Pathway'), (SELECT l_id FROM links WHERE name ILIKE 'pathway'));

INSERT INTO responses (title, description)
VALUES ('STAR', 'The pathway program has some great tools for developing your STAR (Situation Task Action Result) answers.');
INSERT INTO links (name, txt, url)
VALUES ('STAR', 'STAR in Pathway','https://docs.google.com/document/d/1NvopfF2vG7LmivZSMYsJ3kwRg8t1WlwpvoSQ2anc9AI/edit');
INSERT INTO keywords (keyword, r_id)
VALUES ('star', (SELECT r_id FROM responses WHERE title = 'STAR'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'STAR'), (SELECT l_id FROM links WHERE name ILIKE 'star'));

INSERT INTO responses (title, description)
VALUES ('Cover Letter', 'Cover Letters are key to a good application.');
INSERT INTO links (name, txt, url)
VALUES ('Cover Letter', 'Glassdoor: Writing a Tech Cover Letter','https://www.glassdoor.com/blog/guide/tech-cover-letter/');
INSERT INTO keywords (keyword, r_id)
VALUES ('cover letter', (SELECT r_id FROM responses WHERE title = 'Cover Letter'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'Cover Letter'), (SELECT l_id FROM links WHERE name ILIKE 'cover letter'));

INSERT INTO responses (title, description)
VALUES ('Interview', 'It is important to be prepared for behavioral and technical interviews!');
INSERT INTO links (name, txt, url)
VALUES ('interview 101', 'TE Interview 101 Presentation','https://drive.google.com/file/d/1qWi5POEqMZUBkktiqcxiS2HR5PDrr0LR/view');
INSERT INTO links (name, txt, url)
VALUES ('technical interview', 'TE Technical Interview Presentation','https://drive.google.com/file/d/1HQjQma_PcP_rQpsA8UW7c9wzsgo2mlFS/view');
INSERT INTO keywords (keyword, r_id)
VALUES ('interview', (SELECT r_id FROM responses WHERE title = 'Interview'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'Interview'), (SELECT l_id FROM links WHERE name ILIKE 'interview 101'));INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'Interview'), (SELECT l_id FROM links WHERE name ILIKE 'technical interview'));

INSERT INTO responses (title, description)
VALUES ('LinkedIn', 'Resources for LinkedIn');
INSERT INTO links (name, txt, url)
VALUES ('LinkedIn', 'LinkedIn Tips','https://drive.google.com/file/d/18MmZpnI96BBriUVO3dHT2-YhVzKCJyJt/view');
INSERT INTO keywords (keyword, r_id)
VALUES ('LinkedIn', (SELECT r_id FROM responses WHERE title = 'LinkedIn'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'LinkedIn'), (SELECT l_id FROM links WHERE name ILIKE 'LinkedIn'));

INSERT INTO responses (title, description, img_text, img_url)
VALUES ('Dress', 'Knowing how to dress for a tech interview can increase the odds of you making a positive overall impression.', 'Infographic on how to dress', 'http://localhost:8080/images/how_to_dress.jpeg');
INSERT INTO links (name, txt, url)
VALUES ('Dress', 'Indeed: What to wear to a tech interview','https://www.indeed.com/career-advice/interviewing/what-to-wear-to-a-tech-interview#:~:text=A%20pair%20of%20dark%20straight,high%20and%20have%20stockings%20underneath.');
INSERT INTO keywords (keyword, r_id)
VALUES ('Dress', (SELECT r_id FROM responses WHERE title = 'Dress'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'Dress'), (SELECT l_id FROM links WHERE name ILIKE 'Dress'));

INSERT INTO responses (title, description)
VALUES ('array', 'When you want to work with collections of values, you use arrays. Rather than creating multiple variables, you create a single variable name that can represent multiple values.');
INSERT INTO links (name, txt, url)
VALUES ('array', 'Java / C# TE Book: Arrays','https://v2-4-techelevator-book.netlify.app/content/arrays-and-loops-ool.html#arrays');
INSERT INTO links (name, txt, url)
VALUES ('js array', 'FreeCodeCamp: JavaScript Arrays','https://www.freecodecamp.org/news/javascript-standard-objects-arrays/');
INSERT INTO keywords (keyword, r_id)
VALUES ('array', (SELECT r_id FROM responses WHERE title = 'array'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'array'), (SELECT l_id FROM links WHERE name ILIKE 'array'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'array'), (SELECT l_id FROM links WHERE name ILIKE 'js array'));

INSERT INTO responses (title, description)
VALUES ('loops', 'There are three different types of loops that are used in programming:

for loop - used when you want code to repeat a defined number of times—for example, one time for each element in an array
while loop - used when you want to continually execute a block of code as long as a condition remains true
do-while loop - used when you want to execute a block of code at least once and repeat it as long as a condition remains true
The most common loop used is the for loop, though for many of the exercises you complete and perform on the job, any of the loop choices can be substituted.');
INSERT INTO links (name, txt, url)
VALUES ('loops', 'Java / C# TE Book: Loops', 'https://v2-4-techelevator-book.netlify.app/content/arrays-and-loops-ool.html#loops');
INSERT INTO links (name, txt, url)
VALUES ('js loops', 'FreeCodeCamp: Loops in JavaScript', 'https://www.freecodecamp.org/news/javascript-loops-explained-for-loop-for/');
INSERT INTO keywords (keyword, r_id)
VALUES ('loop', (SELECT r_id FROM responses WHERE title = 'loops'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'loops'), (SELECT l_id FROM links WHERE name ILIKE 'loops'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'loops'), (SELECT l_id FROM links WHERE name ILIKE 'js loops'));

INSERT INTO responses (title, description)
VALUES ('classes', 'In object-oriented programming, a class is a set of related objects that share common characteristics. Classes are an important component that makes object-oriented programming a powerful and flexible programming paradigm.');
INSERT INTO links (name, txt, url)
VALUES ('classes','Java / C# TE Book', 'https://v2-4-techelevator-book.netlify.app/content/classes-encapsulation-ool.html#classes');
INSERT INTO keywords (keyword, r_id)
VALUES ('class', (SELECT r_id FROM responses WHERE title = 'classes'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'classes'), (SELECT l_id FROM links WHERE name ILIKE 'classes'));

INSERT INTO responses (title, description)
VALUES ('inheritance', 'The procedure in which one class inherits the attributes and methods of another class.');
INSERT INTO links (name, txt, url)
VALUES ('inheritance','Inheritance in book', 'https://v2-4-techelevator-book.netlify.app/content/inheritance-ool.html#class-hierarchies');
INSERT INTO keywords (keyword, r_id)
VALUES ('inheritance', (SELECT r_id FROM responses WHERE title = 'inheritance'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'inheritance'), (SELECT l_id FROM links WHERE name ILIKE 'inheritance'));

INSERT INTO responses (title, description)
VALUES ('polymorphism', 'The provision of a single interface to entities of different types, or the use of a single symbol to represent multiple different types.');
INSERT INTO links (name, txt, url)
VALUES ('polymorphism','Polymorphism in book', 'https://v2-4-techelevator-book.netlify.app/content/polymorphism-ool.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('polymorphism', (SELECT r_id FROM responses WHERE title = 'polymorphism'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'polymorphism'), (SELECT l_id FROM links WHERE name ILIKE 'polymorphism'));

INSERT INTO responses (title, description)
VALUES ('HTML', 'HTML (Hypertext Markup Language) is the code that is used to structure a web page and its content.');
INSERT INTO links (name, txt, url)
VALUES ('HTML','HTML in book', 'https://v2-4-techelevator-book.netlify.app/content/intro-html-css.html#introduction-to-html');
INSERT INTO keywords (keyword, r_id)
VALUES ('HTML', (SELECT r_id FROM responses WHERE title = 'HTML'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'HTML'), (SELECT l_id FROM links WHERE name ILIKE 'HTML'));

INSERT INTO responses (title, description)
VALUES ('CSS', 'CSS (Cascading Style Sheets) is a style sheet language used for describing the presentation of a document written in a markup language like HTML.');
INSERT INTO links (name, txt, url)
VALUES ('CSS','CSS in book', 'https://v2-4-techelevator-book.netlify.app/content/intro-html-css.html#introduction-to-css');
INSERT INTO keywords (keyword, r_id)
VALUES ('CSS', (SELECT r_id FROM responses WHERE title = 'CSS'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'CSS'), (SELECT l_id FROM links WHERE name ILIKE 'CSS'));

INSERT INTO responses (title, description)
VALUES ('JavaScript', 'JavaScript is a text-based programming language used both on the client-side and server-side that allows you to make web pages interactive.');
INSERT INTO links (name, txt, url)
VALUES ('JavaScript','JavaScript in book', 'https://v2-4-techelevator-book.netlify.app/content/intro-to-javascript.html');
INSERT INTO links (name, txt, url)
VALUES ('Learn JavaScript','FreeCodeCamp: JavaScript Courses', 'https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/');
INSERT INTO links (name, txt, url)
VALUES ('JS web docs','MDN Web Docs', 'https://developer.mozilla.org/en-US/');
INSERT INTO keywords (keyword, r_id)
VALUES ('JavaScript', (SELECT r_id FROM responses WHERE title = 'JavaScript'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'JavaScript'), (SELECT l_id FROM links WHERE name ILIKE 'JavaScript'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'JavaScript'), (SELECT l_id FROM links WHERE name ILIKE 'Learn JavaScript'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'JavaScript'), (SELECT l_id FROM links WHERE name ILIKE 'JS web docs'));

INSERT INTO responses (title, description)
VALUES ('functions', 'A block of code designed to perform a particular task.');
INSERT INTO links (name, txt, url)
VALUES ('functions','Functions in book', 'https://v2-4-techelevator-book.netlify.app/content/functions-javascript.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('functions', (SELECT r_id FROM responses WHERE title = 'functions'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'functions'), (SELECT l_id FROM links WHERE name ILIKE 'functions'));

INSERT INTO responses (title, description)
VALUES ('event handling', 'An event handler is a routine that deals with the event, allowing a programmer to write code that is executed when the event occurs.');
INSERT INTO links (name, txt, url)
VALUES ('event handling','Event Handling in book', 'https://v2-4-techelevator-book.netlify.app/content/event-handling-javascript.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('event handling', (SELECT r_id FROM responses WHERE title = 'event handling'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'event handling'), (SELECT l_id FROM links WHERE name ILIKE 'event handling'));

INSERT INTO responses (title, description)
VALUES ('vue', 'Vue.js is an open-source model–view–viewmodel front end JavaScript framework for building user interfaces and single-page applications.');
INSERT INTO links (name, txt, url)
VALUES ('vue','Vue in book', 'https://v2-4-techelevator-book.netlify.app/content/intro-to-vue-and-data-binding.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('vue', (SELECT r_id FROM responses WHERE title = 'vue'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'vue'), (SELECT l_id FROM links WHERE name ILIKE 'vue'));

INSERT INTO responses (title, description)
VALUES ('router', 'Helps link between the browsers URL/History and Vues components allowing for certain paths to render whatever view is associated with it.');
INSERT INTO links (name, txt, url)
VALUES ('router','Router in book', 'https://v2-4-techelevator-book.netlify.app/content/vue-router.html#getting-started-with-vue-router');
INSERT INTO keywords (keyword, r_id)
VALUES ('router', (SELECT r_id FROM responses WHERE title = 'router'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'router'), (SELECT l_id FROM links WHERE name ILIKE 'router'));

INSERT INTO responses (title, description)
VALUES ('sql', 'Short for Structured Query Language, SQL, originally known as SEQUEL (structured English query language), was developed by Dr. Edgar F. Codd at the IBM research center in 1974. Today, SQL has become the de facto standard database language.');
INSERT INTO links (name, txt, url)
VALUES ('sql','SQL in book', 'https://v2-4-techelevator-book.netlify.app/content/introduction-to-SQL.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('sql', (SELECT r_id FROM responses WHERE title = 'sql'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'sql'), (SELECT l_id FROM links WHERE name ILIKE 'sql'));

INSERT INTO responses (title, description)
VALUES ('joins', 'Used to combine data or rows from two or more tables based on a common field between them.');
INSERT INTO links (name, txt, url)
VALUES ('joins','SQL joins in book', 'https://v2-4-techelevator-book.netlify.app/content/sql-joins.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('joins', (SELECT r_id FROM responses WHERE title = 'joins'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'joins'), (SELECT l_id FROM links WHERE name ILIKE 'joins'));

INSERT INTO responses (title, description)
VALUES ('insert', 'The INSERT INTO statement is used to insert new records in a table.');
INSERT INTO links (name, txt, url)
VALUES ('insert','Inserting in book', 'https://v2-4-techelevator-book.netlify.app/content/inserts-updates-deletes.html#inserting-new-rows');
INSERT INTO keywords (keyword, r_id)
VALUES ('insert', (SELECT r_id FROM responses WHERE title = 'insert'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'insert'), (SELECT l_id FROM links WHERE name ILIKE 'insert'));

INSERT INTO responses (title, description)
VALUES ('updating', 'The UPDATE statement is used to modify the existing records in a table.');
INSERT INTO links (name, txt, url)
VALUES ('updating','Updating in book', 'https://v2-4-techelevator-book.netlify.app/content/inserts-updates-deletes.html#updating-existing-rows');
INSERT INTO keywords (keyword, r_id)
VALUES ('updating', (SELECT r_id FROM responses WHERE title = 'updating'));
INSERT INTO keywords (keyword, r_id)
VALUES ('update', (SELECT r_id FROM responses WHERE title = 'updating'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'updating'), (SELECT l_id FROM links WHERE name ILIKE 'updating'));

INSERT INTO responses (title, description)
VALUES ('deleting', 'The DELETE statement is used to delete existing records in a table.');
INSERT INTO links (name, txt, url)
VALUES ('deleting','Deleting in book', 'https://v2-4-techelevator-book.netlify.app/content/inserts-updates-deletes.html#deleting-rows');
INSERT INTO keywords (keyword, r_id)
VALUES ('deleting', (SELECT r_id FROM responses WHERE title = 'deleting'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'deleting'), (SELECT l_id FROM links WHERE name ILIKE 'deleting'));

INSERT INTO responses (title, description)
VALUES ('relational', 'A type of database that stores and provides access to data points that are related to one another.');
INSERT INTO links (name, txt, url)
VALUES ('relational','Realtional database design in book', 'https://v2-4-techelevator-book.netlify.app/content/relational-database-design.html#building-a-sample-application-tach-escalator');
INSERT INTO keywords (keyword, r_id)
VALUES ('relational', (SELECT r_id FROM responses WHERE title = 'relational'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'relational'), (SELECT l_id FROM links WHERE name ILIKE 'relational'));

INSERT INTO responses (title, description)
VALUES ('dao', 'An object-based data access interface that provides access to SQL data sources through VBA.');
INSERT INTO links (name, txt, url)
VALUES ('dao','DAO pattern in book', 'https://v2-4-techelevator-book.netlify.app/content/dao-pattern.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('dao', (SELECT r_id FROM responses WHERE title = 'dao'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'dao'), (SELECT l_id FROM links WHERE name ILIKE 'dao'));

INSERT INTO responses (title, description)
VALUES ('git', 'Git is a version control system for tracking changes in computer files and coordinating work on those files among multiple people. Developers primarily use Git for source code management in software development. You can also use it to keep track of changes in any set of files.');
INSERT INTO links (name, txt, url)
VALUES ('git', 'Version control with Git', 'https://v2-4-techelevator-book.netlify.app/content/introduction-to-tools.html#version-control-with-git');
INSERT INTO keywords (keyword, r_id)
VALUES ('git', (SELECT r_id FROM responses WHERE title = 'git'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'git'), (SELECT l_id FROM links WHERE name ILIKE 'git'));

INSERT INTO responses (title, description)
VALUES ('tech event', 'PA Tech Events hosted by Eventbrite:');
INSERT INTO links (name, txt, url)
VALUES ('tech event', 'Eventbrite with PA Tech events', 'https://www.eventbrite.com/d/pa--pittsburgh/tech-events/');
INSERT INTO keywords (keyword, r_id)
VALUES ('tech event', (SELECT r_id FROM responses WHERE title = 'tech event'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'tech event'), (SELECT l_id FROM links WHERE name ILIKE 'tech event'));

INSERT INTO responses (title, description)
VALUES ('jobs', 'PGH Career Connector:');
INSERT INTO links (name, txt, url)
VALUES ('jobs', 'PGH Career Connector', 'https://www.pghcareerconnector.com/jobs/');
INSERT INTO keywords (keyword, r_id)
VALUES ('jobs', (SELECT r_id FROM responses WHERE title = 'jobs'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'jobs'), (SELECT l_id FROM links WHERE name ILIKE 'jobs'));

INSERT INTO responses (title, description, img_text, img_url)
VALUES ('snek', 'This snek lives with Roman, one of my creators!', 'snekky boi', 'http://localhost:8080/images/snek.jpg');
INSERT INTO keywords (keyword, r_id)
VALUES ('snek', (SELECT r_id FROM responses WHERE title = 'snek'));

INSERT INTO responses (title, description, img_text, img_url)
VALUES ('gundam', 'Roman, one of my creators, made this gundam figurine:', 'Gundams!', 'http://localhost:8080/images/gundam.jpg');
INSERT INTO keywords (keyword, r_id)
VALUES ('gundam', (SELECT r_id FROM responses WHERE title = 'gundam'));

INSERT INTO responses (title, description)
VALUES ('tools', 'Introduction to Tools for object oriented programming.');
INSERT INTO links (name, txt, url)
VALUES ('tools','Intro to Tools in book', 'https://v2-4-techelevator-book.netlify.app/content/introduction-to-tools.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('tools', (SELECT r_id FROM responses WHERE title = 'tools'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'tools'), (SELECT l_id FROM links WHERE name ILIKE 'tools'));

INSERT INTO responses (title, description)
VALUES ('branching', 'Statements used to jump the flow of execution from one part of a program to another.');
INSERT INTO links (name, txt, url)
VALUES ('branching','Logical Branching in book', 'https://v2-4-techelevator-book.netlify.app/content/logical-branching-ool.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('branching', (SELECT r_id FROM responses WHERE title = 'branching'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'branching'), (SELECT l_id FROM links WHERE name ILIKE 'branching'));

INSERT INTO responses (title, description)
VALUES ('objects', 'An object is an in-memory data structure that combines state and behavior into a usable and useful abstraction. In other words, objects are a collection of variables and methods.');
INSERT INTO links (name, txt, url)
VALUES ('objects','Intro to Objects in book', 'https://v2-4-techelevator-book.netlify.app/content/introduction-to-objects-ool.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('objects', (SELECT r_id FROM responses WHERE title = 'objects'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'objects'), (SELECT l_id FROM links WHERE name ILIKE 'objects'));

INSERT INTO responses (title, description)
VALUES ('unit testing', 'Testing the smaller units of your application, like classes and methods.');
INSERT INTO links (name, txt, url)
VALUES ('unit testing','Unit Testing in book', 'https://v2-4-techelevator-book.netlify.app/content/unit-testing-ool.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('unit testing', (SELECT r_id FROM responses WHERE title = 'unit testing'));
INSERT INTO keywords (keyword, r_id)
VALUES ('junit', (SELECT r_id FROM responses WHERE title = 'unit testing'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'unit testing'), (SELECT l_id FROM links WHERE name ILIKE 'unit testing'));

INSERT INTO responses (title, description)
VALUES ('error handling', 'The powerful mechanism to handle the runtime errors so that the normal flow of the application can be maintained.');
INSERT INTO links (name, txt, url)
VALUES ('error handling','Error Handling in book', 'https://v2-4-techelevator-book.netlify.app/content/exception-handling-ool.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('error handling', (SELECT r_id FROM responses WHERE title = 'error handling'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'error handling'), (SELECT l_id FROM links WHERE name ILIKE 'error handling'));

INSERT INTO responses (title, description)
VALUES ('file io', 'The flow of data that you can either read from, or you can write to.');
INSERT INTO links (name, txt, url)
VALUES ('file io','File I/O in book', 'https://v2-4-techelevator-book.netlify.app/content/file-io-ool.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('file io', (SELECT r_id FROM responses WHERE title = 'file io'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'file io'), (SELECT l_id FROM links WHERE name ILIKE 'file io'));

INSERT INTO responses (title, description)
VALUES ('api', 'Application programming interface.');
INSERT INTO links (name, txt, url)
VALUES ('api','API in book', 'https://v2-4-techelevator-book.netlify.app/content/web-services-http.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('api', (SELECT r_id FROM responses WHERE title = 'api'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'api'), (SELECT l_id FROM links WHERE name ILIKE 'api'));

INSERT INTO responses (title, description)
VALUES ('get', 'Using RestTemplate, you can make a basic HTTP GET request to the ExchangeRate-API.');
INSERT INTO links (name, txt, url)
VALUES ('get','Consuming web API GET in book', 'https://v2-4-techelevator-book.netlify.app/content/web-services-consuming-get.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('get', (SELECT r_id FROM responses WHERE title = 'get'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'get'), (SELECT l_id FROM links WHERE name ILIKE 'get'));

INSERT INTO responses (title, description)
VALUES ('post', 'Ways to interact with web APIs that create, update, and delete data.');
INSERT INTO links (name, txt, url)
VALUES ('post','POST PUT and DELETE in book', 'https://v2-4-techelevator-book.netlify.app/content/web-services-consuming-post.html');
INSERT INTO keywords (keyword, r_id)
VALUES ('post', (SELECT r_id FROM responses WHERE title = 'post'));
INSERT INTO keywords (keyword, r_id)
VALUES ('put', (SELECT r_id FROM responses WHERE title = 'post'));
INSERT INTO keywords (keyword, r_id)
VALUES ('delete', (SELECT r_id FROM responses WHERE title = 'post'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'post'), (SELECT l_id FROM links WHERE name ILIKE 'post'));

INSERT INTO responses (title, description)
VALUES ('mvc', 'The Model-View-Controller pattern is used to separate application concerns.');
INSERT INTO links (name, txt, url)
VALUES ('mvc','MVC in book', 'https://v2-4-techelevator-book.netlify.app/content/exclusive/java/server-side-api-1-java.html#introduction-to-mvc');
INSERT INTO keywords (keyword, r_id)
VALUES ('mvc', (SELECT r_id FROM responses WHERE title = 'mvc'));
INSERT INTO responses_links (r_id, l_id)
VALUES ((SELECT r_id FROM responses WHERE title = 'mvc'), (SELECT l_id FROM links WHERE name ILIKE 'mvc'));



-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER final_capstone_owner
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO final_capstone_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_owner;

CREATE USER final_capstone_appuser
WITH PASSWORD 'finalcapstone';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO final_capstone_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_appuser;