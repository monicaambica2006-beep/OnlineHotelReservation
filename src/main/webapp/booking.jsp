<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><title>Booking</title></head><body>
<h1>Complete Your Reservation</h1>
<form action="payment.jsp" method="post">
  <label>Guest Name</label><input name="guestName" required><br><br>
  <label>Email</label><input type="email" name="guestEmail" required><br><br>
  <label>Hotel Name</label><input name="hotelName" required><br><br>
  <label>Amount</label><input type="number" step="0.01" name="amount" required><br><br>
  <label>Payment Method</label>
  <select name="paymentMethod">
    <option>Credit Card</option><option>UPI</option><option>PayPal</option><option>Net Banking</option>
  </select><br><br>
  <button type="submit">Pay & Confirm</button>
</form>
</body></html>