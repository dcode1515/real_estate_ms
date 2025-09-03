<div class="app-menu navbar-menu">
    <!-- LOGO -->
    <div class="navbar-brand-box">
        <!-- Dark Logo-->
        <!-- <a href="index.html" class="logo logo-dark">
                    <span class="logo-sm">
                        <img src="assets/images/logo-sm.png" alt="" height="22">
                    </span>
                    <span class="logo-lg">
                        <img src="assets/images/logo-dark.png" alt="" height="17">
                    </span>
                </a> -->
        <!-- Light Logo-->
        <a href="index.html" class="logo logo-light">
            <span class="logo-sm">
                <img src="{{ URL::asset('public/images/logo/logo10.png') }}" alt="" height="50">
            </span>
            <span class="logo-lg">

                <img src="{{ URL::asset('public/images/logo/logo10.png') }}" alt="" width="100">
            </span>
        </a>
        <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
            <i class="ri-record-circle-line"></i>
        </button>
    </div>

    <div class="dropdown sidebar-user m-1 rounded">
        <button type="button" class="btn material-shadow-none" id="page-header-user-dropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <span class="d-flex align-items-center gap-2">
                <img class="rounded header-profile-user" src="" alt="Header Avatar">
                <span class="text-start">
                    <span class="d-block fw-medium sidebar-user-name-text">Anna Adame</span>
                    <span class="d-block fs-14 sidebar-user-name-sub-text"><i class="ri ri-circle-fill fs-10 text-success align-baseline"></i> <span class="align-middle">Online</span></span>
                </span>
            </span>
        </button>
        <div class="dropdown-menu dropdown-menu-end">
            <!-- item-->
            <h6 class="dropdown-header">Welcome Anna!</h6>
            <a class="dropdown-item" href="pages-profile.html"><i class="mdi mdi-account-circle text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Profile</span></a>
            <a class="dropdown-item" href="apps-chat.html"><i class="mdi mdi-message-text-outline text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Messages</span></a>
            <a class="dropdown-item" href="apps-tasks-kanban.html"><i class="mdi mdi-calendar-check-outline text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Taskboard</span></a>
            <a class="dropdown-item" href="pages-faqs.html"><i class="mdi mdi-lifebuoy text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Help</span></a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="pages-profile.html"><i class="mdi mdi-wallet text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Balance : <b>$5971.67</b></span></a>
            <a class="dropdown-item" href="pages-profile-settings.html"><span class="badge bg-success-subtle text-success mt-1 float-end">New</span><i class="mdi mdi-cog-outline text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Settings</span></a>
            <a class="dropdown-item" href="auth-lockscreen-basic.html"><i class="mdi mdi-lock text-muted fs-16 align-middle me-1"></i> <span class="align-middle">Lock screen</span></a>
            <a class="dropdown-item" href="auth-logout-basic.html"><i class="mdi mdi-logout text-muted fs-16 align-middle me-1"></i> <span class="align-middle" data-key="t-logout">Logout</span></a>
        </div>
    </div>

   
    <div id="scrollbar">
        <div class="container-fluid">


            <div id="two-column-menu">
            </div>
            <ul class="navbar-nav" id="navbar-nav">
                <li class="menu-title"><span data-key="t-menu">Menu</span></li>

                <li class="nav-item">
                    <a class="nav-link menu-link" href="{{route('dashboard')}}">
                        <i class="ri-dashboard-2-line"></i> <span data-key="t-widgets">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu-link" href="{{route('tenants')}}">
                        <i class="ri-home-line"></i> <span data-key="t-widgets">Tenants</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link menu-link" href="#PSIPOPsidebar" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="PSIPOPsidebar">
                        <i class="ri-stack-line"></i> <span data-key="t-apps">Properties</span>
                    </a>
                    <div class="collapse menu-dropdown" id="PSIPOPsidebar">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="{{route('for_rent')}}" class="nav-link" data-key="t-chat">For Rent Properties</a>
                            </li>
                            <li class="nav-item">
                                <a href="" class="nav-link">For Sale Properties</a>
                            </li>
                          
                        </ul>
                    </div>
                </li>

                <li class="nav-item">
                    <a class="nav-link menu-link" href="#recruitmentDropdown" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="recruitmentDropdown">
                        <i class="ri-briefcase-line"></i>
                        <span data-key="t-widgets">Leases/Tenancy</span>
                    </a>
                    <div class="collapse menu-dropdown" id="recruitmentDropdown">
                        <ul class="nav nav-sm flex-column">
                            <li class="nav-item">
                                <a href="{{route('create.tenancy')}}" class="nav-link">Create Tenancy</a>
                            </li>
                            <li class="nav-item">
                                <a href="{{route('show.tenancy')}}" class="nav-link">Show Tenancy</a>
                            </li>
                        </ul>
                    </div>
                </li>

                                <li class="nav-item">
                <a class="nav-link menu-link" href="#transactionDropdown" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="transactionDropdown">
                  <i class="ri-exchange-dollar-line"></i>
                    <span data-key="t-authentication">Transaction</span>
                </a>
                <div class="collapse menu-dropdown" id="transactionDropdown">
                    <ul class="nav nav-sm flex-column">
                    <li class="nav-item">
                        <a href="{{ route('payment.index') }}" class="nav-link">Payment</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="nav-link">Ledger</a>
                    </li>
                    </ul>
                </div>
                </li>


                <li class="nav-item">
                    <a class="nav-link menu-link" href="">
                        <i class="ri-group-line"></i> <span data-key="t-authentication">Users</span>
                    </a>
                </li>

        
             

               
        </div>
        <!-- Sidebar -->
    </div>
   


  
    



   

    <div class="sidebar-background"></div>
</div>