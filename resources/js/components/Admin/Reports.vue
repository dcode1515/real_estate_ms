<template>
  <div>
    <!-- Tabs -->
    <ul class="nav nav-tabs" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button
          class="nav-link active btn btn-secondary text-white"
          id="analytics-tab"
          data-bs-toggle="tab"
          data-bs-target="#analytics"
          type="button"
          role="tab"
          aria-controls="analytics"
          aria-selected="true"
        >
          <i class="fas fa-chart-line me-2"></i> Reports
        </button>
      </li>
    </ul>

    <!-- Report Content -->
    <div class="tab-content mt-2" id="myTabContent">
      <div class="tab-pane fade show active" id="analytics" role="tabpanel">
        <!-- Filter Section -->
        <div class="card shadow-sm p-4 mb-4">
          <div class="row g-3 align-items-end">
            <!-- Property Type -->
            <div class="col-md-3 col-lg-2">
              <label class="form-label fw-bold">Property Type</label>
              <select v-model="selectedPropertyType" class="form-select">
                <option value="For Rent">🏠 For Rent</option>
                <option value="For Sale">🏢 For Sale</option>
              </select>
            </div>

            <!-- Report Type -->
            <div class="col-md-3 col-lg-2">
              <label class="form-label fw-bold">Report Type</label>
              <select v-model="selectedReportType" class="form-select">
                <option value="Daily Income">📆 Daily</option>
                <option value="Monthly Income">📅 Monthly</option>
                <option value="Yearly Income">📈 Yearly</option>
                <option value="Customize">🛠️ Customize</option>
              </select>
            </div>

            <!-- Start Date (Only for Customize) -->
            <div
              v-if="selectedReportType === 'Customize'"
              class="col-md-3 col-lg-2"
            >
              <label class="form-label fw-bold">Start Date</label>
              <input v-model="startDate" type="date" class="form-control" />
            </div>

            <!-- End Date (Only for Customize) -->
            <div
              v-if="selectedReportType === 'Customize'"
              class="col-md-3 col-lg-2"
            >
              <label class="form-label fw-bold">End Date</label>
              <input v-model="endDate" type="date" class="form-control" />
            </div>

            <!-- Generate Report Button (always last in row) -->
            <div class="col-md-12 col-lg d-flex justify-content-end">
              <button class="btn btn-primary" @click="generateReport()">
                <i class="fas fa-search me-2"></i> Generate Report
              </button>
            </div>
          </div>
        </div>

        <hr />

        <div class="col-md-12 d-flex align-items-end justify-content-end">
          <button class="btn btn-outline-success me-2" @click="exportToCSV">
            <i class="fas fa-file-csv me-2"></i> Export CSV
          </button>
          <button
            class="btn btn-outline-danger"
            @click="downloadPDFFromLaravel"
          >
            <i class="fas fa-file-pdf me-2"></i> Export PDF
          </button>
        </div>

        <!-- Report Table -->
        <div class="scrollable-table-wrapper">
          <table class="table table-hover table-bordered text-center">
            <thead class="table-success text-dark">
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
              <!-- Initial state: prompt to generate -->
              <tr v-if="!reportGenerated">
                <td colspan="9" class="text-center text-muted">
                  No data. Generate a report to view results.
                </td>
              </tr>

              <!-- If generated but no results -->
              <tr v-else-if="filteredReportData.length === 0">
                <td colspan="9" class="text-center">
                  No data available for the selected filters.
                </td>
              </tr>

              <!-- If data exists -->
              <tr v-for="(item, index) in filteredReportData" :key="item.id">
                <td>{{ index + 1 }}</td>
                <td>{{ item.property.property_name || "N/A" }}</td>
                <td>{{ item.tenant.tenant_name || "N/A" }}</td>
                <td>{{ item.invoice }}</td>
                <td>{{ item.mode_of_payment }}</td>
                <td>{{ item.acctno }}</td>
                <td>
                  <span :class="item.date_paid ? 'formatted-date' : 'no-date'">
                    {{ item.date_paid ? formatDate(item.date_paid) : "N/A" }}
                  </span>
                </td>
                <td>{{ item.status }}</td>
                <td>₱{{ Number(item.amount).toLocaleString() }}</td>
              </tr>
            </tbody>

            <tfoot>
              <tr>
                <th colspan="8" class="text-end">Total</th>
                <th>₱{{ calculateTotalAmount }}</th>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import html2pdf from "html2pdf.js";

import "vue-select/dist/vue-select.css";
import Swal from "sweetalert2";

export default {
  data() {
    return {
      selectedPropertyType: "",
      selectedReportType: "",
      startDate: "",
      endDate: "",
      filteredReportData: [],
      reportGenerated: false, // track if user clicked generate
    };
  },

  computed: {
    calculateTotalAmount() {
      return this.filteredReportData
        .reduce((total, item) => {
          return total + (parseFloat(item.amount) || 0);
        }, 0)
        .toLocaleString();
    },
  },

  methods: {
    downloadPDFFromLaravel() {
      const params = {
        propertyType: this.selectedPropertyType,
        reportType: this.selectedReportType,
        startDate: this.startDate,
        endDate: this.endDate,
      };

      const query = new URLSearchParams(params).toString();
      const url = `/real_estate_ms/download/report?${query}`;

      // Open in new tab or force download
      window.open(url, "_blank");
    },

    exportToPDF() {
      const element = document.querySelector(".scrollable-table-wrapper"); // Table wrapper
      const opt = {
        margin: 0.5,
        filename: `Report-${new Date().toISOString().split("T")[0]}.pdf`,
        image: { type: "jpeg", quality: 0.98 },
        html2canvas: { scale: 2 },
        jsPDF: { unit: "in", format: "letter", orientation: "landscape" },
      };
      html2pdf().set(opt).from(element).save();
    },
    exportToCSV() {
      const headers = [
        "#",
        "Property",
        "Tenant Name",
        "Invoice",
        "Mode of Payment",
        "Acct Number / G-Cash",
        "Date Paid",
        "Status",
        "Amount",
      ];

      const rows = this.filteredReportData.map((item, index) => [
        index + 1,
        item.property.property_name || "N/A",
        item.tenant.tenant_name || "N/A",
        item.invoice,
        item.mode_of_payment,
        item.acctno,
        item.date_paid ? this.formatDate(item.date_paid) : "N/A",
        item.status,
        Number(item.amount).toFixed(2),
      ]);

      const csvContent = [headers, ...rows]
        .map((row) => row.map((val) => `"${val}"`).join(","))
        .join("\n");

      const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
      const link = document.createElement("a");
      link.href = URL.createObjectURL(blob);
      link.setAttribute(
        "download",
        `Report-${new Date().toISOString().split("T")[0]}.csv`
      );
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    },
    generateReport() {
      this.formErrors = [];
      if (!this.selectedPropertyType) {
        this.formErrors.push("Property Type is required.");
      }
      if (!this.selectedReportType) {
        this.formErrors.push("ReportType Type is required.");
      }
      if (this.formErrors.length > 0) {
        let errorMessages = '<ul style="text-align: left;">';
        this.formErrors.forEach((error) => {
          errorMessages += `<li>${error}</li>`;
        });
        errorMessages += "</ul>";

        Swal.fire({
          icon: "error",
          title: "Please correct the errors",
          html: errorMessages,
        });
        return;
      }

      const params = {
        propertyType: this.selectedPropertyType,
        reportType: this.selectedReportType,
        startDate: this.startDate,
        endDate: this.endDate,
      };

      axios
        .get("/real_estate_ms/api/reports/payments", { params })
        .then((response) => {
          console.log("Report Data:", response.data);
          this.reportGenerated = true; // to show message if no data
          this.filteredReportData = response.data;
        })
        .catch((error) => {
          console.error("Error fetching report:", error);
        });
    },

    formatDate(dateStr) {
      const options = { year: "numeric", month: "short", day: "numeric" };
      return new Date(dateStr).toLocaleDateString(undefined, options);
    },
  },

  mounted() {
  
  },
};
</script>


<style scoped>
.bg-success {
  background-color: #198754 !important;
}

.modal-content {
  font-family: "Segoe UI", sans-serif;
  font-size: 15px;
}

.modal-header h5 i {
  font-size: 1.2rem;
}

.modal-body h6 i {
  font-size: 1rem;
}

.modal-body ul li {
  margin-bottom: 0.5rem;
}

.custom-modal-width {
  max-width: 50%;
  /* Adjust this percentage to fit your needs */
}

.modal-button {
  display: inline-block;
  background: #1e87f0;
  color: #ffffff !important;
  border: none;
  padding: 12px 30px;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 500;
  text-decoration: none;
  cursor: pointer;
  transition: background 0.3s ease;
}

.nav-tabs {
  border-bottom: 2px solid #ddd;
  /* Removed the background color */
}

.nav-link {
  padding: 10px 20px;
  color: white;
  font-size: 16px;
  transition: all 0.3s ease;
  background-color: gray;
  /* Default background color */
  margin: 1px;
  /* Space around the element */
}

.nav-link.active {
  background-color: rgb(7, 71, 36, 1);
  /* Active tab background color */
  color: white;
}

.tab-content {
  padding: 20px;
  background-color: #f8f9fa;
}

.nav-pills .nav-link {
  color: black;
  background-color: transparent;
  /* Removed the black background */
  text-align: left;
  width: 100%;
  border-radius: 0;
}

.nav-pills .nav-link:hover {
  background-color: #222;
}

.nav-pills .nav-link.active {
  background-color: green;
  color: white;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th,
td {
  border: 1px solid black;
  padding: 8px;
  text-align: center;
  word-wrap: break-word;
  white-space: normal;
}

th {
  background-color: #f2f2f2;
}

.subheader {
  font-size: 0.9em;
  font-style: italic;
}

.fixed-width {
  width: 150px;
  /* Adjust this value based on your needs */
  white-space: normal;
  /* Allows text to wrap */
  word-wrap: break-word;
  /* Breaks long words if necessary */
  text-align: center;
  /* Optional: centers the text */
}

th {
  max-width: 120px;
  /* Adjust as needed */
  white-space: normal;
}

.education-table {
  width: 100%;
  border-collapse: collapse;
  background-color: #fff;
}

/* Header styling */
.education-table th {
  border: 1px solid #000;
  padding: 5px;
  text-align: center;
  font-weight: bold;
  text-transform: uppercase;
  background-color: #f0f0f0;
}

/* Subheader styling for 'From' and 'To' */
.education-table th.subheader {
  font-weight: normal;
  text-transform: none;
  background-color: #f0f0f0;
}

/* Body styling */
.education-table td {
  border: 1px solid #000;
  padding: 5px;
  height: 30px;
  /* To match the row height in the image */
}

/* First column (LEVEL) styling */
.education-table td:first-child {
  background-color: #e6e6e6;
  text-align: center;
  font-weight: bold;
}

/* Responsive adjustments */
@media screen and (max-width: 600px) {
  .education-table {
    font-size: 10px;
  }

  .education-table th,
  .education-table td {
    padding: 3px;
  }
}

.scrollable-table-wrapper {
  max-height: 400px;

  overflow-y: auto;
  overflow-x: auto;

  border: 1px solid #dee2e6;
  margin-top: 1rem;
}

/* Apply styles for valid date formatting */
/* For valid date (Green) */
.formatted-date {
  color: #771361;
  /* Green color for valid dates */
  font-weight: bold;
  /* Optional: make the text bold */
  font-style: normal;
  /* Optional: reset italic if previously applied */
}

/* For "Not Scheduled" or invalid date (Red) */
.no-date {
  color: #f44336;
  /* Red color for "Not Scheduled" or empty date */
  font-style: italic;
  /* Italic style for emphasis */
}
.badge-custom-for-rent {
  background-color: green;
  color: white;
}

.badge-custom-sold {
  background-color: red;
  color: white;
}

.badge-custom-pending {
  background-color: yellow;
  color: black;
}

.badge-custom-available {
  background-color: blue; /* You can change this color */
  color: white;
}
.fw-bold {
  font-weight: 600;
}
.badge-custom-for-rent {
  background-color: #198754;
  color: white;
}
.badge-custom-sold {
  background-color: #dc3545;
  color: white;
}
.formatted-date {
  font-weight: 600;
  color: #0d6efd;
}
.scrollable-table-wrapper {
  overflow-x: auto;
}
</style>
