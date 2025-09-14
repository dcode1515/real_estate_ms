<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SaleProperty extends Model
{
    use HasFactory;
     use SoftDeletes;
     protected $table = 'sale_property';
      protected $fillable = [
        'id ',
        'property_id',
        'customer_name',
        'contact_no',
        'mode_of_payment',
        'amount',
        'acct_no',
        'date_paid',
        'proof_of_payment',
        'status',
        'created_at',
        'updated_at',
      
   ];

}
