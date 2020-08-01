



function login(){
    
   

    var userEmail = document.getElementById("email_field").value;
    var userPass = document.getElementById("password_field").value;
    
    firebase.auth().signInWithEmailAndPassword(userEmail, userPass).catch(function (error) {
        // Handle Errors here.
        var errorCode = error.code;
        var errorMessage = error.message;

        window.alert("Error : " + errorMessage);

        // ...
    });

    ////
    firebase.auth().signInWithEmailAndPassword(userEmail, userPass).then(function () {
        window.location="admin.php";
        // Sign-out successful.
    }).catch(function (error) {
        // An error happened.
    }); 

        // ...
   

}

function logout() {
    window.location = "index.php";
    window.alert("logout successful");
    
    firebase.auth().signOut();
}
 
 

 


