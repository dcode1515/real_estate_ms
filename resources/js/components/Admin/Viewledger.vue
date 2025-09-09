<template>
  <div>
    <ul class="nav nav-tabs" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button
          class="nav-link active btn btn-primary text-white"
          id="tenancy-tab"
          data-bs-toggle="tab"
          data-bs-target="#tenancy"
          type="button"
          role="tab"
          aria-controls="tenancy"
          aria-selected="true"
        >
          <i class="fas fa-file-invoice-dollar"></i> Ledger of
          {{ tenancy.tenant.tenant_name }}
        </button>
      </li>
    </ul>
    <br />

    <div class="row justify-content-center">
      <div class="col-xxl-10">
        <div class="card shadow-lg" id="demo">
          <!-- Header with icon and title -->
          <div
            class="card-header d-flex flex-wrap align-items-center mb-3 gap-2"
          >
            <i class="bi bi-person-circle fs-3 me-2 text-primary"></i>
            <h4 class="mb-0 flex-grow-1">Tenant Ledger</h4>
            <div class="d-flex flex-wrap gap-2 ms-auto">
              <a
                v-bind:href="'/real_estate_ms/show/tenancy'"
                class="btn btn-outline-primary"
              >
                <i class="ri-download-2-line align-bottom me-1"></i>
                <span class="d-none d-sm-inline">Back</span>
                <span class="d-inline d-sm-none">PDS</span>
              </a>
            </div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-6">
                <div class="mb-3">
                  <label for="tenantName" class="form-label"
                    >Tenant Name:</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="tenantName"
                    v-model="tenancy.tenant.tenant_name"
                    disabled
                  />
                </div>
              </div>
              <div class="col-lg-6">
                <div class="mb-3">
                  <label for="propertyAddress" class="form-label"
                    >Property</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="propertyAddress"
                    v-model="tenancy.property.property_name"
                    disabled
                  />
                </div>
              </div>

              <div class="col-lg-6">
                <div class="mb-3">
                  <label for="propertyAddress" class="form-label"
                    >Lease Start Date</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="propertyAddress"
                    v-model="tenancy.lease_start_date"
                    disabled
                  />
                </div>
              </div>
              <div class="col-lg-6">
                <div class="mb-3">
                  <label for="propertyAddress" class="form-label"
                    >Lease End Date</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="propertyAddress"
                    v-model="tenancy.lease_end_date"
                    disabled
                  />
                </div>
              </div>

              <div class="col-lg-6">
                <div class="mb-3">
                  <label for="propertyAddress" class="form-label"
                    >Lease End Date</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="propertyAddress"
                    v-model="tenancy.lease_duration"
                    disabled
                  />
                </div>
              </div>
              <div class="col-lg-6">
                <div class="mb-3">
                  <label for="propertyAddress" class="form-label"
                    >Next Payment</label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="propertyAddress"
                    v-model="tenancy.due_date"
                    disabled
                  />
                </div>
              </div>
            </div>

            <div class="table-responsive">
              <br />
              <div class="row mb-3">
                <div class="col-md-2">
                  <select
                    v-model="itemsPerPage"
                    @change="currentPage = 1"
                    class="form-select"
                  >
                    <option :value="5">5 per page</option>
                    <option :value="10">10 per page</option>
                    <option :value="20">20 per page</option>
                    <option :value="50">50 per page</option>
                  </select>
                </div>
                <div class="col-md-10">
                  <input
                    v-model="searchQuery"
                    type="text"
                    class="form-control"
                    placeholder="Search by any field..."
                  />
                </div>
              </div>

              <table>
                <thead>
                  <tr>
                    <th style="background-color: #198754; color: white">#</th>
                    <th style="background-color: #198754; color: white">
                      Invoice No
                    </th>
                    <th style="background-color: #198754; color: white">
                      Transaction No
                    </th>
                    <th style="background-color: #198754; color: white">
                      Mode of Payment
                    </th>
                    <th style="background-color: #198754; color: white">
                      Acct Number/G-Cash Number
                    </th>
                    <th style="background-color: #198754; color: white">
                      Proof of Payment
                    </th>
                    <th style="background-color: #198754; color: white">
                      Date Paid
                    </th>
                    <th style="background-color: #198754; color: white">
                      Amount
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-if="paginatedPayments.length === 0">
                    <td colspan="8" class="text-center text-muted">
                      No payment records found.
                    </td>
                  </tr>
                  <tr
                    v-for="(payment, index) in paginatedPayments"
                    :key="payment.id"
                  >
                    <td class="text-center">{{ index + 1 }}</td>
                    <td>{{ payment.invoice }}</td>
                    <td>{{ payment.transaction_no }}</td>
                    <td>{{ payment.mode_of_payment }}</td>
                    <td>{{ payment.acctno }}</td>
                    <td><a v-bind:href="'/real_estate_ms/public/tenant/' + tenancy.tenant.tenant_no + '/' + payment.proof_of_payment"  target="_blank">{{ payment.proof_of_payment }}</a></td>
                    <td>{{ payment.date_paid }}</td>
                    <td>{{ formatPHP(payment.amount) }}</td>
                  </tr>
                </tbody>
                <tfoot>
                  <tr>
                    <td
                      colspan="7"
                      class="text-end"
                      style="font-weight: bold; background-color: #f8f9fa"
                    >
                      Total Amount:
                    </td>
                    <td style="font-weight: bold; background-color: #f8f9fa">
                      {{ formatPHP(totalAmount) }}
                    </td>
                  </tr>
                </tfoot>
              </table>
              <nav class="mt-3">
                <ul class="pagination justify-content-center">
                  <li
                    class="page-item"
                    :class="{ disabled: currentPage === 1 }"
                  >
                    <a
                      class="page-link"
                      href="#"
                      @click.prevent="goToPage(currentPage - 1)"
                      >Previous</a
                    >
                  </li>

                  <li
                    class="page-item"
                    v-for="page in totalPages"
                    :key="page"
                    :class="{ active: page === currentPage }"
                  >
                    <a
                      class="page-link"
                      href="#"
                      @click.prevent="goToPage(page)"
                      >{{ page }}</a
                    >
                  </li>

                  <li
                    class="page-item"
                    :class="{ disabled: currentPage === totalPages }"
                  >
                    <a
                      class="page-link"
                      href="#"
                      @click.prevent="goToPage(currentPage + 1)"
                      >Next</a
                    >
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    tenancy: {
      type: Object,
      required: true,
    },
    tenantPayment: {
      type: Array,
      required: true,
    },
  },

  methods: {
    formatPHP(amount) {
      const number = parseFloat(amount || 0);
      return (
        "₱" +
        number.toLocaleString("en-PH", {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2,
        })
      );
    },
    goToPage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page;
      }
    },
  },

  data() {
    return {
      currentPage: 1,
      itemsPerPage: 10,
      searchQuery: "",
    };
  },
  computed: {
    filteredPayments() {
      if (!this.searchQuery.trim()) return this.tenantPayment;

      const query = this.searchQuery.toLowerCase();

      return this.tenantPayment.filter((payment) =>
        Object.values(payment).some((value) =>
          String(value).toLowerCase().includes(query)
        )
      );
    },
    paginatedPayments() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      const end = start + this.itemsPerPage;
      return this.filteredPayments.slice(start, end);
    },

    totalPages() {
      return Math.ceil(this.filteredPayments.length / this.itemsPerPage);
    },

    totalAmount() {
      return this.tenantPayment
        .reduce((sum, payment) => {
          return sum + parseFloat(payment.amount || 0);
        }, 0)
        .toFixed(2); // Format to 2 decimal places
    },
  },

  mounted() {
    console.log("Component Admin/Viewledger.vue mounted.");
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
</style>
