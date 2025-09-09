@extends('layout.template')
@section('content')

<div class="page-content">
    <div class="container-fluid">
        <div id="app">
            <Viewledger
                :tenancy='@json($tenancy)'
                :tenant-payment='@json($tenantPayment)'
            ></Viewledger>
        </div>
    </div>
</div>

@endsection
