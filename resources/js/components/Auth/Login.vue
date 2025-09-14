<template>
  <div class="row justify-content-center">
    <div class="col-md-8 col-lg-6 col-xl-5">
      <div class="card mt-4 card-bg-fill">
        <div class="card-body p-4">
          <div class="text-center mt-2">
            <h5 class="text-primary">Welcome Back!</h5>
            <p class="text-muted">Sign in to continue to Real Estate Management System.</p>
          </div>

          <!-- Success message (e.g. from password reset or activation) -->
          <div v-if="successMessage" class="alert alert-success mt-3" role="alert">
            {{ successMessage }}
          </div>

          <!-- Error or status message -->
          <div v-if="message" :class="['alert', messageType === 'error' ? 'alert-danger' : 'alert-success']" role="alert">
            {{ message }}
          </div>

          <div class="p-2 mt-4">
            <!-- ✅ Changed to prevent default form submission -->
            <form @submit.prevent="loginUser">
              <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input v-model="email_address" type="text" class="form-control" id="username" placeholder="Enter username" />
              </div>

              <div class="mb-3">
                <div class="float-end">
                  <a href="auth-pass-reset-basic.html" class="text-muted">Forgot password?</a>
                </div>
                <label class="form-label" for="password-input">Password</label>
                <div class="position-relative auth-pass-inputgroup mb-3">
                  <input
                    :type="showPassword ? 'text' : 'password'"
                    v-model="password"
                    class="form-control pe-5 password-input"
                    placeholder="Enter password"
                    id="password-input"
                  />
                  <button
                    class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none"
                    type="button"
                    @click="showPassword = !showPassword"
                  >
                    <i :class="showPassword ? 'ri-eye-off-fill' : 'ri-eye-fill'" class="align-middle"></i>
                  </button>
                </div>
              </div>

              <div class="mt-4">
                <button class="btn btn-success w-100" type="submit" :disabled="isLoading">
                  <span v-if="isLoading">
                    <i class="fas fa-spinner fa-spin me-1"></i> Signing In...
                  </span>
                  <span v-else>Sign In</span>
                </button>
              </div>
            </form>
          </div>
        </div>
        <!-- end card body -->
      </div>
    </div>
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
