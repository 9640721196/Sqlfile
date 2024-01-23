CREATE DATABASE IF NOT EXISTS MovieBookingSystem;
USE MovieBookingSystem;

show tables;
describe movie;
CREATE TABLE Movie (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255),
    Genre VARCHAR(50),
    Rating VARCHAR(10),
    PosterImage VARCHAR(255),
    StarCastID INT,
    FOREIGN KEY (StarCastID) REFERENCES StarCast(StarCastID)
);

-- StarCast Table
CREATE TABLE StarCast (
    StarCastID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50)
);

-- Review Table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    MovieID INT,
    Content TEXT,
    ReviewDateTime DATETIME,
    ReviewerName VARCHAR(100),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

-- User Table
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(255),
    MembershipStatus BOOLEAN,
    PointsEarned INT
);

-- Transaction Table

CREATE TABLE FoodOrder (
    FoodOrderID INT PRIMARY KEY,
    UserID INT,
    -- other columns
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- FoodItem Table
CREATE TABLE FoodItem (
    FoodItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    Category VARCHAR(50),
    Rate DECIMAL(8, 2),
    Size VARCHAR(20),
    ComboID INT,
    FOREIGN KEY (ComboID) REFERENCES Combo(ComboID)
);

-- Combo Table
CREATE TABLE Combo (
    ComboID INT PRIMARY KEY,
    ComboName VARCHAR(100),
    ComboRate DECIMAL(8, 2)
);

-- FoodOrder Table

CREATE TABLE FoodOrder (
    FoodOrderID INT PRIMARY KEY,
    UserID INT,
    TransactionID INT,
    DeliveryScreen INT,
    DeliverySeat INT,
    OrderDateTime DATETIME,
    DeliveryStatus VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY,
    UserID INT,
    BookingID INT,
    FoodOrderID INT,
    TransactionDateTime DATETIME,
    Amount DECIMAL(10, 2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (FoodOrderID) REFERENCES FoodOrder(FoodOrderID)
);

-- Membership Table
CREATE TABLE Membership (
    MembershipID INT PRIMARY KEY,
    UserID INT,
    MembershipStartDate DATE,
    MembershipEndDate DATE,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- QRCodeUsage Table
CREATE TABLE QRCodeUsage (
    QRCodeUsageID INT PRIMARY KEY,
    UserID INT,
    QRCodeType VARCHAR(20),
    UsageDateTime DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- Screen Table
CREATE TABLE Screen (
    ScreenID INT PRIMARY KEY,
    ScreenName VARCHAR(50),
    Capacity INT,
    Class VARCHAR(10) CHECK (Class IN ('Gold', 'Silver', 'Iron'))
);

-- Show Table
CREATE TABLE  watchingshow (
    watchingShowID INT PRIMARY KEY,
    ScreenID INT,
    ShowTime TIME,
    DayOfWeek VARCHAR(20),
    MovieID INT,
    FOREIGN KEY (ScreenID) REFERENCES Screen(ScreenID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);


-- User Table
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    CreditCardNumber VARCHAR(16),
    PinNumber INT
);

-- Booking Table


CREATE TABLE Booking1 (
    Booking1ID INT PRIMARY KEY,
    UserID INT,
    watchingShowID INT,
    NumberOfTickets INT,
    BookingDate DATE,
    TotalCost DECIMAL(10, 2),
    PaymentGateway VARCHAR(50),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (watchingShowID) REFERENCES watchingshow(watchingShowID)
);
-- Payment Transaction Table
CREATE TABLE PaymentTransaction (
    TransactionID INT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10, 2),
    TransactionDateTime DATETIME,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- QR Code Table
CREATE TABLE QRCode (
    QRCodeID INT PRIMARY KEY,
    BookingID INT,
    QRCodeImage VARCHAR(255),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- Entry Record Table
CREATE TABLE EntryRecord (
    EntryRecordID INT PRIMARY KEY,
    QRCodeID INT,
    EntryDateTime DATETIME,
    FOREIGN KEY (QRCodeID) REFERENCES QRCode(QRCodeID)
);

-- Payment Gateway Table
CREATE TABLE PaymentGateway (
    GatewayID INT PRIMARY KEY,
    GatewayName VARCHAR(50)
);
-- Inserting data into Screen table
INSERT INTO Screen (ScreenID, ScreenName, Capacity, Class) VALUES
(1, 'A', 150, 'Gold'),
(2, 'B', 200, 'Silver'),
(3, 'C', 250, 'Iron'),
(4, 'D', 250, 'Iron');

-- Inserting data into Movie table
INSERT INTO Movie (MovieID, Title, Genre, Rating,PosterImage, StarCastID) VALUES
(1, 'Movie1', 'Action', 'PG-13', 'movie1.jpg', 1),
(2, 'Movie2', 'Comedy', 'R',  'movie2.jpg', 2);
-- Add more movies as needed;

-- Inserting data into StarCast table
INSERT INTO StarCast (StarCastID, Name, Role) VALUES
(1, 'Actor1', 'Lead Actor'),
(2, 'Actor2', 'Supporting Actor');
-- Add more actors as needed;


-- Inserting data into WatchingShow table
INSERT INTO WatchingShow (watchingShowID,ScreenID,ShowTime, DayOfWeek, MovieID) VALUES
(1,5, '10:00:00', 'Monday', 1),
(2, 6,'13:30:00', 'Tuesday', 2),
(3, 67,'17:00:00', 'Wednesday', 3),
(4, 56,'20:30:00', 'Thursday', 4);


-- Inserting data into Review table
INSERT INTO Review (ReviewID, MovieID, Content, ReviewDateTime, ReviewerName) VALUES
(1, 1, 'Great movie!', '2024-01-20 10:30:00', 'Reviewer1'),
(2, 1, 'Could be better', '2024-01-20 11:00:00', 'Reviewer2');
-- Add more reviews as needed;

-- Inserting data into Booking table
INSERT INTO Booking (BookingID, UserID, ShowID, NumberOfTickets, BookingDate, TotalCost, PaymentGateway, PaymentStatus) VALUES
(1, 1, 1, 2, '2024-01-25', 1000, 'PayPal', 'Approved'),
(2, 2, 3, 3, '2024-01-26', 600, 'Bill Desk', 'Approved'),
-- Add more bookings as needed;

-- Inserting data into FoodItem table
INSERT INTO FoodItem (FoodItemID, ItemName, Category, Rate, Size, ComboID) VALUES
(1, 'Popcorn', 'Snack', 100, 'Small', NULL),
(2, 'Pepsi', 'Beverage', 100, 'Small', NULL);
-- Add more food items as needed;

-- Inserting data into Combo table
INSERT INTO Combo (ComboID, ComboName, ComboRate) VALUES
(1, 'Combo1', 250),
(2, 'Combo2', 300),
-- Add more combos as needed;

-- Inserting data into FoodOrder table
INSERT INTO FoodOrder (FoodOrderID, UserID, TransactionID, DeliveryScreen, DeliverySeat, OrderDateTime, DeliveryStatus) VALUES
(1, 1, 1, 1, 10, '2024-01-25 10:45:00', 'Delivered'),
(2, 2, 2, 3, 15, '2024-01-26 15:30:00', 'In Progress'),
-- Add more food orders as needed;

-- Inserting data into Membership table
INSERT INTO Membership (MembershipID, UserID, MembershipStartDate, MembershipEndDate) VALUES
(1, 1, '2024-01-01', '2024-12-31'),
(2, 2, '2024-02-15', '2024-12-31');
-- Add more memberships as needed;


--  insert values into QRCodeusagetableTable
INSERT INTO `moviebookingsystem`.`qrcodeusage` (`QRCodeUsageID`, `UserID`, `QRCodeType`, `UsageDateTime`) VALUES ('32', '5', 'static ', '2024-01-20 08:30:00');
INSERT INTO `moviebookingsystem`.`qrcodeusage` (`QRCodeUsageID`, `UserID`, `QRCodeType`, `UsageDateTime`) VALUES ('23', '6', 'dynamic', '2024-01-12 04:35:00');



