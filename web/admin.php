<?php include('include/header_admin.php') ?>

    
   <div class="container-fluid">
      <div class="row" >     
         <div class="col-sm-12">
            <!-- search bar start here-->
            <div class="search">
               <nav class="navbar navbar-dark ">
               <form class="form-inline">
                   <!--  <img src="plugin/image/logo.png" alt="Responsive image"  >-->
                  <input class="form-control mr-sm-2 "  type="search" placeholder="Search "   style="width: 40vw;">
                  <button class="btn btn-dark my-2 my-sm-0" type="submit"  >Search</button>
               </form>
               </nav>
            </div>
            <!-- search bar ends here-->     
         </div>
      </div>
          <div class="row">
            <div class="col-sm-12">
            <!--side navbar start from here-->
               <nav>
                  <span class="open-slide">
                     <a href="#" class="btn btn-dark" onclick="openSlideMenu()">&#9776;</a>
                  </span>
               </nav>
            <div class="side-nev"id="side-menu">
               
            <a href="#" class="btn btn-dark" class="btn-close" onclick="closeSlideMenu()"style="margin-left:212px">&times</a>
               <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist">              
              <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill"  href="#">Home</a>
         <!--     <a class="nav-link " id="v-pills-home-tab"  data-toggle="pill" href="#">Active Complaints</a>-->
              <a class="nav-link " id="v-pills-home-tab" data-toggle="pill" href="#">Qurries</a>
              <a class="nav-link " id="v-pills-home-tab" data-toggle="pill" href="#" onclick="logout()" >Logout</a>
             
              </div>
           </div>
    <!--side navbar ends  here-->
      
   
      <!--table start here-->
<div id="main"class="content">
            <div class="div col-sm-12">
                        <div class="card">
                           <div class="card-body">
                        
                              <div class="table-responsive-sm">
                                 <table class="table table-dark">
                                    <thead class="header">
                                       <tr>
                                          <th>ID     </th>
                                          <th>Name</th>
                                          <th>Mobile operators</th>                                 
                                          
                                          <th>Date</th> 
                           
                                       </tr>
                                    </thead>
                                    <div >
                                     <tbody id="first" class="tab">
                                    <a href="include/main.html">
                                        <tr>
                                    
                                    
                                    
                                        </tr>
                                    </a>
                                    </tbody>
                                    </div>
                                
                                 </table>
                              </div>
                           </div>
         </div>
                        
                     </div>
            </div>
         </div>
         </div> 
         </div>
               <!--table ends here-->
               
         
                  
            
            
            
               

            <?php include('include/footer_admin.php') ?>
   






   
    