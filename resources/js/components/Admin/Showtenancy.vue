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
          <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="fas fa-info-circle me-2"></i>
            <div>
              <strong>Note:</strong> Property and Tenant fields are not
              editable. Payments must be completed before the lease can be
              deleted.
            </div>
          </div>

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
                    Lease Start Date
                  </th>
                  <th style="background-color: #198754; color: white">
                    Lease End Date
                  </th>
                  <th style="background-color: #198754; color: white">
                    Monthly Rent Amount
                  </th>

                  <th
                    colspan="2"
                    class="blue"
                    style="background-color: #198754; color: white"
                  >
                    Tenant Information
                  </th>
                  <th
                    colspan="2"
                    class="blue"
                    style="background-color: #198754; color: white"
                  >
                    Properties Information
                  </th>
                  <th
                    colspan="3"
                    class="blue"
                    style="background-color: #198754; color: white"
                  >
                    Payment Information
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

                  <!-- <th>Next In Rank</th> -->
                  <th>Name</th>

                  <th>Contact</th>

                  <th>Property Name</th>
                  <th>Property Type</th>
                  <th>Next Payment</th>
                  <th>No of Payment</th>
                  <th>Total</th>
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

                  <td>{{ formatDate(tenancy.lease_start_date) }}</td>
                  <td>{{ formatDate(tenancy.lease_end_date) }}</td>

                  <td>{{ formatAmount(tenancy.monthly_rent_amount) }}</td>
                  <!-- <td>{{ formatAmount(tenancy.total_amount) }}</td> -->

                  <td>{{ tenancy.tenant.tenant_name }}</td>

                  <td>{{ tenancy.tenant.contact_number }}</td>

                  <td>{{ tenancy.property.property_name }}</td>
                  <td>{{ tenancy.property.property_type }}</td>
                  <td>{{ formatDate(tenancy.due_date) }}</td>
                  <td>{{ tenancy.payment_tenants_count }}</td>
                  <td>
                    {{
                      tenancy.payment_tenants_sum_amount
                        ? new Intl.NumberFormat("en-PH", {
                            style: "currency",
                            currency: "PHP",
                          }).format(tenancy.payment_tenants_sum_amount)
                        : "₱0.00"
                    }}
                  </td>
                  <td class="text-center">
                    <a
                      @click="openModal('edit', tenancy)"
                      type="button"
                      class="btn btn-primary btn-sm"
                    >
                      <i class="fas fa-pencil-alt"></i> Edit
                    </a>
                    <a
                      v-bind:href="'/real_estate_ms/view/ledger/' + tenancy.id"
                      class="btn btn-danger btn-sm"
                      type="button"
                    >
                      <i class="fas fa-book"></i> View Ledger
                    </a>
                    <a
                      @click="deleteTenancy(tenancy)"
                      type="button"
                      class="btn btn-warning btn-sm"
                    >
                      <i class="fas fa-trash"></i> Delete
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
            <div
              class="modal fade"
              id="modalTenancies"
              tabindex="-1"
              aria-labelledby="modalTenancies"
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
                  <div
                    class="modal-body"
                    style="max-height: 70vh; overflow-y: auto"
                  >
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-floating mb-3">
                          <input
                            type="text"
                            class="form-control"
                            v-model="formData.property"
                            placeholder="Property Name"
                            required
                            disabled
                          />
                          <label for="property_name"
                            >Property Name
                            <span class="text-danger">*</span></label
                          >
                        </div>
                        <div class="form-floating mb-3">
                          <input
                            type="text"
                            class="form-control"
                            v-model="formData.tenant"
                            placeholder="Tenant Name"
                            required
                            disabled
                          />
                          <label for="tenant_name"
                            >Tenant Name
                            <span class="text-danger">*</span></label
                          >
                        </div>
                        <div class="row">
                          <div class="col-lg-6">
                            <div class="form-floating mb-3 position-relative">
                              <input
                                type="date"
                                class="form-control"
                                id="lease_start_date"
                                v-model="formData.lease_start_date"
                                required
                              />
                              <label for="lease_start_date"
                                >Lease Start Date
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-lg-6">
                            <div class="form-floating mb-3 position-relative">
                              <input
                                type="date"
                                class="form-control"
                                id="lease_end_date"
                                v-model="formData.lease_end_date"
                                required
                              />
                              <label for="lease_end_date"
                                >Lease End Date
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="form-floating mb-3">
                            <input
                              type="number"
                              class="form-control"
                              v-model="formData.monthlyRentAmount"
                              placeholder="Monthly Rate"
                              min="0"
                              required
                            />
                            <label for="monthly_rate"
                              >Monthly Rate
                              <span class="text-danger">*</span></label
                            >
                          </div>
                          <div class="col-lg-12">
                            <div class="form-floating mb-3 position-relative">
                              <input
                                type="text"
                                class="form-control"
                                id="next_payment_date"
                                v-model="formData.nextPaymentDate"
                                disabled
                              />
                              <label for="next_payment_date"
                                >Next Payment Date</label
                              >
                            </div>
                          </div>
                        </div>

                        <div class="col-lg-12">
                          <div class="row">
                            <div class="col-lg-6">
                              <div class="form-floating mb-3">
                                <input
                                  type="text"
                                  class="form-control"
                                  v-model="formData.leaseDuration"
                                  placeholder="Lease Duration"
                                  disabled
                                />
                                <label for="lease_duration"
                                  >Lease Duration
                                  <span class="text-danger">*</span></label
                                >
                              </div>
                            </div>
                            <div class="col-lg-6">
                              <div class="form-floating mb-3">
                                <input
                                  type="text"
                                  class="form-control"
                                  v-model="formData.overAllTotal"
                                  placeholder="Lease Duration"
                                  disabled
                                />
                                <label for="lease_duration"
                                  >Overall Total Amount
                                  <span class="text-danger">*</span></label
                                >
                              </div>
                            </div>
                            <div class="form-floating mb-3">
                              <input
                                type="file"
                                class="form-control"
                                id="lease_documents"
                                @change="
                                  handleFileUpload(
                                    $event,
                                    'upload_lease_document'
                                  )
                                "
                                required
                              />
                              <label for="lease_documents"
                                >Upload Lease Documents
                                <span class="text-danger">*</span></label
                              >
                            </div>
                            <div class="form-floating mb-3">
                              <textarea
                                class="form-control"
                                id="tenancy_terms"
                                v-model="formData.tenancyTerms"
                                placeholder="Tenancy Terms"
                                required
                              ></textarea>
                              <label for="tenancy_terms">
                                Tenancy Terms
                                <span class="text-danger">*</span>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- Nav Tabs -->
                  </div>

                  <!-- Footer -->
                  <div
                    class="modal-footer bg-light border-0 py-3 px-4 d-flex justify-content-end"
                  >
                    <button
                      type="button"
                      class="btn btn-success px-4 py-2 shadow-sm"
                      :disabled="isSubmitting"
                      @click="submitForm(formData.id)"
                    >
                      <!-- Spinner icon while submitting -->
                      <span v-if="isSubmitting">
                        <i class="fas fa-spinner fa-spin me-2"></i> Saving...
                      </span>

                      <!-- Add or Edit icon and label -->
                      <span v-else>
                        <i class="fas fa-save me-2"></i>
                        {{
                          modalMode === "add" ? "Add Property" : "Save Changes"
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
    async deleteTenancy(tenancy) {
      const confirmation = await Swal.fire({
        title: "Are you sure?",
        text: `You are about to delete tenancy: ${tenancy.transaction_no}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel",
      });

      if (confirmation.isConfirmed) {
        try {
          const response = await axios.delete(
            `/real_estate_ms/api/delete/tenancy/${tenancy.id}`
          );

          // Success alert with OK and then redirect
          await Swal.fire({
            title: "Deleted!",
            text: response.data.success,
            icon: "success",
            confirmButtonText: "OK",
          });

          // ✅ After user clicks "OK", redirect
          window.location.href = "/real_estate_ms/show/tenancy"; // Change this path to your actual route
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

    async submitForm(id) {
      try {
        this.isSubmitting = true;

        const formData = new FormData();
        // formData.append("property", this.formData.property);
        // formData.append("tenant", this.formData.tenant);
        formData.append("lease_start_date", this.formData.lease_start_date);
        formData.append("lease_end_date", this.formData.lease_end_date);
        formData.append("nextPaymentDate", this.formData.nextPaymentDate);

        formData.append("monthlyRentAmount", this.formData.monthlyRentAmount);
        formData.append("leaseDuration", this.formData.leaseDuration);
        formData.append("overAllTotal", this.formData.overAllTotal);

        formData.append("tenancyTerms", this.formData.tenancyTerms);

        // If file is selected, append it to formData
        if (this.formData.upload_lease_document instanceof File) {
          formData.append(
            "upload_lease_document",
            this.formData.upload_lease_document
          );
        }

        const response = await axios.post(
          "/real_estate_ms/api/update/tenancy/" + id,
          formData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
        );

        // If successful, show a success message
        Swal.fire({
          icon: "success",
          title: "Success",
          text:
            this.modalMode === "add"
              ? "Property successfully added!"
              : "Property successfully updated!",
          confirmButtonText: "OK",
        }).then(() => {
          window.location.href = "/real_estate_ms/show/tenancy";
        });
      } catch (error) {
        console.error(error);

        // Check if the error response is from Laravel validation (422)
        if (error.response && error.response.status === 422) {
          const data = error.response.data;

          // 1. Custom 'exist' error from Laravel controller (duplicate tenancy)
          if (data.exist) {
            Swal.fire({
              icon: "error",
              title: "Duplicate Property",
              text: data.exist, // The error message sent by the controller
            });
            return;
          }

          // 2. Standard validation errors
          if (data.errors) {
            let errorMessages = '<ul style="text-align: left;">';

            // Loop through formErrors to create list of error messages
            for (const key in data.errors) {
              if (data.errors.hasOwnProperty(key)) {
                errorMessages += `<li>${data.errors[key][0]}</li>`;
              }
            }

            errorMessages += "</ul>";

            Swal.fire({
              icon: "error",
              title: "Validation Error",
              html: errorMessages,
            });
          }
        } else {
          // Any other error
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
    computeLeaseDetails() {
      if (this.formData.lease_start_date && this.formData.lease_end_date) {
        const start = new Date(this.formData.lease_start_date);
        const end = new Date(this.formData.lease_end_date);

        let years = end.getFullYear() - start.getFullYear();
        let months = end.getMonth() - start.getMonth();

        if (end.getDate() < start.getDate()) {
          months--; // Adjust if end day is earlier than start day
        }

        if (months < 0) {
          years--;
          months += 12;
        }

        if (years === 0) {
          this.formData.leaseDuration = `${months} month(s)`;
        } else if (months === 0) {
          this.formData.leaseDuration = `${years} year(s)`;
        } else {
          this.formData.leaseDuration = `${years} year(s) ${months} month(s)`;
        }

        this.computeTotalAmount();
      } else {
        this.formData.leaseDuration = "";
      }
    },
    computeTotalAmount() {
      if (
        this.formData.monthlyRentAmount &&
        this.formData.lease_start_date &&
        this.formData.lease_end_date
      ) {
        const start = new Date(this.formData.lease_start_date);
        const end = new Date(this.formData.lease_end_date);

        const totalMonths =
          (end.getFullYear() - start.getFullYear()) * 12 +
          end.getMonth() -
          start.getMonth();

        if (totalMonths < 0) return;

        this.formData.overAllTotal =
          this.formData.monthlyRentAmount * totalMonths;
      }
    },
    handleFileUpload(event, field) {
      const file = event.target.files[0];
      this.formData[field] = file;

      // Store file name to display in modal
      this.uploadedLeaseDocumentName = file ? file.name : "";
    },
    openModal(mode, tenancy) {
      this.formData = {
        id: "",
        property: "",
        tenant: "",
        lease_start_date: "",
        lease_end_date: "",
        nextPaymentDate: "",
        monthlyRentAmount: "",
        leaseDuration: "",
        overAllTotal: "",
        tenancyTerms: "",
        upload_lease_document: null,
      };

      this.modalMode = mode;
      this.modalTitle =
        mode === "add"
          ? "Add Tenancies"
          : mode === "edit"
          ? "Edit Tenancies"
          : "View Tenancies";

      if (mode === "edit" || mode === "view") {
        this.formData.id = tenancy.id;
        this.formData.property = tenancy.property.property_name;
        this.formData.tenant = tenancy.tenant.tenant_name;
        this.formData.lease_start_date = tenancy.lease_start_date;
        this.formData.lease_end_date = tenancy.lease_end_date;
        this.formData.nextPaymentDate = tenancy.due_date;
        this.formData.monthlyRentAmount = tenancy.monthly_rent_amount;
        this.formData.leaseDuration = tenancy.lease_duration;
        this.formData.overAllTotal = tenancy.total_amount;
        this.formData.tenancyTerms = tenancy.tenancy_terms;
      }

      $("#modalTenancies").modal("show");
    },
    formatDate(date) {
      if (!date) return "";
      return new Date(date).toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric",
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
      isSubmitting: false,
      modalTitle: "",
      modalMode: "add",
      searchQuery: "",
      perPage: 10,
      tenancies: {
        data: [],
        current_page: 1,
        last_page: 1,
        per_page: 10,
        total: 0,
      },
      formData: {
        id: "",
        property: "",
        tenant: "",
        lease_start_date: "",
        lease_end_date: "",
        nextPaymentDate: "",
        monthlyRentAmount: "",
        leaseDuration: "",
        overAllTotal: "",
        tenancyTerms: "",
      },
    };
  },
  watch: {
    "formData.lease_start_date": "computeLeaseDetails",
    "formData.lease_end_date": "computeLeaseDetails",
    "formData.monthlyRentAmount": "computeTotalAmount",

    "formData.leaseStartDate"(newDate) {
      if (!newDate) {
        this.formData.nextPaymentDate = "";
        return;
      }

      const date = new Date(newDate);
      date.setMonth(date.getMonth() + 1);

      // Format as yyyy-mm-dd
      this.formData.nextPaymentDate = date.toISOString().split("T")[0];
    },
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
