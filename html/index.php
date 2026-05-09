<!DOCTYPE html>
<html>
<head>
    <title>Vagrant LEMP Stack Validation</title>
    <style>
        body {
          font-family: sans-serif;
          line-height: 1.6;
          padding: 20px;
        }
        .success {
          color: green;
          font-weight: bold;
        }
        .error {
          color: red;
          font-weight: bold;
        }
        ul { 
          background: #f4f4f4;
          padding: 15px;
          border-radius: 5px;
          list-style: none;
        }
    </style>
</head>
<body>
    <h1>Vagrant LEMP stack</h1>
    
    <hr>

    <h3>PHP connection:</h3>
    <p>PHP status: <span class="success">✅ Connection success!</span></p>
    <?php
      $phpVersion = phpversion();
      $phpVersion = explode('-', $phpVersion)[0];
      echo "<p>PHP version: <span class='success'>" . $phpVersion . "</span></p>";
    ?>
    

    <hr>

    <h3>MySQL connection:</h3>
    <?php
      $servername = "localhost";
      $username = "dbuser";
      $password = "123456";

      $conn = new mysqli($servername, $username, $password);

      if ($conn->connect_error) {
          echo "<p> MySQL status: <span class='error'>❌ Connection failed: " . $conn->connect_error . "</span></p>";
      } else {
          echo "<p> MySQL status: <span class='success'>✅ Connection success!</span></p>";
          
          $serverInfo = mysqli_get_server_info($conn);
          $serverInfo = explode('-',$serverInfo)[0];
          echo "<p>MySQL version: <span class='success'>" . $serverInfo . "</span></p>";

          $conn->close();
      }
    ?>

    <hr>
    <small>Server time: <?php echo date('Y-m-d H:i:s'); ?></small>
</body>
</html>