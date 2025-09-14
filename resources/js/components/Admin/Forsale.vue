<template>
  <div>
    <ul class="nav nav-tabs" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="generallist-tab" data-bs-toggle="tab" data-bs-target="#generallist"
          type="button" role="tab" aria-controls="generallist" aria-selected="true">
          <i class="fas fa-building"></i> PROPERTY -> For Sale Properties
        </button>
      </li>
    </ul>
    <div class="tab-content" id="myTabContent">
      <div class="tab-pane fade show active" id="generallist" role="tabpanel" aria-labelledby="generallist-tab">
        <div class="row align-items-center mb-3">
          <!-- Per Page Selector -->
          <div class="col-md-2">
            <select class="form-control" v-model="perPage" @change="getDataProperties">
              <option value="5">5 per page</option>
              <option value="10">10 per page</option>
              <option value="25">25 per page</option>
              <option value="50">50 per page</option>
              <option value="100">100 per page</option>
            </select>
          </div>

          <!-- Property Type Selector -->
          <div class="col-md-2">
            <select class="form-control" v-model="propertyType" @change="getDataProperties">
              <option value="">All Types</option>
              <option value="House">House</option>
              <option value="Condo">Condo</option>
              <option value="Apartment">Apartment</option>
              <option value="Townhouse">Townhouse</option>
            </select>
          </div>

          <!-- Search Field -->
          <div class="col-md-4">
            <input v-model="searchQuery" @input="getDataProperties" type="text" class="form-control"
              placeholder="Search Properties..." />
          </div>

          <!-- Buttons -->
          <div class="col-md-4 d-flex justify-content-end gap-2">
           
            <button class="btn btn-primary" type="button" @click="openModal('add')">
              <i class="fas fa-plus"></i> Create Property
            </button>
          </div>


          <div class="table-responsive">
            <br />

            <table>
              <thead>
                <tr>
                  <th style="background-color: #198754; color: white">#</th>
                  <th style="background-color: #198754; color: white">
                    Property No.
                  </th>
                  <th style="background-color: #198754; color: white">
                    Property Type
                  </th>
                  <th style="background-color: #198754; color: white">
                    Property Name
                  </th>
                  <th style="background-color: #198754; color: white">
                    Status
                  </th>

                  <th colspan="3" class="blue" style="background-color: #198754; color: white">
                    Location
                  </th>
                  <th colspan="6" class="blue" style="background-color: #198754; color: white">
                    Features and Amenities
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

                  <!-- <th>Next In Rank</th> -->
                  <th>Province</th>

                  <th>Municipality</th>

                  <th>Barangay</th>


                  <th>Bedrooms</th>
                  <th>Sq.m</th>
                  <th>Car Park</th>
                  <th>Toilet</th>
                  <th>Bathroom</th>
                  <th>Furnishing</th>
                
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <!-- Add empty rows to match the design -->
                <tr v-for="(property, index) in properties.data" :key="property.id">
                  <td class="text-center">
                    {{
                      (properties.current_page - 1) * properties.per_page +
                      index +
                      1
                    }}
                  </td>
                  <td>{{ property.property_no }}</td>
                  <td>{{ property.property_type }}</td>
                  <td>{{ property.property_name }}</td>
                  <td>
                    <span class="badge" :class="{
                      'badge-custom-for-rent': property.status === 'For Rent',
                      'badge-custom-sold': property.status === 'Occupied',
                      'badge-custom-pending': property.status === 'Pending',
                      'badge-custom-available':
                        property.status === 'Available',
                    }">
                      {{ property.status }}
                    </span>
                  </td>

                  <td>{{ property.province }}</td>
                  <td>{{ property.municipality }}</td>
                  <td>{{ property.barangay }}</td>

                  <td>{{ property.bedrooms }}</td>
                  <td>{{ property.sq_meter }}</td>
                  <td>{{ property.car_park }}</td>
                  <td>{{ property.toilet }}</td>
                  <td>{{ property.bathroom }}</td>
                  <td>{{ property.furnishing }}</td>
               
                  <td class="text-center">
                    <a @click="openModal('edit', property)" title="Edit">
                      <i class="bi bi-pencil-square text-primary" style="font-size: 1.2rem"></i>
                    </a>
                    <a @click="deleteProperties(property)">
                      <i class="bi bi-trash text-danger" style="font-size: 1.2rem"></i>

                    </a>
                  </td>
                </tr>
                <!-- Repeat for more rows as needed -->
              </tbody>
            </table>
            <nav v-if="properties.total > 0" aria-label="Page navigation">
              <ul class="pagination justify-content-center mt-3">
                <!-- Previous Button -->
                <li class="page-item" :class="{ disabled: properties.current_page === 1 }">
                  <a class="page-link" href="#" @click.prevent="changePage(properties.current_page - 1)">Previous</a>
                </li>

                <!-- Page Numbers -->
                <li class="page-item" v-for="page in totalPages" :key="page"
                  :class="{ active: page === properties.current_page }">
                  <a class="page-link" href="#" @click.prevent="changePage(page)">
                    {{ page }}
                  </a>
                </li>

                <!-- Next Button -->
                <li class="page-item" :class="{
                  disabled: properties.current_page === totalPages,
                }">
                  <a class="page-link" href="#" @click.prevent="changePage(properties.current_page + 1)">Next</a>
                </li>
              </ul>
            </nav>

            <div class="modal fade" id="modalProperty" tabindex="-1" aria-labelledby="modalProperty" aria-hidden="true"
              data-bs-backdrop="static" data-bs-keyboard="false">
              <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg rounded-4">
                  <!-- Header -->
                  <div class="modal-header text-white py-3"
                    style="background: linear-gradient(90deg, #198754, #198754)">
                    <h4 class="modal-title d-flex align-items-center" style="color: white">
                      <i class="fa fa-file-alt me-2"></i>{{ modalTitle }}
                    </h4>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                      aria-label="Close"></button>
                  </div>

                  <!-- Body -->
                  <div class="modal-body" style="max-height: 70vh; overflow-y: auto">
                    <div class="row">
                      <div class="col-md-12">
                        <!-- Date Created -->
                        <div class="form-floating mb-3">
                          <input type="date" class="form-control" id="date_created" v-model="formData.date_created"
                            required />
                          <label for="date_created">Date Created
                            <span class="text-danger">*</span></label>
                        </div>

                        <!-- Property Name -->
                        <div class="form-floating mb-3">
                          <input type="text" class="form-control" id="property_name" v-model="formData.property_name"
                            placeholder="Property Name" required />
                          <label for="property_name">Property Name
                            <span class="text-danger">*</span></label>
                        </div>

                        <!-- Description of Property -->
                        <div class="form-floating mb-3">
                          <textarea class="form-control" id="description_of_property"
                            v-model="formData.description_of_property" placeholder="Description of Property"
                            style="height: 80px" required></textarea>
                          <label for="description_of_property">Description of Property
                            <span class="text-danger">*</span></label>
                        </div>

                        <!-- Property Type -->
                        <div class="form-floating mb-3">
                          <select class="form-select" v-model="formData.property_type" required>
                            <option disabled value="">
                              Select Property Type
                            </option>
                            <option value="Apartment">Apartment</option>
                            <option value="House">House</option>
                            <option value="Condo">Condo</option>
                            <option value="Townhouse">Townhouse</option>
                            <option value="Commercial">Commercial</option>
                          </select>
                          <label for="property_type">Property Type
                            <span class="text-danger">*</span></label>
                        </div>

                        <!-- Monthly Rate -->
                        <div class="form-floating mb-3">
                          <input type="number" class="form-control" id="sale_price" v-model="formData.sale_price"
                            placeholder="Monthly Rate" min="0" required />
                          <label for="sale_price">Sale Price
                            <span class="text-danger">*</span></label>
                        </div>
                      </div>
                    </div>
                    <!-- Nav Tabs -->
                    <ul class="nav nav-tabs" id="propertyTabs" role="tablist">
                      <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="location-tab" data-bs-toggle="tab"
                          data-bs-target="#location" type="button" role="tab" aria-controls="location"
                          aria-selected="true">
                          <i class="fas fa-map-marker-alt"></i> Location
                        </button>
                      </li>

                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content pt-3" id="propertyTabsContent">
                      <!-- Location Tab -->
                      <div class="tab-pane fade show active" id="location" role="tabpanel"
                        aria-labelledby="location-tab">
                        <!-- Your location form inputs go here -->

                        <div class="row">
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="text" class="form-control" id="province" v-model="formData.province"
                                required />
                              <label for="date_created">Province
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="text" class="form-control" id="municipality" v-model="formData.municipality"
                                required />
                              <label for="municipality">Municipality
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="text" class="form-control" id="barangay" v-model="formData.barangay"
                                required />
                              <label for="barangay">Barangay
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating mb-3">
                              <input type="text" class="form-control" id="street" v-model="formData.street" required />
                              <label for="street">Street Name
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating mb-3">
                              <input type="text" class="form-control" id="zip_code" v-model="formData.zip_code"
                                required />
                              <label for="zip_code">Zip Code
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- Features & Amenities Tab -->
                      <div class="tab-pane fade" id="features" role="tabpanel" aria-labelledby="features-tab">
                        <!-- Your features form inputs go here -->
                        <div class="row">
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="number" class="form-control" id="bedrooms" v-model="formData.bedrooms"
                                required min="0" />
                              <label for="bedrooms">Bedrooms
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="number" class="form-control" id="sq_meter" v-model="formData.sq_meter"
                                required min="0" />
                              <label for="sq_meter">Square Meter
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="number" class="form-control" id="car_park" v-model="formData.car_park"
                                required min="0" />
                              <label for="car_park">Car Park
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="number" class="form-control" id="toilet" v-model="formData.toilet" required
                                min="0" />
                              <label for="toilet">Toilet
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input type="number" class="form-control" id="bathroom" v-model="formData.bathroom"
                                required min="0" />
                              <label for="bathroom">Bathroom
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <select class="form-select" v-model="formData.furnishing" required>
                                <option disabled value="">
                                  Select Furnishing
                                </option>
                                <option value="Furnished">Furnished</option>
                                <option value="Semi-Furnished">
                                  Semi-Furnished
                                </option>
                                <option value="Unfurnished">Unfurnished</option>
                              </select>
                              <label for="furnishing">Furnishing
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating mb-3">
                              <input type="file" class="form-control" id="image"
                                @change="handleFileUpload($event, 'image')" accept="image/*" />
                              <label for="image">Property Image
                                <span class="text-danger">*</span></label>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- Photos Tab -->
                    </div>
                  </div>

                  <!-- Footer -->
                  <div class="modal-footer bg-light border-0 py-3 px-4 d-flex justify-content-end">
                    <button type="button" class="btn btn-success px-4 py-2 shadow-sm" :disabled="isSubmitting"
                      @click="submitProperties">
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

            <div class="modal fade" id="modalPropertySold" tabindex="-1" aria-labelledby="modalPropertySold"
              aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
              <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg rounded-4">
                  <!-- Header -->
                  <div class="modal-header text-white py-3"
                    style="background: linear-gradient(90deg, #198754, #198754)">
                    <h4 class="modal-title d-flex align-items-center" style="color: white">
                      <i class="fa fa-file-alt me-2"></i>{{ modalTitle }}
                    </h4>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                      aria-label="Close"></button>
                  </div>

                  <!-- Body -->
                  <div class="modal-body" style="max-height: 70vh; overflow-y: auto">
                    <div class="row">
                      <div class="col-md-12">
                        <!-- Date Created -->

                        <!-- Property Name -->
                        <div class="form-floating mb-3">
                          <input type="text" class="form-control" id="property_name" v-model="formData.property_name"
                            placeholder="Property Name" disabled />
                          <label for="property_name">Property Name
                            <span class="text-danger">*</span></label>
                        </div>
                        <div class="form-floating mb-3">
                          <input type="number" class="form-control" id="sale_price" v-model="formData.sale_price"
                            placeholder="Monthly Rate" min="0" disabled />
                          <label for="sale_price">Sale Price
                            <span class="text-danger">*</span></label>
                        </div>
                      </div>
                      <hr>

                      <div class="form-floating mb-3">
                        <input type="text" class="form-control" v-model="formData.customer_name"
                          placeholder="Property Name" required />
                        <label for="property_name">Customer Name
                          <span class="text-danger">*</span></label>
                      </div>
                      <div class="form-floating mb-3">
                        <input type="text" class="form-control" v-model="formData.contact_no"
                          placeholder="Customer Name" required />
                        <label for="property_name">Contact Number
                          <span class="text-danger">*</span></label>
                      </div>
                      <div class="form-floating mb-3">
                        <input type="text" class="form-control" v-model="formData.address" placeholder="Property Name"
                          required />
                        <label for="property_name">Address
                          <span class="text-danger">*</span></label>
                      </div>

                      <!-- Description of Property -->


                      <!-- Monthly Rate -->


                    </div>
                    <!-- Nav Tabs -->
                    <ul class="nav nav-tabs" id="propertyTabs" role="tablist">
                      <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="location-tab" data-bs-toggle="tab"
                          data-bs-target="#location" type="button" role="tab" aria-controls="location"
                          aria-selected="true">
                          <i class="fas fa-map-marker-alt"></i> Payment Details
                        </button>
                      </li>

                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content pt-3" id="propertyTabsContent">
                      <!-- Location Tab -->
                      <div class="tab-pane fade show active" id="location" role="tabpanel"
                        aria-labelledby="location-tab">

                        <div class="row">
                          <!-- Mode of Payment -->
                          <div class="col-md-12">
                            <label for="mode_of_payment" class="form-label">
                              <i class="fas fa-credit-card me-1"></i> Mode of
                              Payment <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" id="mode_of_payment" v-model="formData.mode_of_payment"
                              required>
                              <option value="" disabled>Select Mode</option>
                              <option value="G-Cash">G-Cash</option>

                              <option value="Bank Deposit">Bank Deposit</option>
                              <option value="Cash">Cash</option>
                            </select>
                          </div>

                          <!-- GCash Number -->
                          <div class="col-md-12" v-if="formData.mode_of_payment === 'G-Cash'">
                            <label for="gcash_number" class="form-label mt-3">
                              <i class="fab fa-google-pay me-1"></i> GCash Number
                              <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                              <span class="input-group-text"><i class="fab fa-google-wallet"></i></span>
                              <input type="text" class="form-control" id="gcash_number" v-model="formData.acctno"
                                placeholder="09xxxxxxxxx" required />
                            </div>
                          </div>

                          <!-- Bank Account Number -->
                          <div class="col-md-12" v-if="formData.mode_of_payment === 'Bank Deposit'">
                            <label for="bank_account_number" class="form-label mt-3">
                              <i class="fas fa-building-columns me-1"></i> Bank
                              Account Number <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                              <span class="input-group-text"><i class="fas fa-bank"></i></span>
                              <input type="text" class="form-control" id="bank_account_number" v-model="formData.acctno"
                                placeholder="Enter bank account number" required />
                            </div>
                          </div>

                          <!-- Amount -->
                          <div class="col-md-4 mt-3">
                            <label for="amount" class="form-label">
                              <i class="fas fa-money-bill-wave me-1"></i> Amount
                              <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                              <span class="input-group-text"><i class="fas fa-peso-sign"></i></span>
                              <input type="number" step="0.01" class="form-control" id="amount"
                                v-model="formData.amount" placeholder="0.00" required />
                            </div>
                          </div>

                          <!-- Date Paid -->
                          <div class="col-md-4 mt-3">
                            <label for="date_paid" class="form-label">
                              <i class="fas fa-calendar-check me-1"></i> Date Paid
                              <span class="text-danger">*</span>
                            </label>
                            <input type="date" class="form-control" id="date_paid" v-model="formData.date_paid"
                              required />
                          </div>

                          <!-- Proof of Payment -->
                          <div class="col-md-4 mt-3">
                            <label for="proof_of_payment" class="form-label">
                              <i class="fas fa-file-upload me-1"></i> Proof of
                              Payment <span class="text-danger">*</span>
                            </label>
                            <input type="file" class="form-control" id="image" accept="image/*"
                              @change="handleFileUpload($event, 'proof_of_payment')" required />
                          </div>
                        </div>
                      </div>

                      <!-- Features & Amenities Tab -->

                      <!-- Photos Tab -->
                    </div>
                  </div>

                  <!-- Footer -->
                  <div class="modal-footer bg-light border-0 py-3 px-4 d-flex justify-content-end">
                    <button type="button" class="btn btn-success px-4 py-2 shadow-sm" :disabled="isSubmitting"
                      @click="submitPayment">
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
    async submitPayment() {
      try {
        // Frontend Validation
        if (!this.formData.customer_name) {
          Swal.fire("Validation Error", "Please select a Customer.", "error");
          return;
        }

        if (!this.formData.contact_no) {
          Swal.fire(
            "Validation Error",
            "Please select the Contact Number.",
            "error"
          );
          return;
        }
        if (!this.formData.address) {
          Swal.fire(
            "Validation Error",
            "Please select the Address.",
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
        formData.append("customer_name", this.formData.customer_name);
        formData.append("contact_no", this.formData.contact_no);


        formData.append("address", this.formData.address);
        formData.append("mode_of_payment", this.formData.mode_of_payment);
        formData.append("amount", this.formData.amount);
        formData.append("acct_no", this.formData.acctno);
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
            "/real_estate_ms/api/store/payment/for/sale",
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
          window.location.href = "/real_estate_ms/for/sale";
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

    async deleteProperties(property) {
      const confirmation = await Swal.fire({
        title: "Are you sure?",
        text: `You are about to delete Property: ${property.property_name}. This action cannot be undone.`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "Cancel",
      });

      if (confirmation.isConfirmed) {
        try {
          const response = await axios.delete(
            `/real_estate_ms/api/delete/property/${property.id}`
          );

          // Success alert with OK and then redirect
          await Swal.fire({
            title: "Deleted!",
            text: response.data.success,
            icon: "success",
            confirmButtonText: "OK",
          });

          // ✅ After user clicks "OK", redirect
          window.location.href = "/real_estate_ms/for/sale"; // Change this path to your actual route
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

    async getDataProperties() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/data/properties/forsale",
          {
            params: {
              page: this.properties.current_page,
              per_page: this.perPage,
              property_type: this.propertyType, // Send the selected property type filter to the backend
              search: this.searchQuery,
            },
          }
        );

        this.properties = response.data.data;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },

    changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.properties.current_page = page;
        this.getDataProperties();
      }
    },
    async submitProperties() {
      try {
        this.isSubmitting = true;

        const formData = new FormData();
        formData.append("property_no", this.formData.property_no);
        formData.append("date_created", this.formData.date_created);
        formData.append("property_name", this.formData.property_name);
        formData.append(
          "description_of_property",
          this.formData.description_of_property
        );
        formData.append("property_type", this.formData.property_type);
        formData.append("sale_price", this.formData.sale_price);

        // Location
        formData.append("province", this.formData.province);
        formData.append("municipality", this.formData.municipality);
        formData.append("barangay", this.formData.barangay);
        formData.append("street", this.formData.street);
        formData.append("zip_code", this.formData.zip_code);

        // Features & Amenities
        formData.append("bedrooms", this.formData.bedrooms);
        formData.append("sq_meter", this.formData.sq_meter);
        formData.append("car_park", this.formData.car_park);
        formData.append("toilet", this.formData.toilet);
        formData.append("bathroom", this.formData.bathroom);
        formData.append("furnishing", this.formData.furnishing);

        // Image (only append if file was selected)
        if (this.formData.image instanceof File) {
          formData.append("image", this.formData.image);
        }

        let response;

        if (this.modalMode === "add") {
          // POST request to store
          response = await axios.post(
            "/real_estate_ms/api/store/property/forsale",
            formData,
            {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            }
          );
        } else if (this.modalMode === "edit") {
          // PUT/POST request to update
          response = await axios.post(
            `/real_estate_ms/api/update/property/forsale/${this.formData.id}`,
            formData,
            {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            }
          );
        }

        // Success popup
        Swal.fire({
          icon: "success",
          title: "Success",
          text:
            this.modalMode === "add"
              ? "Property successfully added!"
              : "Property successfully updated!",
          confirmButtonText: "OK",
        }).then(() => {
          window.location.href = "/real_estate_ms/for/sale";
        });
      } catch (error) {
        console.error(error);

        // Laravel validation error (422)
        if (error.response && error.response.status === 422) {
          const data = error.response.data;

          // 1. Custom 'exist' error from Laravel controller
          if (data.exist) {
            Swal.fire({
              icon: "error",
              title: "Duplicate Property",
              text: data.exist,
            });
            return;
          }

          // 2. Standard validation errors
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

    openModal(mode, property) {
      this.formData = {
        id: "",
        date_created: "",
        property_name: "",
        province: "",
        municipality: "",
        barangay: "",
        street: "",
        zip_code: "",
        description_of_property: "",
        bedrooms: "",
        sq_meter: "",
        car_park: "",
        toilet: "",
        bathroom: "",
        sale_price: "",
        furnishing: "",
        image: null,
      };

      this.modalMode = mode;
      this.modalTitle =
        mode === "add"
          ? "Add For Sale Property"
          : mode === "edit"
            ? "Edit For Sale Property"
            : "View For Sale Property";

      if (mode === "edit" || mode === "view") {
        this.formData.id = property.id;
        this.formData.date_created = property.date_created;
        this.formData.property_name = property.property_name;
        this.formData.province = property.province;
        this.formData.municipality = property.municipality;
        this.formData.barangay = property.barangay;
        this.formData.street = property.street;
        this.formData.zip_code = property.zip_code;
        this.formData.description_of_property =
          property.description_of_property;
        this.formData.bedrooms = property.bedrooms;
        this.formData.sq_meter = property.sq_meter;
        this.formData.car_park = property.car_park;
        this.formData.toilet = property.toilet;
        this.formData.bathroom = property.bathroom;
        this.formData.sale_price = property.monthly_rate;
        this.formData.furnishing = property.furnishing;
        this.formData.property_type = property.property_type;
        this.formData.image = property.image;
      }

      $("#modalProperty").modal("show");
    },
    openModalSold(mode, property) {
      this.formData = {
        id: "",
        date_created: "",
        property_name: "",
        province: "",
        municipality: "",
        barangay: "",
        street: "",
        zip_code: "",
        description_of_property: "",
        bedrooms: "",
        sq_meter: "",
        car_park: "",
        toilet: "",
        bathroom: "",
        sale_price: "",
        furnishing: "",
        image: null,
      };

      this.modalMode = mode;
      this.modalTitle =
        mode === "add"
          ? "Add For Sale Property"
          : mode === "edit"
            ? "Sold To Property"
            : "Sold Property";

      if (mode === "sold_to_modal" || mode === "view") {
        this.formData.id = property.id;
        this.formData.date_created = property.date_created;
        this.formData.property_name = property.property_name;
        this.formData.province = property.province;
        this.formData.municipality = property.municipality;
        this.formData.barangay = property.barangay;
        this.formData.street = property.street;
        this.formData.zip_code = property.zip_code;
        this.formData.description_of_property =
          property.description_of_property;
        this.formData.bedrooms = property.bedrooms;
        this.formData.sq_meter = property.sq_meter;
        this.formData.car_park = property.car_park;
        this.formData.toilet = property.toilet;
        this.formData.bathroom = property.bathroom;
        this.formData.sale_price = property.monthly_rate;
        this.formData.furnishing = property.furnishing;
        this.formData.property_type = property.property_type;
        this.formData.image = property.image;
      }

      $("#modalPropertySold").modal("show");
    },
  },
  data() {
    return {
      propertyType: "",
      modalTitle: "",
      modalMode: "add",
      isSubmitting: false, // for loading state
      selectedProperty: "", // Make sure this exists or bind to a dropdown
      formData: {
        id: "",
        property_no: "",
        date_created: "",
        property_name: "",
        description_of_property: "",
        property_type: "",
        sale_price: "",
        province: "",
        municipality: "",
        barangay: "",
        street: "",
        zip_code: "",
        bedrooms: "",
        sq_meter: "",
        car_park: "",
        toilet: "",
        bathroom: "",
        furnishing: "",
        image: "",
        customer_name: "",
        contact_no: "",
        address: "",
        mode_of_payment: "",
        acctno: "",
        amount: "",
        date_paid: "",
        proof_of_payment: "",
      },
      searchQuery: "",
      perPage: 10,
      properties: {
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
      return Math.ceil(this.properties.total / this.properties.per_page);
    },
  },

  mounted() {
    // Any initialization code can go herec
    this.getDataProperties();
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
  background-color: blue;
  /* You can change this color */
  color: white;
}
</style>
