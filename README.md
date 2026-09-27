# LuxeStay Online Hotel Reservation System

## Folder structure

OnlineHotelReservation/
├── pom.xml
├── README.md
└── src/main/webapp/
    ├── index.jsp
    ├── hotels.jsp
    ├── hotel-details.jsp
    ├── booking.jsp
    ├── payment.jsp
    ├── confirmation.jsp
    ├── my-bookings.jsp
    ├── admin/dashboard.jsp
    ├── css/style.css
    ├── js/app.js
    ├── data/hotels.json
    ├── data/bookings.json
    └── WEB-INF/web.xml

## Run in VS Code

1. Install JDK 11 or newer, Maven, MongoDB Community Server, and Apache Tomcat 9.
2. Start MongoDB.
3. Open this folder in VS Code.
4. Build with:
   mvn clean package
5. Copy target/OnlineHotelReservation.war to Tomcat's webapps folder.
6. Start Tomcat.
7. Open:
   http://localhost:8080/OnlineHotelReservation/

## MongoDB

Database: hotelReservationDB
Collections:
- hotels
- bookings

The main interactive page is index.jsp. It keeps the original LuxeStay UI from the supplied prototype. The separate JSP files demonstrate direct JSP-to-MongoDB operations.
