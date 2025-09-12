<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\View;
use App\Models\Property;
use App\Models\Tenant;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services. 
     *
     * @return void
     */
    public function boot()
    {
        //
        View::composer('*', function ($view) {
        $totalProperties = Property::count();
        $occupiedProperties = Property::where('status', 'Occupied')->count();
        $availableProperties = Property::where('status', 'Available')->count();
        $tenantCount = Tenant::where('status', 'Active')->count();
        $view->with(compact('totalProperties', 'occupiedProperties', 'availableProperties', 'tenantCount'));
    });
    }
}
