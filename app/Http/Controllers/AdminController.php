<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tenant;
use App\Models\Property;
use Carbon\Carbon;


class AdminController extends Controller
{
    //

    public function dashboard(){
       return view('admin.index');
    }
    public function tenants(){
        return view('admin.tenants');
     }
    public function store_tenants(Request $request)
    {
        $validated = $request->validate([
         
            'tenant_name'      => 'required|string|max:255',
            'contact_no'       => 'required|string|max:20',
            'address'          => 'required|string|max:255',
            'monthly_rate'     => 'required|numeric',
            'date_created'     => 'required|date',
            'lease_period'     => 'required|string|max:50',
            'due_date'         => 'required|date',
            'contracts'        => 'required|file|mimes:pdf',
            'id1'              => 'required|file|mimes:png,jpeg,jpg',
            'id2'              => 'required|file|mimes:png,jpeg,jpg',
        ]);

        $tenant = new Tenant;
        $nowYear = now()->format('Y');
        $tenant_no = Tenant::IDGenerator(new Tenant, 'tenant_no', 4, $nowYear);

        $tenant->tenant_no = $tenant_no;
        $tenant->tenant_name = $validated['tenant_name'];
        $tenant->address = $validated['address'];
        $tenant->contact_number = $validated['contact_no'];
        $tenant->rate = $validated['monthly_rate'];
        $tenant->period = $validated['lease_period'];
        $tenant->duedate = $validated['due_date'];
        $tenant->status = "Active";
        $tenant->date_created = $validated['date_created'];

        $fileFields = ['contracts', 'id1', 'id2'];
        $uploadPath = public_path('tenant/' . $tenant_no);

        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0755, true);
        }

        foreach ($fileFields as $field) {
            if ($request->hasFile($field) && $request->file($field)->isValid()) {
                $file = $request->file($field);
                $ext = $file->getClientOriginalExtension();
                $rootName = strtoupper(str_replace(' ', '_', $tenant->tenant_name));
                $fileName = now()->year . '-' . $rootName . '.' . $tenant_no . '.' . $field . '.' . $ext;
                $file->move($uploadPath, $fileName);
                $tenant->$field = $fileName;
            }
        }

        $tenant->save();

        return response()->json(['message' => 'Tenant Added!']);
    }
    public function update_tenants(Request $request,$id)
    {
        $validated = $request->validate([
         
            'tenant_name'      => 'nullable|string|max:255',
            'contact_no'       => 'nullable|string|max:20',
            'address'          => 'nullable|string|max:255',
            'monthly_rate'     => 'nullable|numeric',
            'date_created'     => 'nullable|date',
            'lease_period'     => 'nullable|string|max:50',
            'due_date'         => 'nullable|date',
            'contracts'        => 'nullable|file|mimes:pdf',
            'id1'              => 'nullable|file|mimes:png,jpeg,jpg',
            'id2'              => 'nullable|file|mimes:png,jpeg,jpg',
        ]);

        $tenant = Tenant::find($id);
        $nowYear = now()->format('Y');
        $tenant_no = Tenant::IDGenerator(new Tenant, 'tenant_no', 4, $nowYear);

    
        $tenant->tenant_name = $validated['tenant_name'];
        $tenant->address = $validated['address'];
        $tenant->contact_number = $validated['contact_no'];
        $tenant->rate = $validated['monthly_rate'];
        $tenant->period = $validated['lease_period'];
        $tenant->duedate = $validated['due_date'];
        $tenant->status = "Active";
        $tenant->date_created = $validated['date_created'];

        $fileFields = ['contracts', 'id1', 'id2'];
        $uploadPath = public_path('tenant/' . $tenant->tenant_no);

        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0755, true);
        }

        foreach ($fileFields as $field) {
            if ($request->hasFile($field) && $request->file($field)->isValid()) {
                $file = $request->file($field);
                $ext = $file->getClientOriginalExtension();
                $rootName = strtoupper(str_replace(' ', '_', $tenant->tenant_name));
                $fileName = now()->year . '-' . $rootName . '.' . $tenant->tenant_no . '.' . $field . '.' . $ext;
                $file->move($uploadPath, $fileName);
                $tenant->$field = $fileName;
            }
        }

        $tenant->save();

        return response()->json(['message' => 'Tenant Updated!']);
    }
    public function get_data_tenant(Request $request)
    {

        try {
            $search = $request->query('search');
            $perPage = $request->query('per_page', 10); // Default to 10 if per_page is not provided

            $tenants = Tenant::query()
                ->when($search, function ($query, $search) {
                    return $query
                     
                        ->where('tenant_name', 'like', '%' . $search . '%')
                         ->orWhere('tenant_no', 'like', '%' . $search . '%')
                        ->orWhere('address', 'like', '%' . $search . '%')
                        ->orWhere('contact_number', 'like', '%' . $search . '%')
                        ->orWhere('rate', 'like', '%' . $search . '%')
                        ->orWhere('period', 'like', '%' . $search . '%')
                        ->orWhere('duedate', 'like', '%' . $search . '%');
                      
                        
                })
                ->where('status', 'Active')
                ->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $tenants
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'An error occurred: ' . $e->getMessage()
            ], 500);
        }
    }

    public function for_rent (){
        return view('admin.for_rent');
    }
    public function store_properties(Request $request)
    {
        $validated = $request->validate([
            'date_created'            => 'required|date',
            'property_name'           => 'required|string|max:255',
            'description_of_property' => 'required|string|max:1000',
            'property_type'           => 'required|string|max:50',
            'province'                => 'required|string|max:100',
            'municipality'            => 'required|string|max:100',
                'barangay'            => 'required|string|max:100',
            'street'                  => 'required|string|max:255',
            'zip_code'                => 'required|string|max:10',
            'bedrooms'                => 'required|integer|min:0',
            'sq_meter'                => 'required|numeric|min:0',
            'car_park'                => 'required|integer|min:0',
            'toilet'                  => 'required|integer|min:0',
            'bathroom'                => 'required|integer|min:0',
            'monthly_rate'            => 'required',
            'furnishing'              => 'required|string|max:100',
            'image'                   => 'required|file|mimes:png,jpeg,jpg',
        ]);

        $property  = new Property();
        if (Property::where('property_name', $request->property_name)->exists()) {
            // Handle the case where the property_name already exists, for example, return an error response
            return response()->json(['exist' => 'Property name already exist'], 422);
        }
        
        $text = "PN-";
        $now = Carbon::now()->format('Y');
        $property_no = Property::IDGenerator(new Property,'property_no', 4,$text.$now);
        $property->property_no = $property_no;
        $property->property_name = $validated['property_name'];
        $property->description_of_property = $validated['description_of_property'];
        $property->property_type = $validated['property_type'];
        $property->province = $validated['province'];
        $property->municipality = $validated['municipality'];
        $property->street = $validated['street'];
        $property->zip_code = $validated['zip_code'];
        $property->bedrooms = $validated['bedrooms'];
        $property->sq_meter = $validated['sq_meter'];
        $property->car_park = $validated['car_park'];
        $property->toilet = $validated['toilet'];
        $property->bathroom = $validated['bathroom'];
        $property->furnishing = $validated['furnishing'];
        $property->monthly_rate = $validated['monthly_rate'];
        $property->status = "Available";
         $property->status_type = "For Rent";
        $property->date_created = $validated['date_created'];

        $fileFields = ['image'];
        $uploadPath = public_path('Property/' . $property_no);

        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0755, true);
        }

        foreach ($fileFields as $field) {
            if ($request->hasFile($field) && $request->file($field)->isValid()) {
                $file = $request->file($field);
                $ext = $file->getClientOriginalExtension();
                $rootName = strtoupper(str_replace(' ', '_', $property->property_name));
                $fileName = now()->year . '-' . $rootName . '.' . $property_no . '.' . $field . '.' . $ext;
                $file->move($uploadPath, $fileName);
                $property->$field = $fileName;
            }
        }

        $property->save();

        return response()->json(['message' => 'Property Added!']);
    }


    public function update_properties(Request $request,$id)
    {
        $validated = $request->validate([
            'date_created'            => 'nullable|date',
            'property_name'           => 'nullable|string|max:255',
            'description_of_property' => 'nullable|string|max:1000',
            'property_type'           => 'nullable|string|max:50',
            'province'                => 'nullable|string|max:100',
            'municipality'            => 'nullable|string|max:100',
               'barangay'            => 'nullable|string|max:100',
            'street'                  => 'nullable|string|max:255',
            'zip_code'                => 'nullable|string|max:10',
            'bedrooms'                => 'nullable|integer|min:0',
            'sq_meter'                => 'nullable|numeric|min:0',
            'car_park'                => 'nullable|integer|min:0',
            'toilet'                  => 'nullable|integer|min:0',
            'bathroom'                => 'nullable|integer|min:0',
            'monthly_rate'            => 'nullable',
            'furnishing'              => 'nullable|string|max:100',
            'image'                   => 'nullable|file|mimes:png,jpeg,jpg',
        ]);

       if ($request->filled('property_name')) {
                $exists = Property::where('property_name', $request->property_name)
                    ->where('id', '!=', $id)
                    ->exists();

                if ($exists) {
                    return response()->json(['exist' => 'Property name already exists'], 422);
                }
            }
        
      $property = Property::find($id);
        $property->property_name = $validated['property_name'];
        $property->description_of_property = $validated['description_of_property'];
        $property->property_type = $validated['property_type'];
        $property->province = $validated['province'];
        $property->municipality = $validated['municipality'];
           $property->barangay = $validated['barangay'];
        $property->street = $validated['street'];
        $property->zip_code = $validated['zip_code'];
        $property->bedrooms = $validated['bedrooms'];
        $property->sq_meter = $validated['sq_meter'];
        $property->car_park = $validated['car_park'];
        $property->toilet = $validated['toilet'];
        $property->bathroom = $validated['bathroom'];
        $property->furnishing = $validated['furnishing'];
        $property->monthly_rate = $validated['monthly_rate'];
      
        $property->date_created = $validated['date_created'];

        $fileFields = ['image'];
        $uploadPath = public_path('Property/' . $property->property_no);

        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0755, true);
        }

        foreach ($fileFields as $field) {
            if ($request->hasFile($field) && $request->file($field)->isValid()) {
                $file = $request->file($field);
                $ext = $file->getClientOriginalExtension();
                $rootName = strtoupper(str_replace(' ', '_', $property->property_name));
                $fileName = now()->year . '-' . $rootName . '.' . $property_no . '.' . $field . '.' . $ext;
                $file->move($uploadPath, $fileName);
                $property->$field = $fileName;
            }
        }

        $property->save();

        return response()->json(['message' => 'Property Added!']);
    }

    


    public function get_data_properties(Request $request)
    {

        try {
            $search = $request->query('search');
            $perPage = $request->query('per_page', 10); // Default to 10 if per_page is not provided
            $propertyType = $request->query('property_type'); // Add this line to get the property_type filter


            $properties = Property::query()
                ->when($search, function ($query, $search) {
                    return $query
                        ->where('property_no', 'like', '%' . $search . '%')
                         ->orWhere('date_created', 'like', '%' . $search . '%')
                        ->orWhere('property_name', 'like', '%' . $search . '%')
                        ->orWhere('description_of_property', 'like', '%' . $search . '%')
                        ->orWhere('property_type', 'like', '%' . $search . '%')
                        ->orWhere('monthly_rate', 'like', '%' . $search . '%')
                        ->orWhere('province', 'like', '%' . $search . '%')
                        ->orWhere('municipality', 'like', '%' . $search . '%')
                        ->orWhere('province', 'like', '%' . $search . '%')
                        ->orWhere('barangay', 'like', '%' . $search . '%')
                        ->orWhere('street', 'like', '%' . $search . '%')
                        ->orWhere('zip_code', 'like', '%' . $search . '%')
                        ->orWhere('bedrooms', 'like', '%' . $search . '%')
                        ->orWhere('sq_meter', 'like', '%' . $search . '%')
                        ->orWhere('car_park', 'like', '%' . $search . '%')
                        ->orWhere('toilet', 'like', '%' . $search . '%')
                        ->orWhere('bathroom', 'like', '%' . $search . '%')
                        ->orWhere('furnishing', 'like', '%' . $search . '%');

                })
                 ->when($propertyType, function ($query, $propertyType) {
                    return $query->where('property_type', $propertyType);
                })
                ->where('status_type', 'For Rent')
                ->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $properties
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => 'An error occurred: ' . $e->getMessage()
            ], 500);
        }
    }
     

}
