<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST["name"];
    $pwd = $_POST["pwd"];
    $dob = $_POST["dob"];
    $email = $_POST["email"];
    $preferences = isset($_POST["preference"]) ? $_POST["preference"] : [];

    echo "<h2>Registration Details</h2>";
    echo "Name: $name<br>";
    echo "Password: $pwd<br>";
    echo "Date of Birth: $dob<br>";
    echo "Email: $email<br>";
    echo "Preferences: " . implode(", ", $preferences);
}
?>
