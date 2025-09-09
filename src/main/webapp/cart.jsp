<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Murach's Java Servlets and JSP</title>
  <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>
<h1>Your cart</h1>
<table>
  <tr><th>Quantity</th><th>Description</th><th>Price</th><th>Amount</th><th>&nbsp;</th></tr>
  <c:forEach var="item" items="${cart.items}">
    <tr>
      <td>
        <form action="cart" method="post">
          <input type="hidden" name="productCode" value="${item.product.code}">
          <input type="number" name="quantity" value="${item.quantity}" min="0">
          <input type="submit" value="Update">
        </form>
      </td>
      <td>${item.product.description}</td>
      <td>${item.product.priceCurrencyFormat}</td>
      <td>${item.totalCurrencyFormat}</td>
      <td>
        <form action="cart" method="post">
          <input type="hidden" name="productCode" value="${item.product.code}">
          <input type="hidden" name="quantity" value="0">
          <input type="submit" value="Remove Item">
        </form>
      </td>
    </tr>
  </c:forEach>
</table>

<form action="index.jsp" method="post">
  <input type="submit" value="Continue Shopping">
</form>
<form action="checkout.jsp" method="post">
  <input type="submit" value="Checkout">
</form>
</body>
</html>
