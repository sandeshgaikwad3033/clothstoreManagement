<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %><html>
    <head>
</head>
<body>
    
<form id="reportForm">
  <label for="reportType">Select Report Type:</label>
  <select id="reportType" name="reportType">
    <option value="totalStock">Total Stock</option>
    <option value="outStock">Out of Stock</option>
    <option value="lowestStock">Lowest Stock</option>
    <!-- Add more options as needed -->
  </select>
  
  <label for="startDate">Start Date:</label>
  <input type="date" id="startDate" name="startDate">
  
  <label for="endDate">End Date:</label>
  <input type="date" id="endDate" name="endDate">
  
  <button type="submit">Generate Report</button>
</form>

<div id="reportResult">
  <!-- Report results will be displayed here -->
</div>
<script>
    document.getElementById('reportForm').addEventListener('submit', function(event) {
  event.preventDefault(); // Prevent form submission
  
  // Get selected options and date range
  var reportType = document.getElementById('reportType').value;
  var startDate = document.getElementById('startDate').value;
  var endDate = document.getElementById('endDate').value;
  
  // Send AJAX request to server to generate report
  // Replace this with actual logic to fetch and display report data
  
  // For demonstration purposes, just displaying the selected options
  var reportResult = Generating ${reportType} report from ${startDate} to ${endDate};
  document.getElementById('reportResult').innerText = reportResult;
});
</script>
</body>
</html>