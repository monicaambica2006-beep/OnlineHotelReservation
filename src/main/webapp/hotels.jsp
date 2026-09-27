<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document" %>
<!DOCTYPE html><html><head><title>Hotels</title></head><body>
<h1>LuxeStay Hotels</h1>
<%
try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
    MongoDatabase db = client.getDatabase("hotelReservationDB");
    MongoCollection<Document> hotels = db.getCollection("hotels");
    for (Document hotel : hotels.find()) {
%>
<div>
  <h3><%= hotel.getString("name") %></h3>
  <p><%= hotel.getString("location") %></p>
  <p>$<%= hotel.get("pricePerNight") %> / night</p>
</div>
<%
    }
} catch (Exception e) {
    out.println("<p>MongoDB connection error: " + e.getMessage() + "</p>");
}
%>
</body></html>