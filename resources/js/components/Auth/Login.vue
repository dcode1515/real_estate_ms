<template>
  <div class="row">
    <div class="col-lg-12">
      <div class="card overflow-hidden card-bg-fill galaxy-border-none">
        <div class="row g-0">
          <div class="col-lg-6">
            <div class="p-lg-5 p-4 auth-one-bg h-100">
              <div class="bg-overlay"></div>
              <div class="position-relative h-100 d-flex flex-column">
                <div class="mb-4">
                  <a href="index.html" class="d-block">
                    <img
                      src="assets/images/logo-light.png"
                      alt=""
                      height="18"
                    />
                  </a>
                </div>
                <div class="mt-auto">
                  <div class="mb-3">
                    <i class="ri-double-quotes-l display-4 text-success"></i>
                  </div>

                  <div
                    id="qoutescarouselIndicators"
                    class="carousel slide"
                    data-bs-ride="carousel"
                  >
                    <div class="carousel-indicators">
                      <button
                        type="button"
                        data-bs-target="#qoutescarouselIndicators"
                        data-bs-slide-to="0"
                        class="active"
                        aria-current="true"
                        aria-label="Slide 1"
                      ></button>
                      <button
                        type="button"
                        data-bs-target="#qoutescarouselIndicators"
                        data-bs-slide-to="1"
                        aria-label="Slide 2"
                      ></button>
                      <button
                        type="button"
                        data-bs-target="#qoutescarouselIndicators"
                        data-bs-slide-to="2"
                        aria-label="Slide 3"
                      ></button>
                    </div>
                    <div class="carousel-inner text-center text-white-50 pb-5">
                      <div class="carousel-item active">
                        <p class="fs-15 fst-italic">
                          " Great! Clean code, clean design, easy for
                          customization. Thanks very much! "
                        </p>
                      </div>
                      <div class="carousel-item">
                        <p class="fs-15 fst-italic">
                          " The theme is really great with an amazing customer
                          support."
                        </p>
                      </div>
                      <div class="carousel-item">
                        <p class="fs-15 fst-italic">
                          " Great! Clean code, clean design, easy for
                          customization. Thanks very much! "
                        </p>
                      </div>
                    </div>
                  </div>
                  <!-- end carousel -->
                </div>
              </div>
            </div>
          </div>
          <!-- end col -->

          <div class="col-lg-6">
            <div class="p-lg-5 p-4">
              <div>
                <h5 class="text-primary">Welcome Back !</h5>
                <p class="text-muted">
                  Sign in to continue to Real Estate Management Ssytem
                </p>
              </div>

              <div class="mt-4">
                <form>
                  <div class="mb-3">
                    <label for="username" class="form-label">Email</label>
                    <input
                      type="text"
                      class="form-control"
                      v-model="email_address"
                      placeholder="Enter username"
                    />
                  </div>

                  <div class="mb-3">
                    <label class="form-label" for="password-input"
                      >Password</label
                    >
                    <div class="position-relative auth-pass-inputgroup mb-3">
                      <input
                        type="password"
                        class="form-control pe-5 password-input"
                        placeholder="Enter password"
                        v-model="password"
                      />
                      <button
                        class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none"
                        type="button"
                        id="password-addon"
                      >
                        <i class="ri-eye-fill align-middle"></i>
                      </button>
                    </div>
                  </div>

                  <div class="mt-4">
                    <button
                      type="submit"
                      :disabled="isLoading"
                      @click="loginUser"
                    
                    >
                      <span v-if="isLoading">
                        <i class="fa fa-spinner fa-spin"></i> Loading Please
                        Wait......
                      </span>
                      <span v-else> <i class="fa fa-check"></i> Log In </span>
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <!-- end col -->
        </div>
        <!-- end row -->
      </div>
      <!-- end card -->
    </div>
    <!-- end col -->
  </div>
</template>

<script>
import Swal from "sweetalert2"; // Import SweetAlert2
import toastr from "toastr";
import "toastr/build/toastr.css";

export default {
  methods: {
    getImageUrlNavbar() {
      return "/real_estate_ms/public/images/logo/bagongpilipinas.png";
    },
    getImageUrlLogo() {
      return "/real_estate_ms/public/images/logo/wewew.png";
    },
    loginUser() {
      this.isLoading = true;
      this.message = "";

      const data = {
        email_address: this.email_address,
        password: this.password,
      };

      axios
        .post("/real_estate_ms/api/login/post", data)
        .then((response) => {
          if (response.data.type === "admin") {
            this.message = "Login successful! Redirecting to dashboard...";
            this.messageType = "success";
            setTimeout(() => {
              window.location.href = "/real_estate_ms/dashboard";
            }, 2000);
          }
        })
        .catch((error) => {
          if (error.response) {
            const status = error.response.status;
            const data = error.response.data;

            if (status === 401) {
              this.message =
                data.error ||
                "Your Email address or Password is incorrect. Please try again.";
            } else if (status === 403) {
              this.message =
                data.error ||
                "Access restricted. Only Admin accounts can log in.";
            } else if (status === 422 && data.errors) {
              if (data.errors.email_address) {
                this.message = data.errors.email_address[0];
              } else if (data.errors.password) {
                this.message = data.errors.password[0];
              } else {
                this.message =
                  "Validation errors occurred. Please check your input.";
              }
            } else {
              this.message = "Something went wrong. Please try again later.";
              console.error("Error:", error);
            }
          } else {
            this.message =
              "Network error. Please check your connection and try again.";
            console.error("Error:", error);
          }

          this.messageType = "error";
        })
        .finally(() => {
          setTimeout(() => {
            this.isLoading = false;
          }, 2000);
        });
    },
  },
  data() {
    return {
      successMessage: "",
      isLoading: false,
      email_address: "",
      password: "",
      message: "", // Stores the message to display
      messageType: "error", // Controls message styling (error or success)
      showPassword: false,
    };
  },
  computed: {
    fullDate() {
      const date = new Date();
      const options = {
        weekday: "long",
        year: "numeric",
        month: "long",
        day: "numeric",
      };
      return date
        .toLocaleDateString("en-US", options)
        .toUpperCase()
        .replace(",", "");
    },
  },

  mounted() {
    // Set CSRF token for axios
    axios.defaults.headers.common["X-CSRF-TOKEN"] = document.querySelector(
      'meta[name="csrf-token"]'
    ).content;

    const urlParams = new URLSearchParams(window.location.search);

    // ✅ Check for account activation
    if (urlParams.get("activated") === "true") {
      toastr.success(
        "Your account has been activated. Please try to login.",
        "Success",
        {
          timeOut: 5000,
          closeButton: true,
        }
      );
    }

    // ✅ Check for success message (e.g., from password reset)
    const message = urlParams.get("message");
    if (message) {
      this.successMessage = decodeURIComponent(message);

      // Auto-clear message after 10 seconds
      setTimeout(() => {
        this.successMessage = "";
      }, 5000);
    }

    // Clean the URL
    if (urlParams.has("activated") || urlParams.has("message")) {
      const cleanUrl = window.location.origin + window.location.pathname;
      window.history.replaceState({}, document.title, cleanUrl);
    }

    console.log("Login Mounted!");
  },
};
</script>
