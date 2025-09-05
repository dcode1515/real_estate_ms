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
              ₱{{ formatAmount(today_income) }}
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
              ₱{{ formatAmount(monthly_income) }}
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
              ₱{{ formatAmount(yearly_income) }}
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
              ₱{{ formatAmount(total_income) }}
            </h4>
          </div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-2">
          <select
            class="form-control"
            v-model="perPage"
            @change="getDataPayment"
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
            @input="getDataPayment"
            type="text"
            class="form-control"
            style="position: left"
            placeholder="Search Properties..."
          />
        </div>
        <div class="col-md-2 d-flex justify-content-end align-items-center">
          <a @click="openModal('add')" class="btn btn-success" type="button">
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
                  colspan="3"
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

                <!-- <th>Next In Rank</th> -->
                <th>Name</th>

                <th>Contact</th>

                <th>Property No</th>
                <th>Property Name</th>
                <th>Property Type</th>

                <th></th>
              </tr>
            </thead>
            <tbody>
              <!-- Add empty rows to match the design -->
              <tr v-for="(payment, index) in payments.data" :key="payment.id">
                <td class="text-center">
                  {{
                    (payments.current_page - 1) * payments.per_page + index + 1
                  }}
                </td>
                <td>{{ payment.transaction_no }}</td>
                <td>
                  <a
                    :href="`/real_estate_ms/public/tenant/${payment.tenant.tenant_no}/${payment.proof_of_payment}`"
                    target="_blank"
                  >
                    {{ payment.invoice }}
                  </a>
                </td>

                <td>{{ payment.mode_of_payment }}</td>
                <td>{{ payment.amount }}</td>
                <td>{{ payment.acctno }}</td>

                <td>{{ payment.date_paid }}</td>
                <td>{{ payment.tenant.tenant_name }}</td>
                <td>{{ payment.tenant.contact_number }}</td>
                <td>{{ payment.property.property_no }}</td>
                <td>{{ payment.property.property_name }}</td>
                <td>{{ payment.property.property_type }}</td>

                <td class="text-center">
                  <a @click="openModal('edit', payment)">
                    <i
                      class="bi bi-pencil-square text-primary"
                      style="font-size: 1.2rem"
                    ></i>
                  </a>
                  <a @click="deletePayment(payment)" title="Delete Payment">
                    <i
                      class="bi bi-trash text-danger"
                      style="font-size: 1.2rem"
                    ></i>
                  </a>
                </td>
              </tr>
              <!-- Repeat for more rows as needed -->
            </tbody>
          </table>
          <nav v-if="payments.total > 0" aria-label="Page navigation">
            <ul class="pagination justify-content-center mt-3">
              <!-- Previous Button -->
              <li
                class="page-item"
                :class="{ disabled: payments.current_page === 1 }"
              >
                <a
                  class="page-link"
                  href="#"
                  @click.prevent="changePage(payments.current_page - 1)"
                  >Previous</a
                >
              </li>

              <!-- Page Numbers -->
              <li
                class="page-item"
                v-for="page in totalPages"
                :key="page"
                :class="{ active: page === payments.current_page }"
              >
                <a class="page-link" href="#" @click.prevent="changePage(page)">
                  {{ page }}
                </a>
              </li>

              <!-- Next Button -->
              <li
                class="page-item"
                :class="{
                  disabled: payments.current_page === totalPages,
                }"
              >
                <a
                  class="page-link"
                  href="#"
                  @click.prevent="changePage(payments.current_page + 1)"
                  >Next</a
                >
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
    <div
      class="modal fade"
      id="modalProperty"
      tabindex="-1"
      aria-labelledby="modalProperty"
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
          <div class="modal-body" style="max-height: 70vh; overflow-y: auto">
            <div class="row">
              <div class="col-md-12">
                <div class="card border-0 shadow-sm mb-4">
                  <div class="card-header bg-info text-white">
                    <i class="fas fa-user me-2"></i> Tenant & Lease Information
                  </div>

                  <div class="card-body">
                    <!-- 🔍 Tenant Dropdown -->
                    <div class="form-floating mb-3">
                      <select
                        class="form-select"
                        v-model="selectedTenantId"
                        @change="populateFields"
                        :disabled="modalMode === 'edit'"
                        required
                      >
                        <option disabled value="">Select Tenant</option>
                        <option
                          v-for="tenancy in tenancies"
                          :key="tenancy.tenant_id"
                          :value="tenancy.tenant_id"
                        >
                          {{ tenancy.tenant_name }}
                        </option>
                      </select>
                      <label
                        ><i class="fas fa-search me-1"></i> Search Tenant
                        <span class="text-danger">*</span></label
                      >
                    </div>

                    <!-- 🏠 Property Name -->
                    <div class="form-floating mb-3">
                      <input
                        class="form-control"
                        v-model="formData.property_name"
                        placeholder="Property Name"
                        disabled
                      />

                      <label for="property_name">
                        <i class="fas fa-building me-1"></i> Property Name
                        <span class="text-danger">*</span>
                      </label>
                    </div>

                    <!-- 📅 Lease Dates & 💵 Amount -->
                    <div class="row">
                      <!-- Lease Start -->
                      <div class="col-md-6">
                        <div class="form-floating mb-3">
                          <input
                            type="date"
                            class="form-control"
                            id="lease_start_date"
                            v-model="formData.lease_start_date"
                            disabled
                          />
                          <label for="lease_start_date">
                            <i class="fas fa-calendar-day me-1"></i> Lease Start
                            Date
                          </label>
                        </div>
                      </div>

                      <!-- Lease End -->
                      <div class="col-md-6">
                        <div class="form-floating mb-3">
                          <input
                            type="date"
                            class="form-control"
                            id="lease_end_date"
                            v-model="formData.lease_end_date"
                            disabled
                          />
                          <label for="lease_end_date">
                            <i class="fas fa-calendar-check me-1"></i> Lease End
                            Date
                          </label>
                        </div>
                      </div>

                      <!-- Monthly Rate -->
                      <div class="col-md-6">
                        <div class="form-floating mb-3">
                          <input
                            type="text"
                            class="form-control"
                            id="monthly_rate"
                            v-model="formData.monthly_rent_amount"
                            disabled
                          />
                          <label for="monthly_rate">
                            <i class="fas fa-money-bill-wave me-1"></i> Monthly
                            Rate
                          </label>
                        </div>
                      </div>

                      <!-- Lease Duration (calculated) -->
                      <div class="col-md-6">
                        <div class="form-floating mb-3">
                          <input
                            type="text"
                            class="form-control"
                            id="lease_duration"
                            v-model="formData.lease_duration"
                            disabled
                          />
                          <label for="lease_duration">
                            <i class="fas fa-clock me-1"></i> Lease Duration
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="tab-content pt-3" id="propertyTabsContent">
              <div
                class="tab-pane fade show active"
                id="location"
                role="tabpanel"
                aria-labelledby="location-tab"
              >
                <!-- 💳 Payment Section -->
                <div class="card border-0 shadow-sm mb-4">
                  <div class="card-header bg-primary text-white">
                    <i class="fas fa-wallet me-2"></i> Payment Details
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <!-- Mode of Payment -->
                      <div class="col-md-12">
                        <label for="mode_of_payment" class="form-label">
                          <i class="fas fa-credit-card me-1"></i> Mode of
                          Payment <span class="text-danger">*</span>
                        </label>
                        <select
                          class="form-select"
                          id="mode_of_payment"
                          v-model="formData.mode_of_payment"
                          required
                        >
                          <option value="" disabled>Select Mode</option>
                          <option value="G-Cash">G-Cash</option>

                          <option value="Bank Deposit">Bank Deposit</option>
                          <option value="Cash">Cash</option>
                        </select>
                      </div>

                      <!-- GCash Number -->
                      <div
                        class="col-md-12"
                        v-if="formData.mode_of_payment === 'G-Cash'"
                      >
                        <label for="gcash_number" class="form-label mt-3">
                          <i class="fab fa-google-pay me-1"></i> GCash Number
                          <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                          <span class="input-group-text"
                            ><i class="fab fa-google-wallet"></i
                          ></span>
                          <input
                            type="text"
                            class="form-control"
                            id="gcash_number"
                            v-model="formData.acctno"
                            placeholder="09xxxxxxxxx"
                            required
                          />
                        </div>
                      </div>

                      <!-- Bank Account Number -->
                      <div
                        class="col-md-12"
                        v-if="formData.mode_of_payment === 'Bank Deposit'"
                      >
                        <label
                          for="bank_account_number"
                          class="form-label mt-3"
                        >
                          <i class="fas fa-building-columns me-1"></i> Bank
                          Account Number <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                          <span class="input-group-text"
                            ><i class="fas fa-bank"></i
                          ></span>
                          <input
                            type="text"
                            class="form-control"
                            id="bank_account_number"
                            v-model="formData.acctno"
                            placeholder="Enter bank account number"
                            required
                          />
                        </div>
                      </div>

                      <!-- Amount -->
                      <div class="col-md-4 mt-3">
                        <label for="amount" class="form-label">
                          <i class="fas fa-money-bill-wave me-1"></i> Amount
                          <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                          <span class="input-group-text"
                            ><i class="fas fa-peso-sign"></i
                          ></span>
                          <input
                            type="number"
                            step="0.01"
                            class="form-control"
                            id="amount"
                            v-model="formData.amount"
                            placeholder="0.00"
                            required
                          />
                        </div>
                      </div>

                      <!-- Date Paid -->
                      <div class="col-md-4 mt-3">
                        <label for="date_paid" class="form-label">
                          <i class="fas fa-calendar-check me-1"></i> Date Paid
                          <span class="text-danger">*</span>
                        </label>
                        <input
                          type="date"
                          class="form-control"
                          id="date_paid"
                          v-model="formData.date_paid"
                          required
                        />
                      </div>

                      <!-- Proof of Payment -->
                      <div class="col-md-4 mt-3">
                        <label for="proof_of_payment" class="form-label">
                          <i class="fas fa-file-upload me-1"></i> Proof of
                          Payment <span class="text-danger">*</span>
                        </label>
                        <input
                          type="file"
                          class="form-control"
                          id="image"
                          accept="image/*"
                          @change="handleFileUpload($event, 'proof_of_payment')"
                          required
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Footer -->
          <div
            class="modal-footer bg-light border-0 py-3 px-4 d-flex justify-content-end"
          >
            <button
              type="button"
              class="btn btn-success px-4 py-2 shadow-sm"
              :disabled="isSubmitting"
              @click="submitPayment"
            >
              <!-- Spinner icon while submitting -->
              <span v-if="isSubmitting">
                <i class="fas fa-spinner fa-spin me-2"></i> Saving...
              </span>

              <!-- Add or Edit icon and label -->
              <span v-else>
                <i class="fas fa-save me-2"></i>
                {{ modalMode === "add" ? "Add Property" : "Edit Payment" }}
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- Your existing tabs -->
  </div>
</template>

<script>
import Swal from "sweetalert2";
export default {
  data() {
    return {
      total_income: 0,
      today_income: 0,
      monthly_income: 0,
      yearly_income: 0,
      searchQuery: "",
      perPage: 10,
      payments: {
        data: [],
        current_page: 1,
        last_page: 1,
        per_page: 10,
        total: 0,
      },
      selectedTenantId: "",
      tenancies: [],
      isSubmitting: false,
      modalTitle: "",
      modalMode: "add",

      formData: {
        id: "",
        property_id: "",
        mode_of_payment: "",
        acctno: "",
        amount: "",
        date_paid: "",
        proof_of_payment: "Cash",
        tenant_name: "",
        property_name: "",

        lease_start_date: "",
        lease_end_date: "",
        monthly_rent_amount: "",
        lease_duration: "",
      },
    };
  },
  methods: {
    async deletePayment(payment) {
      const confirmation = await Swal.fire({
        title: "Are you sure?",
      text: `Delete payment for ${payment.tenant.tenant_name} (Invoice: ${payment.invoice})?`,

        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel",
      });

      if (!confirmation.isConfirmed) {
        return;
      }

      try {
        await axios.delete(`/real_estate_ms/api/delete/data/payment/${payment.id}`);

        Swal.fire("Deleted!", "Payment has been deleted.", "success");

        // Refresh payment list
        this.getDataPayment(); // or remove payment from local array if you want to avoid a full reload
      } catch (error) {
        console.error(error);
        Swal.fire("Error", "Failed to delete payment.", "error");
      }
    },

    async getDataPayment() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/data/payment",
          {
            params: {
              page: this.payments.current_page,
              per_page: this.perPage,
              search: this.searchQuery,
            },
          }
        );

        this.payments = response.data.data;
        this.payments = response.data.data;

        // Set totals
        const totals = response.data.totals;
        this.total_income = totals.total_income;
        this.today_income = totals.today_income;
        this.monthly_income = totals.monthly_income;
        this.yearly_income = totals.yearly_income;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
    changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.payments.current_page = page;
        this.getDataPayment();
      }
    },

    async submitPayment() {
      try {
        // Frontend Validation
        if (!this.selectedTenantId) {
          Swal.fire("Validation Error", "Please select a Tenant.", "error");
          return;
        }

        if (!this.formData.mode_of_payment) {
          Swal.fire(
            "Validation Error",
            "Please select the mode of payment.",
            "error"
          );
          return;
        }

        // Validate `acctno` based on `mode_of_payment`
        if (
          this.formData.mode_of_payment === "G-Cash" ||
          this.formData.mode_of_payment === "Bank Deposit"
        ) {
          if (!this.formData.acctno) {
            // Specific validation message based on payment mode
            const errorMessage =
              this.formData.mode_of_payment === "G-Cash"
                ? "Please provide your G-Cash account number."
                : "Please provide your Bank account number.";

            Swal.fire("Validation Error", errorMessage, "error");
            return;
          }
        }

        // If mode_of_payment is "Cash", acctno is not required
        // "E-Payment" or other modes do not require acctno
        if (this.formData.mode_of_payment !== "Cash" && !this.formData.acctno) {
          Swal.fire(
            "Validation Error",
            "Please provide account number.",
            "error"
          );
          return;
        }

        // If mode_of_payment is "Cash", acctno is not required
        if (this.formData.mode_of_payment !== "Cash" && !this.formData.acctno) {
          Swal.fire(
            "Validation Error",
            "Please provide account number.",
            "error"
          );
          return;
        }

        if (!this.formData.amount || this.formData.amount <= 0) {
          Swal.fire(
            "Validation Error",
            "Please enter a valid payment amount.",
            "error"
          );
          return;
        }
        if (!this.formData.date_paid) {
          Swal.fire(
            "Validation Error",
            "Please select the date paid.",
            "error"
          );
          return;
        }

        // Step 1: Confirm Submission
        const confirmation = await Swal.fire({
          title: "Are you sure?",
          text: "You are about to submit the payment. Do you want to proceed?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonText: "Yes, Submit",
          cancelButtonText: "Cancel",
        });

        if (!confirmation.isConfirmed) {
          return;
        }

        // Step 2: Create FormData and Submit
        this.isSubmitting = true;

        const formData = new FormData();
        formData.append("mode_of_payment", this.formData.mode_of_payment);
        formData.append("selectedTenantId", this.selectedTenantId);
        formData.append("property_id", this.formData.property_id);
        formData.append("acctno", this.formData.acctno);
        formData.append("amount", this.formData.amount);
        formData.append("date_paid", this.formData.date_paid);

        // Optional fields
        if (this.formData.proof_of_payment) {
          formData.append("proof_of_payment", this.formData.proof_of_payment);
        }

        // Step 3: Send the request
        let response;
        if (this.modalMode === "add") {
          // POST for adding new payment
          response = await axios.post(
            "/real_estate_ms/api/store/payment",
            formData,
            {
              headers: { "Content-Type": "multipart/form-data" },
            }
          );
        } else {
          // PUT for editing existing payment
          const paymentId = this.formData.id; // Make sure this exists
          response = await axios.post(
            `/real_estate_ms/api/update/payment/${paymentId}`,
            formData,
            {
              headers: { "Content-Type": "multipart/form-data" },
            }
          );
        }

        // Success Handling
        Swal.fire({
          icon: "success",
          title: "Success",
          text: "Payment has been successfully submitted.",
          confirmButtonText: "OK",
        }).then(() => {
          window.location.href = "/real_estate_ms/payment";
        });
      } catch (error) {
        console.error(error);

        // Handle validation or other errors
        if (error.response && error.response.status === 422) {
          const data = error.response.data;

          if (data.errors) {
            let errorMessages = '<ul style="text-align: left;">';
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

    async loadTenancies() {
      try {
        const response = await fetch("/real_estate_ms/get-tenancies");
        this.tenancies = await response.json();
      } catch (err) {
        console.error("Failed to load tenancies:", err);
      }
    },
    populateFields() {
      const tenancy = this.tenancies.find(
        (t) => t.tenant_id === this.selectedTenantId
      );

      if (tenancy) {
        this.formData.property_id = tenancy.property_id; // ✅ Use ID
        this.formData.property_name = tenancy.property_name;
        this.formData.lease_start_date = tenancy.lease_start_date;
        this.formData.lease_end_date = tenancy.lease_end_date;
        this.formData.monthly_rent_amount = tenancy.monthly_rent_amount;
        this.formData.lease_duration = tenancy.lease_duration;
      }
    },

    handleFileUpload(event, field) {
      this.formData[field] = event.target.files[0];
    },
    openModal(mode, payment) {
      this.formData = {
        id: "",
        property_id: "",
        mode_of_payment: "",
        acctno: "",
        amount: "",
        date_paid: "",
        proof_of_payment: "Cash",
        tenant_name: "",
        property_name: "",
        lease_start_date: "",
        lease_end_date: "",
        monthly_rent_amount: "",
        lease_duration: "",
      };

      this.modalMode = mode;
      this.modalTitle =
        mode === "add"
          ? "Create Payment"
          : mode === "edit"
          ? "Edit Payment"
          : "View Payment";

      if (mode === "edit" || mode === "view") {
        this.formData.id = payment.id;
        this.formData.property_id = payment.property_id;
        this.formData.mode_of_payment = payment.mode_of_payment;
        this.formData.acctno = payment.acctno;
        this.formData.amount = payment.amount;
        this.formData.date_paid = payment.date_paid;
        this.formData.proof_of_payment = payment.proof_of_payment;
        this.selectedTenantId = payment.tenant.id;
        this.formData.property_name = payment.property.property_name;
        const tenancy = this.tenancies.find(
          (t) => t.tenant_id === this.selectedTenantId
        );

        if (tenancy) {
          this.formData.property_id = tenancy.property_id; // ✅ Use ID
          this.formData.property_name = tenancy.property_name;
          this.formData.lease_start_date = tenancy.lease_start_date;
          this.formData.lease_end_date = tenancy.lease_end_date;
          this.formData.monthly_rent_amount = tenancy.monthly_rent_amount;
          this.formData.lease_duration = tenancy.lease_duration;
        }
      }

      $("#modalProperty").modal("show");
    },
    formatAmount(value) {
      if (!value) return "0";
      return new Intl.NumberFormat("en-US").format(value);
    },
  },
  computed: {
    totalPages() {
      return Math.ceil(this.payments.total / this.payments.per_page);
    },
  },

  mounted() {
    this.getDataPayment();
    this.loadTenancies();
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
