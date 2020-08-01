 
function openSlideMenu(){
    document.getElementById('side-menu').style.width = '250px';
    document.getElementById('main').style.marginLeft = '0';
   
}
function closeSlideMenu() {
    document.getElementById('side-menu').style.width = '0';
    document.getElementById('main').style.marginLeft = '-250px';
    
}
 
 


var db = firebase.firestore();
db.collection("Complaints List").onSnapshot(function (querySnapshot) {
    querySnapshot.docChanges().forEach(function (change) {
        if (change.type === "added") {


            //  list_div.innerHTML +="<div class='main'><h1>" + doc.data().name + "</h1><h4>Email: " + doc.data().email + " </h4></div>"
            first.innerHTML += "<table><tbody><tr><td>" + change.doc.data().id + "</td><td>" + change.doc.data().full_name + "</td><td> " + change.doc.data().operator + "</td><td> " + change.doc.data().date + "</td></tr></tbody></table>"
        }
    });
});
