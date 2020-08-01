

 
    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-firestore.js"></script>
        <script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-auth.js"></script>
        <script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-database.js"></script>
         <script src="https://www.gstatic.com/firebasejs/7.17.1/firebase.js"></script>
        
        
    
   

    
    <!-- TODO: Add SDKs for Firebase products that you want to use
         https://firebase.google.com/docs/web/setup#available-libraries -->
    <script src="https://www.gstatic.com/firebasejs/7.17.1/firebase-analytics.js"></script>
    
    <script>
        // Your web app's Firebase configuration
          var firebaseConfig = {
                apiKey: "AIzaSyC_VX2ZPSo0uyRM6GWLuCDXPE0ZAWW2b3c",
                authDomain: "gmcr-app.firebaseapp.com",
                databaseURL: "https://gmcr-app.firebaseio.com",
                projectId: "gmcr-app",
                storageBucket: "gmcr-app.appspot.com",
                messagingSenderId: "22294898433",
                appId: "1:22294898433:web:55161cb2dd976395b01d00",
                measurementId: "G-C3V614YBKV"
            };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
        firebase.analytics();
        var db = firebase.firestore();
        var user = firebase.auth().currentUser;    
    </script>
    <script src="plugin/javascript/login.js" type="text/javascript"></script>
     
</body>
</html>