<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document" %>
<!DOCTYPE html><html><head><title>Admin Dashboard</title></head><body>
<h1>LuxeStay Admin Dashboard</h1>
<%
try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
    MongoDatabase db = client.getDatabase("hotelReservationDB");
    long hotels = db.getCollection("hotels").countDocuments();
    long bookings = db.getCollection("bookings").countDocuments();
%>
<p>Hotels Listed: <b><%= hotels %></b></p>
<p>Total Reservations: <b><%= bookings %></b></p>
<h2>Bookings</h2>
<%
for (Document b : db.getCollection("bookings").find()) {
%>
<p><%= b.getString("bookingId") %> | <%= b.getString("guestName") %> | <%= b.get("amountPaid") %> | <%= b.getString("paymentStatus") %></p>
<%
}
} catch (Exception e) { out.println("MongoDB error: " + e.getMessage()); }
%>
<a href="../index.jsp">Home</a>
</body></html>