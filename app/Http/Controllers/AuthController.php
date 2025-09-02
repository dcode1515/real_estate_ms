<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Role;
use App\Models\Permission;
use Auth;
use Illuminate\Http\JsonResponse;


class AuthController extends Controller
{
    //


    public function login(){
        return view('auth.login');
    }
      public function logout()
    {
        
        Auth::logout();
        return redirect('/');

    }
    public function postLogin(Request $request){

      $request->validate([
        'email_address' => 'required|email',
        'password' => 'required',
    ]);

    if (Auth::attempt(['email' => $request->input('email_address'), 'password' => $request->input('password')])) {
        $user = Auth::user();

        if ($user->user_role === "Admin") {
            return response()->json(['type' => 'admin', 'message' => 'Admin'], 200);
        } else {
            Auth::logout(); // Force logout for all non-admins
            return response()->json([
                'error' => 'Access restricted to Admin accounts only.',
                'status' => 'unauthorized_role'
            ], 403);
        }
    }

    return response()->json([
        'error' => 'Your Email address or Password is incorrect. Please try again.',
    ], 401);
    }

    
    public function user_role(){
        return view ('auth.userrole');

    }

    public function store_role(Request $request){

        $request->validate([
          
            'user_role'       => 'required',
            'selectedPermissions'       => 'required',
          
        ]);

        $role  = new Role;
        $role->name = $request->user_role;
        $role->permission_id = $request->selectedPermissions;
        $role->status = "Active";
        $role->save();
        //$role->permissions()->sync($request->selectedPermissions);
        return response()->json(['status' => 'User Role Successfully Saved!'], 200);




    }
    public function update_role(Request $request,$id){

        $request->validate([
          
            'user_role'       => 'required',
            'selectedPermissions'       => 'required',
          
        ]);

        $role  =  Role::find($id);
        $role->name = $request->user_role;
        $role->permission_id = $request->selectedPermissions;
        $role->save();
        return response()->json(['status' => 'User Role Successfully Saved!'], 200);




    }
    public function get_User(Request $request){
        
		$columns = ['name', 'created','status'];
		$length = $request->input('length');
		$column = $request->input('column');
		$dir = $request->input('dir');
		$searchValue = $request->input('search');
		$data = Role::with('permissions')->orderBy($columns[$column], $dir);

		if($searchValue){
			$data->where(function($data) use ($searchValue) {
				$data->where('name', 'like', '%' . $searchValue . '%');
				
			});

		}
		$data = $data->paginate($length);
		return ['data' => $data, 'draw' => $request->input('draw')];

}

    public function get_permission(){
        
        $permission = Permission::get();
        return response()->json(['message' => $permission]);
    }

    public function getRoleDisplay(Request $request){
        $permissionIds = $request->input('ids');
        $permissions = Permission::whereIn('id', $permissionIds)->get();

        return response()->json(['permissions' => $permissions]);


        }

}
