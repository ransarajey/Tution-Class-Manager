-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2020 at 07:30 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tuitionclass`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendence`
--

CREATE TABLE `attendence` (
  `AttID` int(20) NOT NULL,
  `RegID` int(8) NOT NULL,
  `DateID` int(8) NOT NULL,
  `AttStatus` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendence`
--

INSERT INTO `attendence` (`AttID`, `RegID`, `DateID`, `AttStatus`) VALUES
(4, 10046, 6, 0),
(5, 10046, 6, 1),
(6, 10046, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `classdates`
--

CREATE TABLE `classdates` (
  `DateID` int(8) NOT NULL,
  `ClassID` int(8) NOT NULL,
  `ClassDate` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classdates`
--

INSERT INTO `classdates` (`DateID`, `ClassID`, `ClassDate`) VALUES
(6, 1, '2020-01-17 04:10:41');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `ClassID` int(8) NOT NULL,
  `Grade` int(2) NOT NULL,
  `Subject` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`ClassID`, `Grade`, `Subject`) VALUES
(1, 12, 'Physics'),
(2, 12, 'Business'),
(3, 12, 'SFT');

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `FeesID` int(8) NOT NULL,
  `ClassID` int(8) NOT NULL,
  `RegID` int(8) NOT NULL,
  `Month` text NOT NULL,
  `Amount` varchar(20) NOT NULL,
  `Payment_Status` varchar(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fees`
--

INSERT INTO `fees` (`FeesID`, `ClassID`, `RegID`, `Month`, `Amount`, `Payment_Status`) VALUES
(6, 1, 10046, '1', '500', '1'),
(7, 1, 10057, '1', '500', '1'),
(10, 1, 10046, '1', '500', '1');

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `MID` int(8) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `managers`
--

INSERT INTO `managers` (`MID`, `Username`, `Password`) VALUES
(1, 'superuser', 'superuser123');

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE `parents` (
  `RegID` int(8) NOT NULL,
  `PName` varchar(20) NOT NULL,
  `Email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parents`
--

INSERT INTO `parents` (`RegID`, `PName`, `Email`) VALUES
(10046, 'Saman', 'saman@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `fName` varchar(20) NOT NULL,
  `lName` varchar(20) NOT NULL,
  `NIC` varchar(12) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Mobile` varchar(10) NOT NULL,
  `RegID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`fName`, `lName`, `NIC`, `Address`, `Mobile`, `RegID`) VALUES
('Ransara', 'Wijayasundara', '982750164V', 'Gampaha', '0763016956', 10046),
('Kasun', 'Rukmaldeniya', '1995565171', 'Bandarawela', '0713121313', 10057);

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_fees`
-- (See below for the actual view)
--
CREATE TABLE `student_fees` (
`RegID` int(8)
,`FeesID` int(8)
,`ClassID` int(8)
,`fName` varchar(20)
,`lName` varchar(20)
,`Address` varchar(50)
,`Mobile` varchar(10)
,`Month` text
,`Amount` varchar(20)
,`Payment_status` varchar(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_parent`
-- (See below for the actual view)
--
CREATE TABLE `student_parent` (
`RegID` int(8)
,`fName` varchar(20)
,`lName` varchar(20)
,`NIC` varchar(12)
,`Address` varchar(50)
,`Mobile` varchar(10)
,`PName` varchar(20)
,`Email` varchar(20)
);

-- --------------------------------------------------------

--
-- Structure for view `student_fees`
--
DROP TABLE IF EXISTS `student_fees`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_fees`  AS  select `a`.`RegID` AS `RegID`,`b`.`FeesID` AS `FeesID`,`b`.`ClassID` AS `ClassID`,`a`.`fName` AS `fName`,`a`.`lName` AS `lName`,`a`.`Address` AS `Address`,`a`.`Mobile` AS `Mobile`,`b`.`Month` AS `Month`,`b`.`Amount` AS `Amount`,`b`.`Payment_Status` AS `Payment_status` from (`students` `a` left join `fees` `b` on(`a`.`RegID` = `b`.`RegID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `student_parent`
--
DROP TABLE IF EXISTS `student_parent`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_parent`  AS  select `a`.`RegID` AS `RegID`,`a`.`fName` AS `fName`,`a`.`lName` AS `lName`,`a`.`NIC` AS `NIC`,`a`.`Address` AS `Address`,`a`.`Mobile` AS `Mobile`,`b`.`PName` AS `PName`,`b`.`Email` AS `Email` from (`students` `a` join `parents` `b` on(`a`.`RegID` = `b`.`RegID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendence`
--
ALTER TABLE `attendence`
  ADD PRIMARY KEY (`AttID`),
  ADD KEY `StudentAttendence` (`RegID`),
  ADD KEY `ClassAttendence` (`DateID`);

--
-- Indexes for table `classdates`
--
ALTER TABLE `classdates`
  ADD PRIMARY KEY (`DateID`),
  ADD KEY `ClassID` (`ClassID`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`ClassID`);

--
-- Indexes for table `fees`
--
ALTER TABLE `fees`
  ADD PRIMARY KEY (`FeesID`),
  ADD KEY `ClassID` (`ClassID`),
  ADD KEY `RegID` (`RegID`);

--
-- Indexes for table `managers`
--
ALTER TABLE `managers`
  ADD PRIMARY KEY (`MID`);

--
-- Indexes for table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`RegID`,`PName`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`RegID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendence`
--
ALTER TABLE `attendence`
  MODIFY `AttID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `classdates`
--
ALTER TABLE `classdates`
  MODIFY `DateID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `ClassID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fees`
--
ALTER TABLE `fees`
  MODIFY `FeesID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `managers`
--
ALTER TABLE `managers`
  MODIFY `MID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `RegID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10058;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendence`
--
ALTER TABLE `attendence`
  ADD CONSTRAINT `ClassAttendence` FOREIGN KEY (`DateID`) REFERENCES `classdates` (`DateID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `StudentAttendence` FOREIGN KEY (`RegID`) REFERENCES `students` (`RegID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `classdates`
--
ALTER TABLE `classdates`
  ADD CONSTRAINT `classdates_ibfk_1` FOREIGN KEY (`ClassID`) REFERENCES `classes` (`ClassID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fees`
--
ALTER TABLE `fees`
  ADD CONSTRAINT `fees_ibfk_1` FOREIGN KEY (`ClassID`) REFERENCES `classes` (`ClassID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fees_ibfk_2` FOREIGN KEY (`RegID`) REFERENCES `students` (`RegID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `parents`
--
ALTER TABLE `parents`
  ADD CONSTRAINT `Student_Parent` FOREIGN KEY (`RegID`) REFERENCES `students` (`RegID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
