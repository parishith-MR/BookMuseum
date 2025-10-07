function verify(event) {
    event.preventDefault(); // prevent default form submission

    const name = document.getElementById("name").value.trim();
    const pwd = document.getElementById("pwd").value.trim();

    if (name === "" || pwd === "") {
        alert("Name and password cannot be empty!");
        return;
    }

    const form = document.getElementById("inputs");
    const formData = new FormData(form); // collects all fields including checkboxes

    fetch("register", {
        method: "POST",
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        console.log("Server says:", data);

        // If servlet sends HTML message, check for keyword
        if (data.includes("Registration successful")) {
            window.location.href = "Front_end.html";  // redirect on success
        } else {
            document.getElementById("result").innerHTML = data; // show error message
        }
    })
    .catch(error => {
        console.error("Fetch error:", error);
        document.getElementById("result").innerHTML = "<p>Error occurred while registering.</p>";
    });
}
