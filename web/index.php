<?php include("include/header.php"); ?>


<div class="container-fluid">
    <div class="row" class="main">
        <div class="col-sm-6 sectionA">
            <img src="plugin/image/logo.png" class="img-fluid" alt="Responsive image">
            <h3 class="home1">सत्यमेव जयते <br>Ministry Of Communication<br>Department Of Grey Market Complaints</h3>

        </div>

        <!--Login start here-->
        <div class="col-sm-6 sectionB">
            <div>
                <h1 style="font-size: 3.9vw; animation: normal; "> <br> Welcome</h1>
                <h1 style="font-size: 2vw; ">PLEASE LOGIN TO ADMIN DASHBOARD</h1>
                <div class="input" id="login_div">
                    <!--     <form  onsubmit = "return validateForm()" action="admin.php" method="POST" >  -->
                    <div class="form-group">
                        <input type="email" class="form-control" id="email_field" aria-describedby="emailHelp"
                            placeholder="Email">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="password_field" placeholder="Password">
                    </div>
                    <button onclick="login()" class="btn btn-dark">
                        <div>Login</div>
                    </button>
                    <!--    </form>-->
                </div>
            </div>
        </div>
        <!--Login ends here-->

    </div>
</div>









<?php include("include/footer.php"); ?>