<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document" %>
<%
String bookingId = request.getParameter("bookingId");
Document booking = null;
try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
    booking = client.getDatabase("hotelReservationDB").getCollection("bookings")
        .find(new Document("bookingId", bookingId)).first();
%>
<!DOCTYPE html><html><head><title>Booking Confirmed</title></head><body>
<h1>Booking Confirmed!</h1>
<% if (booking != null) { %>
<p>Booking ID: <b><%= booking.getString("bookingId") %></b></p>
<p>Guest: <%= booking.getString("guestName") %></p>
<p>Hotel: <%= booking.getString("hotelName") %></p>
<p>Amount Paid: $<%= booking.get("amountPaid") %></p>
<p>Status: <%= booking.getString("paymentStatus") %></p>
<% } else { %><p>Booking not found.</p><% } %>
<a href="index.jsp">Back to Home</a>
</body></html>
<%
} catch (Exception e) { out.println(e.getMessage()); }
%>