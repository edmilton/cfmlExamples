<cfprocessingdirective pageEncoding="utf-8"/>

<cfset result = new MyClass().getLanguages()>

<cfoutput>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Languages</title>
</head>
<body>
  <table border="1">
    <tr>
      <th>ID</th>
      <th>Name</th>
    </tr>
    <cfloop query="result">
      <tr>
        <td>#id#</td>
        <td>#name#</td>
      </tr>
    </cfloop>
  </table>
</body>
</html>
</cfoutput>