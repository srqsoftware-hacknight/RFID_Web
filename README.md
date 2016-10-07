# Fab Lab Door Project Notes

# Prerequisites

There are a few packages that you should have installed before attempting to work on the project:

1. `Node.js` - The NodeJS runtime
2. `npm` - NodeJS package manager; used to install project dependencies
3. `maven` - Java build tool and package manager
4. `bower` - JavaScript package manager
5. `karma` - JavaScript test runner. (We'll be using the Jasmine Test Framework with this.)
6. Java 8

If you're using a Mac, the best way to install the prerequisites is via brew. On Linux, apt-get should be able to install them as well.

# Summary

Steps for building the project:

1. Clone the repository (via git)
2. Navigate to the directory RFID_Web
3. Install bower and npm related dependencies.
    - Navigate to the src/main/webapp directory and type the following:
    - `bower install`
    - `npm install -g jasmine-core`
    - `npm install -g karma-jasmine`
    - `npm install -g phantomjs`
    - `npm install -g karma-phantomjs-launcher`
4. Navigate back to the root directory and type `mvn package`
5. To run the code, type: `java -jar target/rfid-web-0.1.0.jar`
6. Launch the following url:
http://localhost:8080/test/Chris?isExcited=y
7. You can test omitting the parameter as well:
http://localhost:8080/test/Chris
8. Run the web unit tests by navigating to the test directory and typing: `karma start`

# Components

1. Door assembly  -- physical and electronic controls, one per door
2. Raspberry Pi system controller
3. Dedicated WiFi network connecting door assemblies and Raspberry Pi (exclusively)
4. Wired access to building Ethernet for Raspberry Pi
5. Raspberry Pi software
6. System documentation (TBD)

# Operational Description

Each door will have a door assembly which controls physical access using an RFID key fob.  Design and operational details appear elsewhere in this document.  There are two ways to challenge the system; using a registered fob, or pressing an entry button.  Either mode causes a request entry message containing the fob id (or button code), the door id (more?) to be pushed to the RPi.  The RPi will either validate or invalidate the request.  In either case a response message containing the result will be sent back to the door assembly for appropriate action.  This interchange will be performed over the dedicated WiFi network, which is reserved for the RPi and access devices.  At this writing, the only access devices contemplated are door assemblies.  Future devices may include tool and/or tool area access.

The RPi will be FTP accessible to accommodate report distribution

The RPi will be a web server accessible through the building Ethernet.  The following functions will be available.

- Login/Logout website users
- Register website user access through username and password.
- Enable/Disable website user access
- Register fob/user
- Enable/Disable fob/user
- Start/Stop activity log
- Dump/Clear activity log
- Create a comprehensive csv system report (essentially a database dump)
- Display/Hide system dashboard

# Web Server Details

## Basic System

The system will run on a RPi 3 Model B.  It will run Raspian Jessie Lite.  The web technology includes Java, Jetty, and Java Server Pages.  A list of software components beyond Raspian Lite will appear here.

## Landing Page

Access thru the URL will cause the landing page to appear.  This will contain logo, welcome, and any other public information.  A navigation element will lead to the login page.

## Login Page

The page will have fields for username and password, and a submit button.  There will be no lost password or username function.  Lost usernames will be retrieved manually from the database.  Password are not recoverable, but can be reset.  There is no enforced change password policy.  Three consecutive failed logins for any single user will result in the user&#39;s account being disabled.

## Main Page

A successful login will land the user on the main page.  This page will contain all navigation to additional functions.  Each function page(s) will have a navigation back to the main page.  Navigation includes;

- Fob user administration (Register/View/Enable/Disable fob user)
- Display the system dashboard
- Web site user administration (Register/View/Enable/Disable/Reset-Pass web user)
- Activity log administration (Start/Stop/View/Dump) activity log
- Report Administration (Generate/Transmit database report)

## Fob User Administration Page

Fred has created a hand mockup for this page.  It is on GitHub

## System Dashboard

This is still in conceptual stage.  It is thought to display the current state of the system, state of the access devices, and notification of access requests (entry button request).  It may also have some operational functions such as approving entry button requests.  It may have navigation similar to the main page to access all other pages.

## Web Site User Administration Page

This may be similar to the fob user administration page.

## Activity Log Page

TBD (Start, Stop, Save old, create new, generate csv report, delete log)

## Report Administration Page

TBD (Generate data base report, time interval specification?  File name specification?)

## Current Design Issues

1. Fob user role and website user role will be kept separate.  The alternative is to create a member role and assign website and fob privileges.
2. There will be one data base report generated by the system.  It will be in CSV format and contain all the information in the database.  If other reports are needed, they will be generated off-line and off-RPi using tools such as Excel
3. There will be one log report generated by the system.  It will be in CSV format and contain the unformatted contents of the activity log.
4. Both reports will be generated to files on the RPi file system.  They will be retrieved using FTP in the standard way.
5. The candidate web server is Jetty and JSP, which needs Java and (maybe) other components.  The FTP server is included in Raspian Lite.
6. The candidate db is MySQL.  Matt has created a schema on GitHub.  A MySQL JDBC driver will be required.
7. Development Strategy:  It would be convenient if we could develop the website off-line (laptop) and then release to the RPi using a WAR file.  We might use Eclipse, Intellij, or Maven.  Maybe using a command line approach is better since the development environment could be the same on the RPi and laptop.  (don&#39;t forget our RPi is headless)
  1. Is Java, Jetty, JSP the right choice.  I am open to suggestions.  The deciding factors are tool familiarity, availability, and ease of maintenance.  Once we hand the site over to the lab, students might be the primary maintainers.  The site is not going to be complex.  Should we try for something simpler (LAMP stack, Rails …)?  Is there anything significantly simpler?
  2. The first step is to find (or write) a simple CRUD example using our selected components.   Install/build this project on a laptop and port it to the RPi.  This proves (or disproves) our idea to do remote development on something other than the RPi.
  3. Decide on a distribution method.  We have the RPi image, which should not change once we get it right.  We have the WAR file (and maybe some other libraries?) that we can FTP to the RPi to release a website version, or write to a thumb drive containing the RPi filesystem.
Rendered
Fab Lab Door Project Notes
Summary
Components
Door assembly -- physical and electronic controls, one per door
Raspberry Pi system controller
Dedicated WiFi network connecting door assemblies and Raspberry Pi (exclusively)
Wired access to building Ethernet for Raspberry Pi
Raspberry Pi software
System documentation (TBD)
Operational Description
Each door will have a door assembly which controls physical access using an RFID key fob. Design and operational details appear elsewhere in this document. There are two ways to challenge the system; using a registered fob, or pressing an entry button. Either mode causes a request entry message containing the fob id (or button code), the door id (more?) to be pushed to the RPi. The RPi will either validate or invalidate the request. In either case a response message containing the result will be sent back to the door assembly for appropriate action. This interchange will be performed over the dedicated WiFi network, which is reserved for the RPi and access devices. At this writing, the only access devices contemplated are door assemblies. Future devices may include tool and/or tool area access.

The RPi will be FTP accessible to accommodate report distribution

The RPi will be a web server accessible through the building Ethernet. The following functions will be available.

Login/Logout website users
Register website user access through username and password.
Enable/Disable website user access
Register fob/user
Enable/Disable fob/user
Start/Stop activity log
Dump/Clear activity log
Create a comprehensive csv system report (essentially a database dump)
Display/Hide system dashboard
Web Server Details
Basic System
The system will run on a RPi 3 Model B. It will run Raspian Jessie Lite. The web technology includes Java, Jetty, and Java Server Pages. A list of software components beyond Raspian Lite will appear here.

Landing Page
Access thru the URL will cause the landing page to appear. This will contain logo, welcome, and any other public information. A navigation element will lead to the login page.

Login Page
The page will have fields for username and password, and a submit button. There will be no lost password or username function. Lost usernames will be retrieved manually from the database. Password are not recoverable, but can be reset. There is no enforced c
