<template>
  <div>
    <ul class="nav nav-tabs" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button
          class="nav-link active"
          id="generallist-tab"
          data-bs-toggle="tab"
          data-bs-target="#generallist"
          type="button"
          role="tab"
          aria-controls="generallist"
          aria-selected="true"
        >
          <i class="fas fa-users"></i> TENANT LIST
        </button>
      </li>
    </ul>
    <div class="tab-content" id="myTabContent">
      <div
        class="tab-pane fade show active"
        id="generallist"
        role="tabpanel"
        aria-labelledby="generallist-tab"
      >
        <div class="row mb-3">
          <div class="col-md-2">
            <select
              class="form-control"
              v-model="perPage"
              @change="getDataTenant"
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
              @input="getDataTenant"
              type="text"
              class="form-control"
              style="position: left"
              placeholder="Search Tenants..."
            />
          </div>
          <div class="col-md-2 d-flex justify-content-end align-items-center">
            <button
              class="btn btn-success"
              type="button"
              @click="openModal('add')"
            >
              <i class="fas fa-plus"></i> Create Tenant
            </button>
          </div>
          <div class="table-responsive">
            <br />
            <table>
              <thead>
                <tr>
                  <th
                    style="
                      background-color: #198754;
                      color: white;
                      font-weight: bold;
                    "
                  >
                    #
                  </th>
                  <th style="background-color: #198754; color: white">
                    Tenant No.
                  </th>
                  <th style="background-color: #198754; color: white">
                    Tenant Name
                  </th>
                  <th style="background-color: #198754; color: white">
                    Tenant Contact
                  </th>
                  <th style="background-color: #198754; color: white">
                    Tenant Address
                  </th>
                  <th style="background-color: #198754; color: white">
                    Document Attach
                  </th>
                  <th style="background-color: #198754; color: white">
                    Status
                  </th>
                  <th style="background-color: #198754; color: white">
                    Action
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(tenant, index) in tenants.data" :key="tenant.id">
                  <td class="text-center">
                    {{
                      (tenants.current_page - 1) * tenants.per_page + index + 1
                    }}
                  </td>
                  <td>{{ tenant.tenant_no }}</td>
                  <td>{{ tenant.tenant_name }}</td>
                  <td>{{ tenant.contact_number }}</td>
                  <td>{{ tenant.address }}</td>
                  <td>
                    <a
                      v-bind:href="
                        '/real_estate_ms/download/attachment/tenant/' +
                        tenant.id
                      "
                      type="button"
                      class="btn btn-danger"
                      target="_blank"
                    >
                      <i class="fas fa-download me-2"></i> Download
                    </a>
                  </td>

                  <td>{{ tenant.status }}</td>
                  <td>
                    <!-- <button class="btn btn-primary btn-sm me-1" title="View"  @click="openModalViewTenant('edit_t', tenant)">
                      <i class="fas fa-eye"></i>
                    </button> -->
                    <button
                      class="btn btn-warning btn-sm me-1"
                      title="Edit"
                      @click="openModal('edit', tenant)"
                    >
                      <i class="fas fa-edit"></i>
                    </button>
                        <a
                         @click="deleteTenant(tenant)"
                        type="button"
                        class="btn btn-danger btn-sm me-1"
                        title="Delete"
                        >
                        <i class="fas fa-trash"></i>
                        </a>
                    <!-- <button class="btn btn-danger btn-sm" title="Delete">
                      <i class="fas fa-trash"></i>
                    </button> -->
                  </td>
                </tr>
              </tbody>
            </table>
            <nav v-if="tenants.total > 0" aria-label="Page navigation">
              <ul class="pagination justify-content-center mt-3">
                <!-- Previous Button -->
                <li
                  class="page-item"
                  :class="{ disabled: tenants.current_page === 1 }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(tenants.current_page - 1)"
                    >Previous</a
                  >
                </li>

                <!-- Page Numbers -->
                <li
                  class="page-item"
                  v-for="page in totalPages"
                  :key="page"
                  :class="{ active: page === tenants.current_page }"
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
                    disabled: tenants.current_page === totalPages,
                  }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(tenants.current_page + 1)"
                    >Next</a
                  >
                </li>
              </ul>
            </nav>

            <div
              class="modal fade"
              id="modalTenant"
              tabindex="-1"
              aria-labelledby="modalTenant"
              aria-hidden="true"
              data-bs-backdrop="static"
              data-bs-keyboard="false"
            >
              <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg rounded-4">
                  <!-- Header -->
                  <div
                    class="modal-header text-white py-3"
                    style="background: linear-gradient(90deg, #198754, #198754)"
                  >
                    <h4
                      class="modal-title d-flex align-items-center"
                      style="color: white"
                    >
                      <i class="fa fa-file-alt me-2"></i>{{ modalTitle }}
                    </h4>
                    <button
                      type="button"
                      class="btn-close btn-close-white"
                      data-bs-dismiss="modal"
                      aria-label="Close"
                    ></button>
                  </div>

                  <!-- Body -->
                  <div class="modal-body">
                    <!-- Info Alert -->
                    <div class="mb-4">
                      <div class="row">
                        <div class="col-md-12">
                          <div class="form-floating mb-3">
                            <input
                              type="date"
                              class="form-control"
                              id="date_created"
                              v-model="formData.date_created"
                              placeholder="Date Created"
                              required
                            />
                            <label for="date_created"
                              >Date Created
                              <span class="text-danger">*</span></label
                            >
                          </div>
                        </div>
                        <div class="col-md-12">
                          <div class="form-floating mb-3">
                            <input
                              type="text"
                              class="form-control"
                              id="tenant_name"
                              v-model="formData.tenant_name"
                              placeholder="Tenant Name"
                              required
                            />
                            <label for="tenant_name"
                              >Tenant Name
                              <span class="text-danger">*</span></label
                            >
                          </div>
                        </div>
                        <div class="col-md-12">
                          <div class="form-floating mb-3">
                            <input
                              type="text"
                              class="form-control"
                              id="contact_no"
                              v-model="formData.contact_no"
                              placeholder="Contact No."
                              required
                            />
                            <label for="contact_no"
                              >Contact No.
                              <span class="text-danger">*</span></label
                            >
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-12">
                          <div class="form-floating mb-3">
                            <input
                              type="text"
                              class="form-control"
                              id="address"
                              v-model="formData.address"
                              placeholder="Address"
                              required
                            />
                            <label for="address"
                              >Address <span class="text-danger">*</span></label
                            >
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <!-- <div class="col-md-4">
                          <div class="form-floating mb-3">
                            <input
                              type="number"
                              class="form-control"
                              id="monthly_payment"
                              v-model="formData.monthly_payment"
                              placeholder="Monthly Payment"
                              required
                            />
                            <label for="monthly_payment"
                              >Monthly Payment
                              <span class="text-danger">*</span></label
                            >
                          </div>
                        </div> -->
                        <!-- <div class="col-md-4">
                          <div class="form-floating mb-3">
                            <input
                              type="text"
                              class="form-control"
                              id="lease_period"
                              v-model="formData.lease_period"
                              placeholder="Lease Period"
                              required
                            />
                            <label for="lease_period"
                              >Lease Period
                              <span class="text-danger">*</span></label
                            >
                          </div>
                        </div> -->
                        <!-- <div class="col-md-4">
                          <div class="form-floating mb-3">
                            <input
                              type="date"
                              class="form-control"
                              id="due_date"
                              v-model="formData.due_date"
                              placeholder="Due Date"
                              required
                            />
                            <label for="due_date"
                              >Due Date
                              <span class="text-danger">*</span></label
                            >
                          </div>
                        </div> -->
                      </div>
                      <hr />
                      <h5>Documents Attached</h5>
                      <div class="row">
                        <div class="col-md-4">
                          <label class="form-label"
                            >1. Contracts
                            <span class="text-danger">*</span></label
                          >
                          <input
                            type="file"
                            class="form-control"
                            @change="handleFileUpload($event, 'contracts')"
                          />
                        </div>
                        <div class="col-md-4">
                          <label class="form-label"
                            >2. ID 1 <span class="text-danger">*</span></label
                          >
                          <input
                            type="file"
                            class="form-control"
                            @change="handleFileUpload($event, 'id1')"
                          />
                        </div>
                        <div class="col-md-4">
                          <label class="form-label"
                            >3. ID 2 <span class="text-danger">*</span></label
                          >
                          <input
                            type="file"
                            class="form-control"
                            @change="handleFileUpload($event, 'id2')"
                          />
                        </div>
                      </div>
                    </div>

                    <!-- Applicant Card -->
                  </div>

                  <!-- Footer -->
                  <div
                    class="modal-footer bg-light border-0 py-3 px-4 d-flex justify-content-end"
                  >
                    <button
                      type="button"
                      class="btn btn-success px-4 py-2 shadow-sm"
                      :disabled="isSubmitting"
                      @click="submitTenant"
                    >
                      <!-- Spinner icon while submitting -->
                      <span v-if="isSubmitting">
                        <i class="fas fa-spinner fa-spin me-2"></i> Saving...
                      </span>

                      <!-- Add or Edit icon and label -->
                      <span v-else>
                        <i class="fas fa-save me-2"></i>
                        {{
                          modalMode === "add" ? "Add Tenant" : "Save Changes"
                        }}
                      </span>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Swal from "sweetalert2";

export default {
  methods: {
    async deleteTenant(tenant) {
      const confirmation = await Swal.fire({
        title: "Are you sure?",
        text: `You are about to delete tenant: ${tenant.tenant_name}. This action cannot be undone.`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel",
      });

      if (confirmation.isConfirmed) {
        try {
          const response = await axios.delete(
            `/real_estate_ms/api/delete/tenant/${tenant.id}`
          );

          // Success alert with OK and then redirect
          await Swal.fire({
            title: "Deleted!",
            text: response.data.success,
            icon: "success",
            confirmButtonText: "OK",
          });

          // ✅ After user clicks "OK", redirect
          window.location.href = "/real_estate_ms/tenants"; // Change this path to your actual route
        } catch (error) {
          if (error.response && error.response.status === 422) {
            await Swal.fire({
              title: "Error",
              text: error.response.data.error,
              icon: "error",
            });
          } else {
            await Swal.fire({
              title: "Unexpected Error",
              text: "Something went wrong while trying to delete.",
              icon: "error",
            });
            console.error(error);
          }
        }
      }
    },

    handleFileUpload(event, field) {
      this.formData[field] = event.target.files[0];
    },

    async getDataTenant() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/data/tenant",
          {
            params: {
              page: this.tenants.current_page,
              per_page: this.perPage,
              search: this.searchQuery,
            },
          }
        );

        this.tenants = response.data.data;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },

    changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.tenants.current_page = page;
        this.getDataTenant();
      }
    },
    async submitTenant() {
      try {
        this.isSubmitting = true;

        const formData = new FormData();
        formData.append("date_created", this.formData.date_created);
        formData.append("tenant_name", this.formData.tenant_name);
        formData.append("contact_no", this.formData.contact_no);
        formData.append("address", this.formData.address);
        formData.append("monthly_rate", this.formData.monthly_payment);
        formData.append("lease_period", this.formData.lease_period);
        formData.append("due_date", this.formData.due_date);
        if (this.formData.contracts) {
          formData.append("contracts", this.formData.contracts);
        }

        if (this.formData.id1) {
          formData.append("id1", this.formData.id1);
        }

        if (this.formData.id2) {
          formData.append("id2", this.formData.id2);
        }

        let response;

        if (this.modalMode === "add") {
          // POST request for adding new tenant
          response = await axios.post(
            "/real_estate_ms/api/store/tenant",
            formData,
            {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            }
          );
        } else if (this.modalMode === "edit") {
          // PUT or POST request for updating existing tenant
          // Adjust the URL and method according to your backend setup
          response = await axios.post(
            `/real_estate_ms/api/update/tenant/${this.formData.id}`,
            formData,
            {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            }
          );
        }

        // Success message
        Swal.fire({
          icon: "success",
          title: "Success",
          text:
            this.modalMode === "add"
              ? "Tenant successfully added!"
              : "Tenant successfully updated!",
          confirmButtonText: "OK",
        }).then(() => {
          window.location.href = "/real_estate_ms/tenants";
        });
      } catch (error) {
        console.error(error);

        if (error.response && error.response.status === 422) {
          const errors = error.response.data.errors;
          let errorMessages = '<ul style="text-align: left;">';

          for (const key in errors) {
            if (errors.hasOwnProperty(key)) {
              errorMessages += `<li>${errors[key][0]}</li>`;
            }
          }

          errorMessages += "</ul>";

          Swal.fire({
            icon: "error",
            title: "Validation Error",
            html: errorMessages,
          });
        } else {
          Swal.fire({
            icon: "error",
            title: "Submission Failed",
            text: "Something went wrong while submitting the form.",
          });
        }
      } finally {
        this.isSubmitting = false;
      }
    },

    openModal(mode, tenant) {
      this.formData = {
        id: "",
        date_created: "",
        tenant_name: "",
        contact_no: "",
        address: "",
        monthly_payment: "",
        lease_period: "",
        due_date: "",
        contracts: null,
        id1: null,
        id2: null,
      };

      this.modalMode = mode;
      this.modalTitle =
        mode === "add"
          ? "Add Tenants"
          : mode === "edit"
          ? "Edit Tenants"
          : "View Tenants";

      if (mode === "edit" || mode === "view") {
        this.formData.id = tenant.id;
        this.formData.date_created = tenant.date_created;
        this.formData.tenant_name = tenant.tenant_name;
        this.formData.contact_no = tenant.contact_number;
        this.formData.address = tenant.address;
        this.formData.monthly_payment = tenant.rate;
        this.formData.lease_period = tenant.period;
        this.formData.due_date = tenant.duedate;
      }

      $("#modalTenant").modal("show");
    },
  },
  data() {
    return {
      modalTitle: "",
      modalMode: "add",
      isSubmitting: false, // for loading state
      selectedProperty: "", // Make sure this exists or bind to a dropdown
      formData: {
        id: "",
        date_created: "",
        tenant_name: "",
        contact_no: "",
        address: "",
        monthly_payment: "",
        lease_period: "",
        due_date: "",
        contracts: null,
        id1: null,
        id2: null,
      },
      searchQuery: "",
      perPage: 10,
      tenants: {
        data: [],
        current_page: 1,
        last_page: 1,
        per_page: 10,
        total: 0,
      },
    };
  },
  mounted() {
    // Any initialization code can go herec
    this.getDataTenant();
    console.log("Component mounted.");
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
</style>
