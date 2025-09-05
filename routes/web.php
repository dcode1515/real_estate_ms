<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


Route::get('/', [App\Http\Controllers\AuthController::class, 'login'])->name('login');
Route::post('/api/login/post', [App\Http\Controllers\AuthController::class, 'postLogin']);


/*Admin Routes*/
Route::get('/dashboard', [App\Http\Controllers\AdminController::class, 'dashboard'])->name('dashboard');
Route::get('/tenants', [App\Http\Controllers\AdminController::class, 'tenants'])->name('tenants');
Route::post('/api/store/tenant', [App\Http\Controllers\AdminController::class, 'store_tenants']);
Route::get('/api/get/data/tenant', [App\Http\Controllers\AdminController::class, 'get_data_tenant']);
Route::post('/api/update/tenant/{id}', [App\Http\Controllers\AdminController::class, 'update_tenants']);
Route::get('/for/rent/properties', [App\Http\Controllers\AdminController::class, 'for_rent'])->name('for_rent');
Route::post('/api/store/property', [App\Http\Controllers\AdminController::class, 'store_properties']);
Route::get('/api/get/data/properties', [App\Http\Controllers\AdminController::class, 'get_data_properties']);
Route::post('/api/update/property/{id}', [App\Http\Controllers\AdminController::class, 'update_properties']);
Route::get('/create/tenancy', [App\Http\Controllers\AdminController::class, 'create_tenancy'])->name('create.tenancy');
Route::get('/api/get/available/property', [App\Http\Controllers\AdminController::class, 'getAvailableProperties']);
Route::get('/api/get/available/tenant', [App\Http\Controllers\AdminController::class, 'getAvailableTenant']);
Route::post('/api/store/tenancy', [App\Http\Controllers\AdminController::class, 'store_tenancy_lease']);
Route::get('/show/tenancy', [App\Http\Controllers\AdminController::class, 'show_tenancy'])->name('show.tenancy');
Route::get('/api/get/data/tenancy', [App\Http\Controllers\AdminController::class, 'getDataTenancy']);
Route::get('/payment', [App\Http\Controllers\AdminController::class, 'payment'])->name('payment.index');
Route::get('/get-tenancies', [App\Http\Controllers\AdminController::class, 'getAllTenancyData']);
Route::get('/get-tenancy/{tenantId}', [App\Http\Controllers\AdminController::class, 'getTenancyByTenant']);
Route::post('/api/store/payment', [App\Http\Controllers\AdminController::class, 'store_tenant_payment']);
Route::get('/api/get/data/payment', [App\Http\Controllers\AdminController::class, 'getDataPayment']);
Route::post('/api/update/payment/{ID}', [App\Http\Controllers\AdminController::class, 'update_tenant_payment']);
Route::delete('/api/delete/data/payment/{id}', [App\Http\Controllers\AdminController::class, 'deleteTenantPayment']);
Route::get('/ledger', [App\Http\Controllers\AdminController::class, 'ledger'])->name('ledger');



/*End Admin Routes*/