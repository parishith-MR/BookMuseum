<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>Feedback Summary</title>
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
        <h2>Feedback Table</h2>
        <table>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Comments</th>
            <th>Ratings</th>
          </tr>
          <xsl:for-each select="feedbacks/feedback[rating &gt; 3]">
            <tr>
              <td><xsl:value-of select="name"/></td>
              <td><xsl:value-of select="email"/></td>
              <td><xsl:value-of select="comments"/></td>
              <td><xsl:value-of select="rating"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
