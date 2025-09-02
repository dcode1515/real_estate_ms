<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Property extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $dates = ['deleted_at'];
    protected $table = 'property';
    protected $fillable = [
        'id ',
        'property_no',
        'date_created',
        'property_name',
        'description_of_property',
        'property_type',
        'monthly_rate',
        'province',
        'municipality',
        'barangay',
        'street',
        'zip_code',
        'bedrooms',
        'sq_meter',
        'car_park',
        'toilet',
        'bathroom',
        'furnishing',
        'image',
        'status',
        'created_at',
        'updated_at',
      
   ];
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
