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
          <i class="fas fa-user"></i> Show Tenancy
        </button>
      </li>
    </ul>
    <div class="tab-content" id="myTabContent">
      <div
        class="tab-pane fade show active"
        id="tenancy"
        role="tabpanel"
        aria-labelledby="tenancy-tab"
      >
        <div class="row mb-3">
          <div class="col-md-2">
            <select
              class="form-control"
              v-model="perPage"
              @change="getDataTenancy"
            >
              <option value="5">5 per page</option>
              <option value="10">10 per page</option>
              <option value="25">25 per page</option>
              <option value="50">50 per page</option>
              <option value="100">100 per page</option>
            </select>
          </div>

          <div class="col-md-8">
            <input
              v-model="searchQuery"
              @input="getDataTenancy"
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
              <i class="fas fa-plus"></i> Create Lease/Tenancy
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
                    Lease Start Date
                  </th>
                  <th style="background-color: #198754; color: white">
                    Lease End Date
                  </th>
                  <th style="background-color: #198754; color: white">
                    Monthly Rent Amount
                  </th>
                  <th style="background-color: #198754; color: white">Total</th>
                  <th style="background-color: #198754; color: white">
                    Duration
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
                  <th style="background-color: #198754; color: white">
                    Actions
                  </th>
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
                <tr
                  v-for="(tenancy, index) in tenancies.data"
                  :key="tenancy.id"
                >
                  <td class="text-center">
                    {{
                      (tenancies.current_page - 1) * tenancies.per_page +
                      index +
                      1
                    }}
                  </td>
                  <td>{{ tenancy.transaction_no }}</td>
                  <td>{{ formatDate(tenancy.lease_start_date) }}</td>
                  <td>{{ formatDate(tenancy.lease_end_date) }}</td>

                  <td>{{ formatAmount(tenancy.monthly_rent_amount) }}</td>
                  <td>{{ formatAmount(tenancy.total_amount) }}</td>

                  <td>{{ tenancy.lease_duration }}</td>
                  <td>{{ tenancy.tenant.tenant_name }}</td>

                  <td>{{ tenancy.tenant.contact_number }}</td>
                  <td>{{ tenancy.property.property_no }}</td>
                  <td>{{ tenancy.property.property_name }}</td>
                  <td>{{ tenancy.property.property_type }}</td>
                  <td>{{ tenancy.status }}</td>
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
            <nav v-if="tenancies.total > 0" aria-label="Page navigation">
              <ul class="pagination justify-content-center mt-3">
                <!-- Previous Button -->
                <li
                  class="page-item"
                  :class="{ disabled: tenancies.current_page === 1 }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(tenancies.current_page - 1)"
                    >Previous</a
                  >
                </li>

                <!-- Page Numbers -->
                <li
                  class="page-item"
                  v-for="page in totalPages"
                  :key="page"
                  :class="{ active: page === tenancies.current_page }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(page)"
                  >
                    {{ page }}
                  </a>
                </li>

                <!-- Next Button -->
                <li
                  class="page-item"
                  :class="{
                    disabled: tenancies.current_page === totalPages,
                  }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(tenancies.current_page + 1)"
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
</template>

<script>
export default {
  methods: {
     formatDate(date) {
      if (!date) return "";
      return new Date(date).toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric"
      });
    },
    formatAmount(value) {
      if (value == null) return "";
      return new Intl.NumberFormat("en-US").format(value);
    },
    async getDataTenancy() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/data/tenancy",
          {
            params: {
              page: this.tenancies.current_page,
              per_page: this.perPage,
              search: this.searchQuery,
            },
          }
        );

        this.tenancies = response.data.data;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
      changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.tenancies.current_page = page;
        this.getDataTenancy();
      }
    },
  },
  data() {
    return {
      searchQuery: "",
      perPage: 10,
      tenancies: {
        data: [],
        current_page: 1,
        last_page: 1,
        per_page: 10,
        total: 0,
      },
    };
  },
  computed: {
    totalPages() {
      return Math.ceil(this.tenancies.total / this.tenancies.per_page);
    },
  },
  mounted() {
    this.getDataTenancy();
    console.log("Component Mounted");
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
