-- Автори
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    AuthorName VARCHAR(255) NOT NULL UNIQUE,
    BirthYear INT,
    DeathYear INT,
    Biography TEXT
);

-- Категорії книг (ієрархія)
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    ParentCategoryID INT NULL,
    Description TEXT NULL,
    FOREIGN KEY (ParentCategoryID)
        REFERENCES Categories(CategoryID)
        ON DELETE SET NULL
);

-- Книги
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryID INT,  
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublicationYear INT,
    Description TEXT,
    Language VARCHAR(50),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL
);

-- Звязок книжок з аторами
CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Користувачі бібліотеки
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    MemberName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    PhoneNumber BIGINT
);

-- Примірники книжок
CREATE TABLE BookCopies (
    CopyID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT NOT NULL,
    CopyStatus ENUM('available', 'borrowed', 'reserved', 'damaged', 'lost', 'maintenance') NOT NULL DEFAULT 'available',
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);

-- Отримані книжки
CREATE TABLE Borrowings (
    BorrowingID INT PRIMARY KEY AUTO_INCREMENT,
    CopyID INT NOT NULL, 
    MemberID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    FOREIGN KEY (CopyID) REFERENCES BookCopies(CopyID) ON DELETE RESTRICT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE RESTRICT
);

-- Резерування книжок
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    ReservationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    ReservationStatus ENUM('pending', 'available', 'fulfilled', 'cancelled', 'expired') NOT NULL DEFAULT 'pending',
    Notes TEXT NULL, 
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE, 
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE 
);

-- Відгуки про книжки
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
    ReviewText TEXT NULL, 
    ReviewDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE, 
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE 
);
