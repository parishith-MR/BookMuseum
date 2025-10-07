<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Orders Greater than 500</title>
        <style>
          table {
            border-collapse: collapse;
            margin: 20px auto;
            width : auto;
          }
          th, td {
            border: 1px solid #333;
            padding: 10px;
            text-align: center;
          }
          th {
            background-color: #4CAF50;
            color: white;
          }
          h2 {
            text-align: center;
          }
        </style>
      </head>
      <body>
        <h2 style="text-align:center;">Orders with Price > 500</h2>
        <table>
          <tr>
            <th>ID</th>
            <th>Price</th>
            <th>Book ID</th>
            <th>Date</th>
            <th>Email</th>
          </tr>
          <xsl:for-each select="orders/order[price &gt; 500]">
            <tr>
              <td><xsl:value-of select="id"/></td>
              <td><xsl:value-of select="price"/></td>
              <td><xsl:value-of select="bookid"/></td>
              <td><xsl:value-of select="date"/></td>
              <td><xsl:value-of select="email"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>