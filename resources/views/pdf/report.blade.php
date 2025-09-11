<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: DejaVu Sans, sans-serif; font-size: 12px; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #000; padding: 6px; text-align: center; }
    th { background-color: #d4edda; }
    .header { margin-bottom: 10px; }
  </style>
</head>
<body>
  <div class="header">
    <h3>Filtered Report</h3>
   
    <p><strong>Report Type:</strong> {{ $filters['selectedReportType'] }}</p>
    @if($filters['selectedReportType'] === 'Customize')
      <p><strong>Date Range:</strong> {{ $filters['startDate'] }} to {{ $filters['endDate'] }}</p>
    @endif
  </div>

  <table>
    <thead>
      <tr>
        <th>#</th>
        <th>Property</th>
        <th>Tenant Name</th>
        <th>Invoice</th>
        <th>Mode of Payment</th>
        <th>Acct Number / G-Cash</th>
        <th>Date Paid</th>
        <th>Status</th>
        <th>Amount</th>
      </tr>
    </thead>
    <tbody>
      @forelse ($reportData as $index => $item)
        <tr>
          <td>{{ $index + 1 }}</td>
          <td>{{ $item->property->property_name ?? 'N/A' }}</td>
          <td>{{ $item->tenant->tenant_name ?? 'N/A' }}</td>
          <td>{{ $item->invoice }}</td>
          <td>{{ $item->mode_of_payment }}</td>
          <td>{{ $item->acctno }}</td>
          <td>{{ $item->date_paid ? \Carbon\Carbon::parse($item->date_paid)->format('M d, Y') : 'N/A' }}</td>
          <td>{{ $item->status }}</td>
          <td>₱{{ number_format($item->amount, 2) }}</td>
        </tr>
      @empty
        <tr>
          <td colspan="9">No data available</td>
        </tr>
      @endforelse
    </tbody>
    <tfoot>
      <tr>
        <th colspan="8" style="text-align: right;">Total</th>
        <th>₱{{ number_format($total, 2) }}</th>
      </tr>
    </tfoot>
  </table>
</body>
</html>
