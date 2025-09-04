<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PaymentTenant extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $dates = ['deleted_at'];
    protected $table = 'tenant_payment';
    protected $fillable = [
        'id ',
       'tenant_id',
       'property_id',
       'user_id',
       'invoice',
       'trasaction_no',
       'mode_of_payment',
       'acctno',
       'amount',
       'proof_of_payment',
       'date_paid',
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
