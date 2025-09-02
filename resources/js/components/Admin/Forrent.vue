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
          <i class="fas fa-building"></i> PROPERTY -> For Rent Properties
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
              @change="getDataProperties"
            >
              <option value="5">5 per page</option>
              <option value="10">10 per page</option>
              <option value="25">25 per page</option>
              <option value="50">50 per page</option>
              <option value="100">100 per page</option>
            </select>
          </div>
          <div class="col-md-2">
            <select
              class="form-control"
              v-model="propertyType"
              @change="getDataProperties"
            >
              <option value="">All Types</option>
              <option value="House">House</option>
              <option value="Condo">Condo</option>
              <option value="Apartment">Apartment</option>
              <option value="Townhouse">Townhouse</option>
              <!-- Add other property types as needed -->
            </select>
          </div>
          <div class="col-md-6">
            <input
              v-model="searchQuery"
              @input="getDataProperties"
              type="text"
              class="form-control"
              style="position: left"
              placeholder="Search Properties..."
            />
          </div>
          <div class="col-md-2 d-flex justify-content-end align-items-center">
            <button
              class="btn btn-success"
              type="button"
              @click="openModal('add')"
            >
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

                  <th
                    colspan="5"
                    class="blue"
                    style="background-color: #198754; color: white"
                  >
                    Location
                  </th>
                  <th
                    colspan="6"
                    class="blue"
                    style="background-color: #198754; color: white"
                  >
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

                  <th>Street</th>
                  <th>Zip Code</th>
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
                <tr
                  v-for="(property, index) in properties.data"
                  :key="property.id"
                >
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
                    <span
                      class="badge"
                      :class="{
                        'badge-custom-for-rent': property.status === 'For Rent',
                        'badge-custom-sold': property.status === 'Sold',
                        'badge-custom-pending': property.status === 'Pending',
                        'badge-custom-available':
                          property.status === 'Available',
                      }"
                    >
                      {{ property.status }}
                    </span>
                  </td>

                  <td>{{ property.province }}</td>
                  <td>{{ property.municipality }}</td>
                  <td>{{ property.barangay }}</td>
                  <td>{{ property.street }}</td>
                  <td>{{ property.zip_code }}</td>
                  <td>{{ property.bedrooms }}</td>
                  <td>{{ property.sq_meter }}</td>
                  <td>{{ property.car_park }}</td>
                  <td>{{ property.toilet }}</td>
                  <td>{{ property.bathroom }}</td>
                  <td>{{ property.furnishing }}</td>
                  <td class="text-center">
                    <a @click="openModal('edit', property)" title="Edit">
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
            <nav v-if="properties.total > 0" aria-label="Page navigation">
              <ul class="pagination justify-content-center mt-3">
                <!-- Previous Button -->
                <li
                  class="page-item"
                  :class="{ disabled: properties.current_page === 1 }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(properties.current_page - 1)"
                    >Previous</a
                  >
                </li>

                <!-- Page Numbers -->
                <li
                  class="page-item"
                  v-for="page in totalPages"
                  :key="page"
                  :class="{ active: page === properties.current_page }"
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
                    disabled: properties.current_page === totalPages,
                  }"
                >
                  <a
                    class="page-link"
                    href="#"
                    @click.prevent="changePage(properties.current_page + 1)"
                    >Next</a
                  >
                </li>
              </ul>
            </nav>

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
                  <div
                    class="modal-body"
                    style="max-height: 70vh; overflow-y: auto"
                  >
                    <div class="row">
                      <div class="col-md-12">
                        <!-- Date Created -->
                        <div class="form-floating mb-3">
                          <input
                            type="date"
                            class="form-control"
                            id="date_created"
                            v-model="formData.date_created"
                            required
                          />
                          <label for="date_created"
                            >Date Created
                            <span class="text-danger">*</span></label
                          >
                        </div>

                        <!-- Property Name -->
                        <div class="form-floating mb-3">
                          <input
                            type="text"
                            class="form-control"
                            id="property_name"
                            v-model="formData.property_name"
                            placeholder="Property Name"
                            required
                          />
                          <label for="property_name"
                            >Property Name
                            <span class="text-danger">*</span></label
                          >
                        </div>

                        <!-- Description of Property -->
                        <div class="form-floating mb-3">
                          <textarea
                            class="form-control"
                            id="description_of_property"
                            v-model="formData.description_of_property"
                            placeholder="Description of Property"
                            style="height: 80px"
                            required
                          ></textarea>
                          <label for="description_of_property"
                            >Description of Property
                            <span class="text-danger">*</span></label
                          >
                        </div>

                        <!-- Property Type -->
                        <div class="form-floating mb-3">
                          <select
                            class="form-select"
                            v-model="formData.property_type"
                            required
                          >
                            <option disabled value="">
                              Select Property Type
                            </option>
                            <option value="Apartment">Apartment</option>
                            <option value="House">House</option>
                            <option value="Condo">Condo</option>
                            <option value="Townhouse">Townhouse</option>
                            <option value="Commercial">Commercial</option>
                          </select>
                          <label for="property_type"
                            >Property Type
                            <span class="text-danger">*</span></label
                          >
                        </div>

                        <!-- Monthly Rate -->
                        <div class="form-floating mb-3">
                          <input
                            type="number"
                            class="form-control"
                            id="monthly_rate"
                            v-model="formData.monthly_rate"
                            placeholder="Monthly Rate"
                            min="0"
                            required
                          />
                          <label for="monthly_rate"
                            >Monthly Rate
                            <span class="text-danger">*</span></label
                          >
                        </div>
                      </div>
                    </div>
                    <!-- Nav Tabs -->
                    <ul class="nav nav-tabs" id="propertyTabs" role="tablist">
                      <li class="nav-item" role="presentation">
                        <button
                          class="nav-link active"
                          id="location-tab"
                          data-bs-toggle="tab"
                          data-bs-target="#location"
                          type="button"
                          role="tab"
                          aria-controls="location"
                          aria-selected="true"
                        >
                          <i class="fas fa-map-marker-alt"></i> Location
                        </button>
                      </li>
                      <li class="nav-item" role="presentation">
                        <button
                          class="nav-link"
                          id="features-tab"
                          data-bs-toggle="tab"
                          data-bs-target="#features"
                          type="button"
                          role="tab"
                          aria-controls="features"
                          aria-selected="false"
                        >
                          <i class="fas fa-couch"></i> Features & Amenities
                        </button>
                      </li>
                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content pt-3" id="propertyTabsContent">
                      <!-- Location Tab -->
                      <div
                        class="tab-pane fade show active"
                        id="location"
                        role="tabpanel"
                        aria-labelledby="location-tab"
                      >
                        <!-- Your location form inputs go here -->

                        <div class="row">
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="text"
                                class="form-control"
                                id="province"
                                v-model="formData.province"
                                required
                              />
                              <label for="date_created"
                                >Province
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="text"
                                class="form-control"
                                id="municipality"
                                v-model="formData.municipality"
                                required
                              />
                              <label for="municipality"
                                >Municipality
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="text"
                                class="form-control"
                                id="barangay"
                                v-model="formData.barangay"
                                required
                              />
                              <label for="barangay"
                                >Barangay
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating mb-3">
                              <input
                                type="text"
                                class="form-control"
                                id="street"
                                v-model="formData.street"
                                required
                              />
                              <label for="street"
                                >Street Name
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating mb-3">
                              <input
                                type="text"
                                class="form-control"
                                id="zip_code"
                                v-model="formData.zip_code"
                                required
                              />
                              <label for="zip_code"
                                >Zip Code
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- Features & Amenities Tab -->
                      <div
                        class="tab-pane fade"
                        id="features"
                        role="tabpanel"
                        aria-labelledby="features-tab"
                      >
                        <!-- Your features form inputs go here -->
                        <div class="row">
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="number"
                                class="form-control"
                                id="bedrooms"
                                v-model="formData.bedrooms"
                                required
                                min="0"
                              />
                              <label for="bedrooms"
                                >Bedrooms
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="number"
                                class="form-control"
                                id="sq_meter"
                                v-model="formData.sq_meter"
                                required
                                min="0"
                              />
                              <label for="sq_meter"
                                >Square Meter
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="number"
                                class="form-control"
                                id="car_park"
                                v-model="formData.car_park"
                                required
                                min="0"
                              />
                              <label for="car_park"
                                >Car Park
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="number"
                                class="form-control"
                                id="toilet"
                                v-model="formData.toilet"
                                required
                                min="0"
                              />
                              <label for="toilet"
                                >Toilet
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <input
                                type="number"
                                class="form-control"
                                id="bathroom"
                                v-model="formData.bathroom"
                                required
                                min="0"
                              />
                              <label for="bathroom"
                                >Bathroom
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-floating mb-3">
                              <select
                                class="form-select"
                                v-model="formData.furnishing"
                                required
                              >
                                <option disabled value="">
                                  Select Furnishing
                                </option>
                                <option value="Furnished">Furnished</option>
                                <option value="Semi-Furnished">
                                  Semi-Furnished
                                </option>
                                <option value="Unfurnished">Unfurnished</option>
                              </select>
                              <label for="furnishing"
                                >Furnishing
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="form-floating mb-3">
                              <input
                                type="file"
                                class="form-control"
                                id="image"
                                @change="handleFileUpload($event, 'image')"
                                accept="image/*"
                              />
                              <label for="image"
                                >Property Image
                                <span class="text-danger">*</span></label
                              >
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- Photos Tab -->
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
                      @click="submitProperties"
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
    handleFileUpload(event, field) {
      this.formData[field] = event.target.files[0];
    },

    async getDataProperties() {
      try {
        const response = await axios.get(
          "/real_estate_ms/api/get/data/properties",
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
        formData.append("monthly_rate", this.formData.monthly_rate);

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
            "/real_estate_ms/api/store/property",
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
            `/real_estate_ms/api/update/property/${this.formData.id}`,
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
          window.location.href = "/real_estate_ms/for/rent/properties";
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
        monthly_rate: "",
        furnishing: "",
        image: null,
      };

      this.modalMode = mode;
      this.modalTitle =
        mode === "add"
          ? "Add For Rent Property"
          : mode === "edit"
          ? "Edit For Rent Property"
          : "View For Rent Property";

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
        this.formData.monthly_rate = property.monthly_rate;
        this.formData.furnishing = property.furnishing;
        this.formData.property_type = property.property_type;
        this.formData.image = property.image;
      }

      $("#modalProperty").modal("show");
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
        monthly_rate: "",
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
}.badge-custom-for-rent {
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
  background-color: blue;  /* You can change this color */
  color: white;
}

</style>
