<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">


<!-- Mirrored from themesbrand.com/velzon/html/master/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 12 Aug 2024 07:44:28 GMT -->
<head>

    <meta charset="utf-8" />
    <title>Dashboard | Real Estate Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesbrand" name="author" />
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- App favicon -->
    <link rel="shortcut icon" href="assets/images/favicon.ico">

    <!-- jsvectormap css -->
    <link rel="stylesheet" href="{{ URL::asset('public/Dashboard-Template-Velzon-main/assets/libs/jsvectormap/css/jsvectormap.min.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


    <!--Swiper slider css-->
    <link rel="stylesheet" href="{{ URL::asset('public/Dashboard-Template-Velzon-main/assets/libs/swiper/swiper-bundle.min.css') }}">
   
    <!-- Layout config Js -->
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/js/layout.js') }}"></script>
 
    <!-- Bootstrap Css -->
    <link rel="stylesheet" href="{{ URL::asset('public/Dashboard-Template-Velzon-main/assets/css/bootstrap.min.css') }}">
      <link
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
  rel="stylesheet"
/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
   
    <!-- Icons Css -->
    <link rel="stylesheet" href="{{ URL::asset('public/Dashboard-Template-Velzon-main/assets/css/icons.min.css') }}">
    <link
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
  rel="stylesheet"
/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  
    <!-- App Css-->
    <link rel="stylesheet" href="{{ URL::asset('public/Dashboard-Template-Velzon-main/assets/css/app.min.css') }}">
  
 
    <!-- custom Css-->
    <link rel="stylesheet" href="{{ URL::asset('public/Dashboard-Template-Velzon-main/assets/css/custom.min.css') }}">
      <style>
        #page-topbar {
    background-color: #007bff;

    
    
}



        </style>
</head>

<body>

    <!-- Begin page -->
    <div id="layout-wrapper">

            @include('layout.navbar')
     <!-- ========== App Menu ========== -->
                @include('layout.sidebar')
        <!-- Left Sidebar End -->
        <!-- Vertical Overlay-->
        <div class="vertical-overlay"></div>

        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="main-content">
                    @yield('content')
            <!-- End Page-content -->
                    @include('layout.footer')
            
        </div>
        <!-- end main content-->

    </div>
   
<script src="{{ asset('public/js/app.js') }}?v={{ config('app.version') }}"></script>


    <!-- <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/bootstrap/js/bootstrap.bundle.min.js') }}"></script> -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
  
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/simplebar/simplebar.min.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/node-waves/waves.min.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/feather-icons/feather.min.js') }}"></script>
    <!-- <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/js/pages/plugins/lord-icon-2.1.0.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/js/plugins.js') }}"></script> -->
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/apexcharts/apexcharts.min.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/jsvectormap/js/jsvectormap.min.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/jsvectormap/maps/world-merc.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/libs/swiper/swiper-bundle.min.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/js/pages/dashboard-ecommerce.init.js') }}"></script>
    <script src="{{ asset('public/Dashboard-Template-Velzon-main/assets/js/app.js') }}"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const propertyData = {
            labels: ["Total", "Occupied", "Available"],
            datasets: [{
                label: "Properties",
                data: [{{ $totalProperties }}, {{ $occupiedProperties }}, {{ $availableProperties }}],
                backgroundColor: ["#4CAF50", "#2196F3", "#FFC107"],
                borderColor: ["#388E3C", "#1976D2", "#FFA000"],
                borderWidth: 1
            }]
        };

        // Bar Chart
        new Chart(document.getElementById("propertyBarChart"), {
            type: "bar",
            data: propertyData,
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0 // Show whole numbers
                        }
                    }
                }
            }
        });

        // Pie Chart
        new Chart(document.getElementById("propertyPieChart"), {
            type: "pie",
            data: {
                labels: ["Total", "Occupied", "Available"],
                datasets: [{
                    data: [{{ $totalProperties }}, {{ $occupiedProperties }}, {{ $availableProperties }}],
                    backgroundColor: ["#4CAF50", "#2196F3", "#FFC107"],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
            }
        });
    });
</script>

    

    
  <!-- <script>
  document.addEventListener('DOMContentLoaded', function () {
    var welcomeModal = new bootstrap.Modal(document.getElementById('welcomeModal'));
    welcomeModal.show();
  });
</script> -->
</body>


<!-- Mirrored from themesbrand.com/velzon/html/master/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 12 Aug 2024 07:45:33 GMT -->
</html>