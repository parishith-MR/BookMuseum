<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <script src="javascript.js" defer></script>
    <title>Museum Website</title>
    <style>
    body{
         background: linear-gradient(to right, #f5f5dc, #F5F5CC);
        border-color: black;
    }
    h1{
        font-size: 50px;
        margin: 1px;
        text-align: center;
        padding: 1px;
    }
	.bookss {
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: center;
	    gap: 20px;
	}
	button{
		color : black;
	}
    p{
        font-size: x-large;
        font-family: 'Times New Roman', Times, serif;
        text-emphasis-color: rgb(80, 27, 148);
    }input[type="submit"]{
    	height : 50px;
    	width : auto;
    	font-size : 15px;
    	border-radius : 10px;
    	background : linear-gradient(to right, #ffff, #ffff);
    }
    .books{
      color: #ffffff;
      background: linear-gradient(to right, #5E936C, #004030);
      height: 400px;
      width:600px;
      border: 3px solid #dfc5c5;
      border-radius: 100px;
      margin: 10px;
      padding: 20px;
      animation: alternate 2s infinite;
      box-shadow: #717171 20px 20px 9px 0px;
      transition : transform 0.3 ease;
    }
    .books:hover{
    	tranform : translateY(-10px);
    }
    img {
      width: 200px;
      height: auto;
      margin: 10px;
      border-radius: 10px;
      float: left;
      box-shadow: #000000 0px 0px 10px;
    }
    .slideshow-container {
      width: 50%;
      margin: 0 auto;
      max-width: 600px;
    }
    </style>
    <script>
    function getBookCount() {
        var bookId = document.getElementById("bookId").value;
        if (bookId === "") {
            alert("Please enter a Book ID");
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "GetBookCount.jsp?bookId=" + bookId, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("result").innerHTML =
                    "Total Books for ID " + bookId + ": " + xhr.responseText;
            }
        };
        xhr.send();
    }
</script>
</head>

<body>
    <h1><u>Book Museum</u></h1>
<details style="font-size : 50px;">
  <summary>Education</summary>
  <ul>
    <li>Java :- Complete Reference</li>
    <li>C :- The Beginner</li>
    <li>C++ :- The Intermediate</li>
  </ul>
</details>
    <p style="font-size : 50px;">Fiction <br> Self-help</p>
    <div class="slideshow-container">
        <div class="mySlides fade">
            <div class="numbertext">1 / 5</div>
            <img src="java.png" style="width:100%">
            <div class="text">FOR THE ADVANCED</div>
        </div>
        <div class="mySlides fade">
            <div class="numbertext">2 / 5</div>
            <img src="c.png" style="width:100%">
            <div class="text">FOR THE BEGINNER</div>
        </div>
        <div class="mySlides fade">
            <div class="numbertext">3 / 5</div>
            <img src="c++.png" style="width:100%">
            <div class="text">FOR THE INTERMEDIATE</div>
        </div>
        <div class="mySlides fade">
            <div class="numbertext">4 / 5</div>
            <img src="python.jpg" style="width:100%">
            <div class="text">FOR THE INTERMEDIATE</div>
        </div>
        <div class="mySlides fade">
            <div class="numbertext">5 / 5</div>
            <img src="javascript.jpg" style="width:100%">
            <div class="text">FOR THE INTERMEDIATE</div>
        </div>
        <a class="prev" onclick="plusSlides(-1)">❮</a>
        <a class="next" onclick="plusSlides(1)">❯</a>
    </div>
    <br>
    <div style="text-align:center">
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
    </div>
    <hr>
    <h1> Hello <%=session.getAttribute("name")%> and Your Email is <%=session.getAttribute("email") %></h1><br/>
    <div class=bookss>
    
<%
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/museum", "root", "root");
		Statement stm = con.createStatement();
		ResultSet rs = stm.executeQuery("Select * from books");
		while(rs.next()){
%>
<div class="books" style="display='flex';">
    <h2><%=rs.getString("name")%> Book</h2>
    <img src="<%= rs.getString("src")%>" alt="book image">
    <p><%= rs.getString("description")%></p>
    <p> In stock: <%= rs.getString("stock")%></p>
    <p> Price: <%= rs.getString("price")%></p>
    <form action="AddToCart" method="post">
        <input type="hidden" name="bookId" value= "<%= rs.getInt("id") %>">
        <input type="submit" value="Add to Cart">
    </form>
    <details>
        <summary>More Info</summary>
        Author: <%= rs.getString("author")%><br>
        Publication Year: <%= rs.getString("publicationyear")%><br>
        Pages: <%= rs.getString("pages")%>
    </details>
</div>
<%
		}
	}catch(Exception e){
		%>
		<p> Error occured.....</p>
		<%
	}
%>
	</div>
    <hr>
<%@ page import="java.util.*" %>

<%
List<Integer> carts = (List<Integer>) session.getAttribute("cart"); 
if (carts == null || carts.isEmpty()) {
%>
    <h1>Start Learning, Start Buying...</h1>
<%
} else {
%>
    <h2>Your Cart</h2>
    <ol>
    <%
        for (Integer itemId : carts) {
    %>
        <li>
    Book ID: <%= itemId %>
    <form action="RemoveFromCart" method="post" style="display:inline;">
        <input type="hidden" name="bookId" value="<%= itemId %>">
        <input type="submit" value="Remove">
	</form>
	</li>

    <%
        }
    %>
    </ol>
    <form action="PlaceOrderConfirm" method="post" style="display:inline;">
        <input type="hidden">
        <input type="submit" value="Place Order Confirm">
	</form>
<%
}
%>
<a href="orders.jsp"> <button> Show Total Orders </button> </a> 
<!--  
<object type="text/xml" data="feedback.xml" width="100%" height="400px"></object>
 -->
<div id="feedbackArea">Loading feedback...</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
  $.ajax({
    url: "feedback.xml",
    dataType: "xml",
    success: function(xml) {
      $.ajax({
        url: "feedback.xsl",
        dataType: "xml",
        success: function(xsl) {
          if (window.ActiveXObject || "ActiveXObject" in window) {
            const ex = xml.transformNode(xsl);
            $("#feedbackArea").html(ex);
          } else if (document.implementation && document.implementation.createDocument) {
            const xsltProcessor = new XSLTProcessor();
            xsltProcessor.importStylesheet(xsl);
            const resultDoc = xsltProcessor.transformToFragment(xml, document);
            $("#feedbackArea").html(resultDoc);
          }
        },
        error: function() {
          $("#feedbackArea").text("Error loading XSL file.");
        }
      });
    },
    error: function() {
      $("#feedbackArea").text("Error loading XML file.");
    }
  });
});
</script>
    <h3>Check Book Count by ID</h3>
    <input type="text" id="bookId" placeholder="Enter Book ID">
    <button onclick="getBookCount()">Get Count</button>
    <div id="result" style="margin-top:10px; font-weight:bold; color:green;"> </div>
</body>		
</html>