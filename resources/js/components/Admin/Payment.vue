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
          <i class="fas fa-credit-card"></i> Payment
        </button>
      </li>
    </ul>
    <!-- Income Summary Boxes -->
    <div class="row mb-4 mt-3">
      <div class="col-md-3 col-sm-6 mb-3">
        <div class="card income-box today shadow-sm">
          <div class="card-body d-flex flex-column align-items-center">
            <i class="fas fa-coins icon"></i>
            <span class="income-label">Today Income</span>
            <h4 class="fw-bold mt-2" style="color: white">
              ₱{{ formatAmount(todayIncome) }}
            </h4>
          </div>
        </div>
      </div>

      <div class="col-md-3 col-sm-6 mb-3">
        <div class="card income-box monthly shadow-sm">
          <div class="card-body d-flex flex-column align-items-center">
            <i class="fas fa-calendar-alt icon"></i>
            <span class="income-label">Monthly Income</span>
            <h4 class="fw-bold mt-2" style="color: white">
              ₱{{ formatAmount(monthlyIncome) }}
            </h4>
          </div>
        </div>
      </div>

      <div class="col-md-3 col-sm-6 mb-3">
        <div class="card income-box yearly shadow-sm">
          <div class="card-body d-flex flex-column align-items-center">
            <i class="fas fa-calendar icon"></i>
            <span class="income-label">Yearly Income</span>
            <h4 class="fw-bold mt-2" style="color: white">
              ₱{{ formatAmount(yearlyIncome) }}
            </h4>
          </div>
        </div>
      </div>

      <div class="col-md-3 col-sm-6 mb-3">
        <div class="card income-box overall shadow-sm">
          <div class="card-body d-flex flex-column align-items-center">
            <i class="fas fa-wallet icon"></i>
            <span class="income-label">Overall Income</span>
            <h4 class="fw-bold mt-2" style="color: white">
              ₱{{ formatAmount(overallIncome) }}
            </h4>
          </div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-2">
          <select class="form-control">
            <option value="5">5 per page</option>
            <option value="10">10 per page</option>
            <option value="25">25 per page</option>
            <option value="50">50 per page</option>
            <option value="100">100 per page</option>
          </select>
        </div>

        <div class="col-md-8">
          <input
            type="text"
            class="form-control"
            style="position: left"
            placeholder="Search Properties..."
          />
        </div>
        <div class="col-md-2 d-flex justify-content-end align-items-center">
          <a
            v-bind:href="'/real_estate_ms/create/tenancy'"
            class="btn btn-success"
            type="button"
          >
            <i class="fas fa-plus"></i> Create Payment
          </a>
        </div>
        <div class="table-responsive">
          <br />

          <table>
            <thead>
              <tr>
                <th style="background-color: #198754; color: white">#</th>
                <th style="background-color: #198754; color: white">
                  Transaction No.
                </th>
                <th style="background-color: #198754; color: white">
                  Invoice No
                </th>
                <th style="background-color: #198754; color: white">
                  Mode of Payment
                </th>
                <th style="background-color: #198754; color: white">Amount</th>
                <th style="background-color: #198754; color: white">
                  Account Number
                </th>
                <th style="background-color: #198754; color: white">Total</th>

                <th style="background-color: #198754; color: white">
                  Date Paid
                </th>

                <th
                  colspan="2"
                  class="blue"
                  style="background-color: #198754; color: white"
                >
                  Tenant Information
                </th>
                <th
                  colspan="4"
                  class="blue"
                  style="background-color: #198754; color: white"
                >
                  Properties Information
                </th>
                <th style="background-color: #198754; color: white">Actions</th>
                <!-- ✅ New -->
              </tr>
              <tr>
                <th></th>
                <th></th>

                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                
                <!-- <th>Next In Rank</th> -->
                <th>Name</th>

                <th>Contact</th>

                <th>Property No</th>
                <th>Property Name</th>
                <th>Property Type</th>
                <th>Square Meter</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <!-- Add empty rows to match the design -->
              <tr>
                <td class="text-center"></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td class="text-center">
                  <a>
                    <i
                      class="bi bi-pencil-square text-primary"
                      style="font-size: 1.2rem"
                    ></i>
                  </a>
                </td>
              </tr>
              <!-- Repeat for more rows as needed -->
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Your existing tabs -->
  </div>
</template>

<script>
export default {
  data() {
    return {
      todayIncome: 9300,
      monthlyIncome: 75000,
      yearlyIncome: 912000,
      overallIncome: 3500000,
    };
  },
  methods: {
    formatAmount(value) {
      if (!value) return "0";
      return new Intl.NumberFormat("en-US").format(value);
    },
  },
};
</script>


<style scoped>
.income-box {
  border-radius: 15px;
  color: white;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  cursor: pointer;
  text-align: center;
}

.income-box .icon {
  font-size: 2rem;
  opacity: 0.9;
}

.income-box:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 18px rgba(0, 0, 0, 0.2);
}

/* Dark Label for each box */
.income-label {
  display: inline-block;
  background: rgba(0, 0, 0, 0.75);
  color: #fff;
  font-size: 0.8rem;
  font-weight: 600;
  padding: 4px 12px;
  border-radius: 12px;
  margin-top: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Different Gradient Colors */
.income-box.today {
  background: linear-gradient(135deg, #28a745, #218838);
}
.income-box.monthly {
  background: linear-gradient(135deg, #007bff, #0056b3);
}
.income-box.yearly {
  background: linear-gradient(135deg, #ffc107, #d39e00);
  color: black;
}
.income-box.overall {
  background: linear-gradient(135deg, #6f42c1, #4b0082);
}

/* Responsive Scaling */
@media screen and (max-width: 768px) {
  .income-box .icon {
    font-size: 1.5rem;
  }
  .income-box h4 {
    font-size: 1.2rem;
  }
  .income-label {
    font-size: 0.7rem;
    padding: 3px 8px;
  }
}
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
