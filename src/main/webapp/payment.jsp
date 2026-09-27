<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document, java.util.Date, java.util.UUID" %>
<%
String guestName = request.getParameter("guestName");
String guestEmail = request.getParameter("guestEmail");
String hotelName = request.getParameter("hotelName");
String amountText = request.getParameter("amount");
String paymentMethod = request.getParameter("paymentMethod");

try {
    double amountPaid = Double.parseDouble(amountText);
    String bookingId = "BK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

    try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
        MongoDatabase db = client.getDatabase("hotelReservationDB");
        db.getCollection("bookings").insertOne(new Document()
            .append("bookingId", bookingId)
            .append("guestName", guestName)
            .append("guestEmail", guestEmail)
            .append("hotelName", hotelName)
            .append("amountPaid", amountPaid)
            .append("paymentMethod", paymentMethod)
            .append("paymentStatus", "COMPLETED")
            .append("createdAt", new Date()));
    }
    response.sendRedirect("confirmation.jsp?bookingId=" + bookingId);
} catch (Exception e) {
%>
<h2>Payment failed</h2><p><%= e.getMessage() %></p>
<%
}
%>