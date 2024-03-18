create database ShoesManagement

use ShoesManagement

create table category(
	id int primary key identity(1,1),
	category_name nvarchar(100) not null
)

create table customer(
	id int primary key identity(1,1),
	first_name nvarchar(50) not null,
	last_name nvarchar(50) not null,
	[address] nvarchar(250),
	province nvarchar(30),
	district nvarchar(30),
	ward nvarchar(30),
	email varchar(100) not null,
	password varchar(50) not null
)

create table shoes(
	num_model int primary key identity(1, 1),
	[name] nvarchar(100) not null,
	[image] varchar(200) not null,
	price decimal(20, 2) not null,
	[description] nvarchar(500) not null,
	cartegory_id int references category(id) on delete cascade,
)

create table product(
	num_model int references shoes(num_model) on delete cascade,
	size int,
	amount int not null,
	primary key(num_model, size)
)

create table cart(
	num_model int references shoes(num_model) on delete cascade,
	customer_id int references customer(id),
	amount int not null,
	price decimal(20, 2) not null,
	size int
	primary key(num_model, customer_id)
)

create table [orders] (
	order_id int primary key identity(1, 1),
	customer_id int references customer(id),
	[address] nvarchar(500) not null,
	order_date date not null,
	[status] varchar(30) not null
)

create table order_details(
	order_id int references orders(order_id) on delete cascade,
	num_model int references shoes(num_model) on delete cascade,
	amount int not null,
	price decimal(20, 2) not null,
	size int
	primary key (order_id, num_model)
)

-- insert to category
insert into category values('Lifestyle')
insert into category values('Running')
insert into category values('Basketball')
insert into category values('Football')
insert into category values('Gym and Training')

-- insert to shoes
insert into shoes values('Nike Air Force 1"7', 'air-force-1-shoes.png', 115, 'The radiance lives on in the Nike Air Force 1"07, the basketball original that puts a fresh spin on what you know best: durably stitched overlays, clean finishes and the perfect amount of flash to make you shine.', 1)
insert into shoes values('Nike Air Max 90 SE', 'air-max-90-se-shoes-FQ39pC.png', 167.49, 'Nothing as fly, nothing as comfortable, nothing as proven. This special edition Nike Air Max 90 stays true to its running roots with an iconic Waffle sole, stitched overlays and classic moulded plastic details. The earthy but neutral colours celebrate your fresh look, while Max Air cushioning adds comfort to the journey.', 1)
insert into shoes values('Nike Court Vision Low Next Nature', 'court-vision-low-next-nature-shoes-N2fFHb.png', 77.81, 'In love with the classic look of ''80s basketball but have a thing for the fast-paced culture of today''s game? Meet the Nike Court Vision Low. A classic remixed with at least 20% recycled materials by weight, its crisp upper and stitched overlays keep the soul of the original style. The plush, low-cut collar keeps it sleek and comfortable for your world.', 1)
insert into shoes values('Nike Structure 25', 'structure-25-road-running-shoes-Vnp1d0.png', 156, 'With stability where you need it and cushion where you want it, the Structure 25 supports you for long miles, short training runs and even a down-and-back before the day ends. It''s the stability you seek, loyal from the first tie-up, tried and tested, with a midfoot system that''s fully supportive and with more comfortable cushioning than before.', 2)

-- insert to product
insert into product values(2, 39, 100)
insert into product values(2, 40, 0)
insert into product values(2, 41, 100)
insert into product values(2, 42, 0)
insert into product values(2, 43, 0)
insert into product values(2, 44, 0)
insert into product values(3, 39, 100)
insert into product values(3, 40, 0)
insert into product values(3, 41, 0)
insert into product values(3, 42, 0)
insert into product values(3, 43, 0)
insert into product values(3, 44, 0)
insert into product values(4, 39, 0)
insert into product values(4, 40, 100)
insert into product values(4, 41, 0)
insert into product values(4, 42, 0)
insert into product values(4, 43, 0)
insert into product values(4, 44, 0)
insert into product values(1, 39, 0)
insert into product values(1, 40, 0)
insert into product values(1, 41, 0)
insert into product values(1, 42, 0)
insert into product values(1, 44, 100)
insert into product values(1, 43, 100)
