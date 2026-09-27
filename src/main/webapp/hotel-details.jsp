<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document, org.bson.types.ObjectId" %>
<%
String id = request.getParameter("id");
Document hotel = null;
try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
    MongoDatabase db = client.getDatabase("hotelReservationDB");
    if (id != null && ObjectId.isValid(id)) {
        hotel = db.getCollection("hotels").find(new Document("_id", new ObjectId(id))).first();
    }
%>
<!DOCTYPE html><html><head><title>Hotel Details</title></head><body>
<% if (hotel != null) { %>
<h1><%= hotel.getString("name") %></h1>
<p>Location: <%= hotel.getString("location") %></p>
<p>Rating: <%= hotel.get("rating") %></p>
<p>Price: $<%= hotel.get("pricePerNight") %> / night</p>
<a href="booking.jsp?hotelId=<%= id %>">Book Now</a>
<% } else { %>
<h2>Hotel not found</h2>
<% } %>
</body></html>
<%
} catch (Exception e) {
    out.println("MongoDB connection error: " + e.getMessage());
}
%>