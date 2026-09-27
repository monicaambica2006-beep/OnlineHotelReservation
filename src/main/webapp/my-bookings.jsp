<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document" %>
<!DOCTYPE html><html><head><title>My Bookings</title></head><body>
<h1>My Reservations</h1>
<%
try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
    MongoDatabase db = client.getDatabase("hotelReservationDB");
    for (Document b : db.getCollection("bookings").find()) {
%>
<div>
  <b><%= b.getString("bookingId") %></b>
  <span><%= b.getString("hotelName") %></span>
  <span><%= b.get("amountPaid") %></span>
  <span><%= b.getString("paymentStatus") %></span>
</div><hr>
<%
    }
} catch (Exception e) { out.println("MongoDB error: " + e.getMessage()); }
%>
<a href="index.jsp">Home</a>
</body></html>