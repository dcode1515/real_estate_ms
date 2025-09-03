<template>
  <div>
    <div class="row justify-content-center">
      <div class="col-xxl-9">
        <div class="card shadow-lg" id="demo">
          <!-- Header with icon and title -->
          <div
            class="card-header d-flex flex-wrap align-items-center mb-3 gap-2"
          >
            <i class="bi bi-person-circle fs-3 me-2 text-primary"></i>
            <h4 class="mb-0 flex-grow-1">Create Lease/Tenancy</h4>
            <div class="d-flex flex-wrap gap-2 ms-auto">
              <a  v-bind:href="'/real_estate_ms/show/tenancy'" class="btn btn-outline-primary">
                <i class="ri-download-2-line align-bottom me-1"></i>
                <span class="d-none d-sm-inline">Back</span>
                <span class="d-inline d-sm-none">PDS</span>
              </a>
            </div>
          </div>

          

          <div class="card-body">
            <!-- Note for required fields -->
            <div class="alert alert-info mb-4" role="alert">
              <strong>Note:</strong> Please fill out the information marked by
              an asterisk (<span class="text-danger">*</span>).
            </div>

            <div class="row">
              <!-- Property Information Section -->
              <div class="col-lg-12">
                <h5 class="mb-3 text-primary">
                  <i class="bi bi-house-door-fill me-2"></i> Property
                  Information
                </h5>

                <!-- Property Availed -->
                <div class="form-floating mb-3 position-relative">
                  <v-select
                    v-model="formData.propertyAvailed"
                    :reduce="(property) => property.id"
                    :options="properties"
                    :get-option-label="getOptionLabel"
                    placeholder="Select Property *"
                    label="property_name"
                    required
                    class="custom-select"
                  />

                  <label for="property_availed" class="form-label"> </label>
                  <i
                    class="bi bi-search position-absolute top-50 end-0 translate-middle-y me-3"
                    style="font-size: 18px; color: #6c757d"
                  ></i>
                </div>

                <!-- Tenant Information Section -->
                <h5 class="mb-3 text-primary">
                  <i class="bi bi-person-fill me-2"></i> Tenant Information
                </h5>

                <!-- Tenant Name -->
                <div class="form-floating mb-3 position-relative">
                  <v-select
                    v-model="formData.tenant"
                    :reduce="(tenant) => tenant.id"
                    :options="tenants"
                    :get-option-label="getOptionLabelTenant"
                    placeholder="Select Tenant *"
                    label="tenant_name"
                    required
                    class="custom-select"
                  />
                  <label for="tenant" class="form-label"></label>
                  <i
                    class="bi bi-search position-absolute top-50 end-0 translate-middle-y me-3"
                    style="font-size: 18px; color: #6c757d"
                  ></i>
                </div>

                <!-- Lease Start and End Dates -->
                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-floating mb-3 position-relative">
                      <input
                        type="date"
                        class="form-control"
                        id="lease_start_date"
                        v-model="formData.leaseStartDate"
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
                        v-model="formData.leaseEndDate"
                        required
                      />
                      <label for="lease_end_date"
                        >Lease End Date
                        <span class="text-danger">*</span></label
                      >
                    </div>
                  </div>
                </div>

                <!-- Monthly Rent -->
                <div class="form-floating mb-3 position-relative">
                  <input
                    type="number"
                    class="form-control"
                    id="rent_amount"
                    v-model="formData.monthlyRent"
                    placeholder="Rent Amount"
                    required
                  />
                  <label for="rent_amount"
                    >Monthly Rent Amount
                    <span class="text-danger">*</span></label
                  >
                  <i
                    class="bi bi-cash-coin position-absolute top-50 end-0 translate-middle-y me-3"
                  ></i>
                </div>

                <!-- Lease Duration and Total Rent Computation -->
                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-floating mb-3 position-relative">
                      <input
                        type="text"
                        class="form-control"
                        id="lease_duration"
                        :value="leaseDuration"
                        @input="updateLeaseDuration"
                        readonly
                        style="
                          background-color: #f8f9fa;
                          color: #495057;
                          text-align: center;
                        "
                      />
                      <label for="lease_duration">
                        <i class="bi bi-calendar-week me-2"></i> Lease Duration
                      </label>
                    </div>
                  </div>

                  <div class="col-lg-6">
                    <div class="form-floating mb-3 position-relative">
                      <input
                        type="number"
                        class="form-control"
                        id="total_amount"
                        :value="totalAmount"
                        @input="updateTotalAmount"
                        readonly
                        style="
                          background-color: #f8f9fa;
                          font-weight: bold;
                          color: #28a745;
                          text-align: center;
                        "
                      />
                      <label for="total_amount">
                        <i class="bi bi-cash-stack me-2"></i> Over All Total
                        Amount
                      </label>
                    </div>
                  </div>
                </div>

                <!-- Lease Documents Upload -->
                <div class="form-floating mb-3 position-relative">
                  <input
                    type="file"
                    class="form-control"
                    id="lease_documents"
                    @change="handleFileUpload($event, 'upload_lease_document')"
                    required
                  />
                  <label for="lease_documents"
                    >Upload Lease Documents
                    <span class="text-danger">*</span></label
                  >
                  <i
                    class="bi bi-upload position-absolute top-50 end-0 translate-middle-y me-3"
                  ></i>
                </div>

                <!-- Tenancy Terms -->
                <div class="form-floating mb-3 position-relative">
                  <textarea
                    class="form-control"
                    id="tenancy_terms"
                    v-model="formData.tenancyTerms"
                    placeholder="Tenancy Terms"
                    required
                  ></textarea>
                  <label for="tenancy_terms">
                    <i class="bi bi-file-earmark-text me-2"></i> Tenancy Terms
                    <span class="text-danger">*</span>
                  </label>
                </div>
              </div>
            </div>

            <!-- Submit Button (opens modal) -->
            <div class="d-flex justify-content-end mt-4 flex-wrap gap-2">
              <button @click="openModal" class="btn btn-primary w-sm-auto">
                <i class="bi bi-save me-1"></i> Confirm Tenancy
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal for Confirm Tenancy Details -->
    <!-- Enhanced Confirmation Modal -->
    <div
      class="modal fade"
      id="confirmTenancyModal"
      tabindex="-1"
      aria-labelledby="modalProperty"
      aria-hidden="true"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
    >
      <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
          <div class="modal-header">
            <h5 class="modal-title" id="confirmTenancyModalLabel">
              <i class="bi bi-check-circle-fill text-success me-2"></i>Confirm
              Tenancy Details
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <!-- Display the form data in a table format with additional info -->
            <div class="alert alert-info mb-4">
              <i class="bi bi-info-circle me-2"></i>
              Please review the tenancy details below before confirming.
            </div>

            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>Field</th>
                  <th>Details</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <th>Property Name</th>
                  <td>{{ propertyName }}</td>
                </tr>
                <tr>
                  <th>Tenant Name</th>
                  <td>{{ tenantName }}</td>
                </tr>
                <tr>
                  <th>Lease Start Date</th>
                  <td>{{ formData.leaseStartDate }}</td>
                </tr>
                <tr>
                  <th>Lease End Date</th>
                  <td>{{ formData.leaseEndDate }}</td>
                </tr>
                <tr>
                  <th>Monthly Rent</th>
                  <td>{{ formData.monthlyRent }}</td>
                </tr>
                <tr>
                  <th>Lease Duration</th>
                  <td>{{ leaseDuration }}</td>
                </tr>
                <tr>
                  <th>Total Rent</th>
                  <td>{{ totalAmount }}</td>
                </tr>
                <tr>
                  <th>Tenancy Terms</th>
                  <td>{{ formData.tenancyTerms }}</td>
                </tr>
                <tr>
                  <th>Uploaded Lease Document</th>
                  <td>
                    <!-- Display file name -->
                    <span v-if="uploadedLeaseDocumentName">
                      {{ uploadedLeaseDocumentName }}
                    </span>
                    <!-- Optionally add a link for downloading -->
                    <span v-else>No file uploaded</span>
                  </td>
                </tr>
              </tbody>
            </table>

            <!-- Additional Notes Section -->
            <div class="mt-4">
              <h6>
                <i class="bi bi-file-earmark-text me-2"></i>Important Notes:
              </h6>
              <ul class="list-group list-group-flush">
                <li class="list-group-item">
                  <i class="bi bi-check-circle-fill me-2 text-success"></i>
                  Ensure all details are correct before confirming.
                </li>
                <li class="list-group-item">
                  <i class="bi bi-check-circle-fill me-2 text-success"></i>
                  Lease start and end dates are critical for proper rental
                  calculations.
                </li>
                <li class="list-group-item">
                  <i class="bi bi-check-circle-fill me-2 text-success"></i> Make
                  sure to upload the required lease documents.
                </li>
              </ul>
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              <i class="bi bi-x-circle me-2"></i> Close
            </button>
            <button
              class="btn btn-primary"
              :disabled="isSubmitting"
              @click="submitTenancy"
            >
              <span v-if="isSubmitting">
                <i class="fas fa-spinner fa-spin me-2"></i> Saving...
              </span>
              <span v-else>
                <i class="fas fa-save me-2"></i>
                Submit
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import Swal from "sweetalert2";

export default {
  components: {
    vSelect,
  },
  data() {
    return {
      uploadedLeaseDocumentName: "",
      isSubmitting: false, // for loading state
      formData: {
        propertyAvailed: "",
        tenant: "",
        leaseStartDate: "",
        leaseEndDate: "",
        monthlyRent: 0,
        leaseDocuments: null,
        tenancyTerms: "",
     
       
        upload_lease_document: null,
      },
         totalAmount: "",
          leaseDuration: "",

      properties: [],
      tenants: [],
    };
  },
  watch: {
    "formData.leaseStartDate": "computeLeaseDetails",
    "formData.leaseEndDate": "computeLeaseDetails",
    "formData.monthlyRent": "computeTotalAmount",
  },
  methods: {
    handleFileUpload(event, field) {
      const file = event.target.files[0];
      this.formData[field] = file;

      // Store file name to display in modal
      this.uploadedLeaseDocumentName = file ? file.name : "";
    },
    updateLeaseDuration(event) {
      this.leaseDuration = event.target.value;
    },
    updateTotalAmount(event) {
      this.totalAmount = event.target.value;
    },
    async submitTenancy() {
      try {
        this.isSubmitting = true;

        const formData = new FormData();
        formData.append("propertyAvailed", this.formData.propertyAvailed);
        formData.append("tenant", this.formData.tenant);
        formData.append("leaseStartDate", this.formData.leaseStartDate);
        formData.append("leaseEndDate", this.formData.leaseEndDate);

        formData.append("totalAmount", this.totalAmount);
        formData.append("leaseDuration", this.leaseDuration);
        formData.append("monthlyRent", this.formData.monthlyRent);

        formData.append("tenancyTerms", this.formData.tenancyTerms);

        // If file is selected, append it to formData
        if (this.formData.upload_lease_document instanceof File) {
          formData.append(
            "upload_lease_document",
            this.formData.upload_lease_document
          );
        }

        let response = await axios.post(
          "/real_estate_ms/api/store/tenancy",
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

    openModal() {
      this.formErrors = [];

      // Validate form fields
      if (!this.formData.propertyAvailed) {
        this.formErrors.push("Property is required.");
      }
      if (!this.formData.tenant) {
        this.formErrors.push("Tenant is required.");
      }
      if (!this.formData.leaseStartDate) {
        this.formErrors.push("Lease Start Date is required.");
      }
      if (!this.formData.leaseEndDate) {
        this.formErrors.push("Lease End Date is required.");
      }
      if (!this.formData.monthlyRent || this.formData.monthlyRent <= 0) {
        this.formErrors.push("Monthly Rent must be a positive number.");
      }
      if (!this.formData.tenancyTerms) {
        this.formErrors.push("Tenancy Terms are required.");
      }

      // File validation for upload_lease_document
      if (!this.formData.upload_lease_document) {
        this.formErrors.push("Lease document is required.");
      } else {
        const file = this.formData.upload_lease_document;
        const fileExtension = file.name.split(".").pop().toLowerCase();
        if (fileExtension !== "pdf") {
          this.formErrors.push("Lease document must be a PDF.");
        }
      }

      // If there are errors, show them and prevent opening modal
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

      // If no errors, show the modal
      $("#confirmTenancyModal").modal("show");
    },

    async fetchTenants() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/available/tenant"
        );
        // Directly use the data as an array of objects
        this.tenants = response.data;
      } catch (error) {
        console.error("Error fetching properties:", error);
      }
    },
    async fetchProperties() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/available/property"
        );
        // Directly use the data as an array of objects
        this.properties = response.data;
      } catch (error) {
        console.error("Error fetching properties:", error);
      }
    },

    getOptionLabel(property) {
      return `${property.property_name} (${property.monthly_rate})`; // This will show the property name and monthly rate
    },
    getOptionLabelTenant(tenant) {
      return `${tenant.tenant_name} (${tenant.contact_number})`; // This will show the property name and monthly rate
    },
    computeLeaseDetails() {
      if (this.formData.leaseStartDate && this.formData.leaseEndDate) {
        const start = new Date(this.formData.leaseStartDate);
        const end = new Date(this.formData.leaseEndDate);

        let years = end.getFullYear() - start.getFullYear();
        let months = end.getMonth() - start.getMonth();

        if (months < 0) {
          years--;
          months += 12;
        }

        this.leaseDuration = `${years} year(s) ${months} month(s)`;
        this.computeTotalAmount();
      }
    },
    computeTotalAmount() {
      if (
        this.formData.monthlyRent &&
        this.formData.leaseStartDate &&
        this.formData.leaseEndDate
      ) {
        const start = new Date(this.formData.leaseStartDate);
        const end = new Date(this.formData.leaseEndDate);

        const totalMonths =
          (end.getFullYear() - start.getFullYear()) * 12 +
          end.getMonth() -
          start.getMonth();

        if (totalMonths < 0) return;

        this.totalAmount = this.formData.monthlyRent * totalMonths;
      }
    },
    handleSubmit() {
      console.log("Form Data:", this.formData);
      console.log("Total Rent to be paid:", this.totalAmount);
    },
  },
  computed: {
    propertyName() {
      const selectedProperty = this.properties.find(
        (property) => property.id === this.formData.propertyAvailed
      );
      return selectedProperty ? selectedProperty.property_name : ""; // Return empty string if not found
    },
    tenantName() {
      const selectedTenant = this.tenants.find(
        (tenant) => tenant.id === this.formData.tenant
      );
      return selectedTenant ? selectedTenant.tenant_name : ""; // Return empty string if not found
    },
  },

  mounted() {
    this.fetchTenants();
    this.fetchProperties();
  },
};
</script>

<style scoped>
/* Custom styling */
#lease_duration,
#total_amount {
  text-align: center;
  font-weight: bold;
  color: #495057;
}

#lease_duration {
  background-color: #f8f9fa;
}

#total_amount {
  background-color: #f8f9fa;
  color: #28a745;
}

.bi-calendar-week,
.bi-cash-stack {
  font-size: 1.2rem;
}

.bi-search,
.bi-person-fill,
.bi-upload,
.bi-file-earmark-text {
  font-size: 1.2rem;
}
</style>
