<!DOCTYPE html>
<html>
<head>
    <title>Input Length Check</title>
</head>
<body>

    <?php
    // Initialize a variable for the user's input and potential error message
    $userInput = "";
    $length = 0;
    $errorMessage = "";

    // Check if the form has been submitted using the POST method
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Retrieve the data from the input field named "myInput"
        // and remove any leading/trailing whitespace
        $userInput = trim($_POST["myInput"]);
        
        // Check if the input is not empty
        if (empty($userInput)) {
            $errorMessage = "Please enter some text.";
        } else {
            // Get the length of the string using the strlen() function
            $length = strlen($userInput);

            // Use an if-else statement to check the length
            if ($length < 5) {
                $errorMessage = "Your input is too short. It must be at least 5 characters.";
            } else {
                // If the length is valid, display a success message
                echo "<h2>Success!</h2>";
                echo "<p>The value you entered is: <b>" . htmlspecialchars($userInput) . "</b></p>";
                echo "<p>The length of your input is: <b>$length</b></p>";
            }
        }
    }
    ?>

    <h2>Enter a value (at least 5 characters)</h2>
    
    <!-- The HTML form -->
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <label for="myInput">Your text:</label><br>
        <input type="text" id="myInput" name="myInput" value="<?php echo htmlspecialchars($userInput); ?>">
        <input type="submit" value="Submit">
    </form>
    
    <!-- Display error message if it exists -->
    <?php if (!empty($errorMessage)) { ?>
        <p style="color: red;"><?php echo $errorMessage; ?></p>
    <?php } ?>

</body>
</html>
