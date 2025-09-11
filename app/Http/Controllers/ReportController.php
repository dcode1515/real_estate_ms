<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\PaymentTenant;
use Carbon\Carbon;
use PDF; // Barryvdh DomPDF

class ReportController extends Controller
{
   
  public function getPaymentReport(Request $request)
{
    $propertyType = $request->input('propertyType'); // For Rent / For Sale
    $reportType = $request->input('reportType');     // Daily Income, Monthly Income, etc.
    $startDate = $request->input('startDate');       // Optional
    $endDate = $request->input('endDate');           // Optional

    $query = PaymentTenant::with(['tenant', 'property'])
        ->whereHas('property', function ($q) use ($propertyType) {
            $q->where('status_type', $propertyType);
        });

    switch ($reportType) {
        case 'Daily Income':
            $query->whereDate('date_paid', Carbon::now()->toDateString());
            break;

        case 'Monthly Income':
            $query->whereYear('date_paid', Carbon::now()->year)
                  ->whereMonth('date_paid', Carbon::now()->month);
            break;

        case 'Yearly Income':
            $query->whereYear('date_paid', Carbon::now()->year);
            break;

        case 'Customize':
            if ($startDate && $endDate) {
                $query->whereDate('date_paid', '>=', $startDate)
                      ->whereDate('date_paid', '<=', $endDate);
            }
            break;
    }

    $payments = $query->get();

    return response()->json($payments);
}

public function downloadPDF(Request $request)
    {
        // Get filters
        $propertyType = $request->input('selectedPropertyType');
        $selectedReportType = $request->input('reportType');
        $startDate = $request->input('startDate');
        $endDate = $request->input('endDate');

        // Fetch filtered data (use your actual query logic here)
        $reportData = PaymentTenant::with(['property', 'tenant'])
            ->when($propertyType, fn($q) => $q->where('property_type', $propertyType))
            ->when($selectedReportType === 'Customize' && $startDate && $endDate, function ($q) use ($startDate, $endDate) {
                $q->whereBetween('date_paid', [$startDate, $endDate]);
            })
            ->get();

        $total = $reportData->sum('amount');

        // Pass data to Blade
        $pdf = PDF::loadView('pdf.report', [
            'reportData' => $reportData,
            'total' => $total,
            'filters' => compact('propertyType', 'selectedReportType', 'startDate', 'endDate')
        ])->setPaper('a4', 'landscape');

        return $pdf->download('Filtered-Report-' . now()->format('Y-m-d') . '.pdf');
    }

}
