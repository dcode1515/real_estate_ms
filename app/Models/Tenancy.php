<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Tenancy extends Model
{
   use HasFactory;
     use SoftDeletes;
     protected $table = 'tenancy_leases';
    protected $fillable = [
        'id ',
        'date_created',
       'property_id',
       'tenant_id',
       'lease_start_date',
       'lease_end_date',
       'monthly_rent_amount',
       'lease_duration',
       'due_date',
       'total_amount',
       'transaction_no',
       'upload_lease_document',
       'status',
       'created_at',
       'updated_at',
       'deleted_at',
       
   ];
    public function tenant()
    {
        return $this->belongsTo(Tenant::class);
    }
     public function property()
    {
        return $this->belongsTo(Property::class);
    }
    public function paymentTenants()
    {
        return $this->hasMany(PaymentTenant::class, 'tenant_id', 'tenant_id')
                    ->whereColumn('tenant_payment.property_id', 'tenancy_leases.property_id');
    }

      public static function IDGenerator($model,$trow,$length = 4, $prefix){
        $data = $model::orderBy('id','desc')->first();
        if(!$data){
            $og_length = $length;
            $last_number = '';
        }else{
            $code = substr($data->$trow, strlen($prefix)+1);
            $actial_last_number = ($code/1)*1;
            $increment_last_number = ((int)$actial_last_number)+1;
            $last_number_length = strlen($increment_last_number);
            $og_length = $length - $last_number_length;
            $last_number = $increment_last_number;
        }
        $zeros = "";
        for($i=0;$i<$og_length;$i++){
            $zeros.="0";
        }
        return $prefix.$zeros.$last_number;
    }
}
