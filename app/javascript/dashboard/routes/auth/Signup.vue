<template>
  <div class="h-full w-full">
    <div v-show="!isLoading" class="row h-full">
      <div class="large-6 signup-form--container" >
        <div class="signup-form--content">
          <div class="signup--hero">
            <img
              :src="globalConfig.logo"
              :alt="globalConfig.installationName"
              class="hero--logo"
            />
          </div>
          <p class="hero--title">
            {{ $t('REGISTER.TRY_WOOT') }}
          </p>
          <signup-form />
          <div class="auth-screen--footer">
            <span>{{ $t('REGISTER.HAVE_AN_ACCOUNT') }}</span>
            <router-link to="/app/login">
              {{
                useInstallationName(
                  $t('LOGIN.TITLE'),
                  globalConfig.installationName
                )
              }}
            </router-link>
          </div>
        </div>
      </div>
      <div class="bg_experience large-6 ">
        <img class="bg_experience_image" src="https://xfiv-content.s3.amazonaws.com/banner-onboarding.png" />
      </div>
      <!-- <testimonials
        v-if="isAChatwootInstance"
        class="medium-6 testimonial--container"
        @resize-containers="resizeContainers"
      /> -->
    </div>
    <div v-show="isLoading" class="spinner--container">
      <spinner size="" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import globalConfigMixin from 'shared/mixins/globalConfigMixin';
import SignupForm from './components/Signup/Form.vue';
// import Testimonials from './components/Testimonials/Index.vue';
import Spinner from 'shared/components/Spinner.vue';

export default {
  components: {
    SignupForm,
    Spinner,
    // Testimonials,
  },
  mixins: [globalConfigMixin],
  data() {
    return { showTestimonials: false, isLoading: false };
  },
  computed: {
    ...mapGetters({ globalConfig: 'globalConfig/get' }),
    // isAChatwootInstance() {
    //   return this.globalConfig.installationName === 'Xfiv';
    // },
  },
  beforeMount() {
    // this.isLoading = this.isAChatwootInstance;
  },
  methods: {
    // resizeContainers(hasTestimonials) {
    //   this.showTestimonials = hasTestimonials;
    //   this.isLoading = false;
    // },
  },
};
</script>
<style scoped lang="scss">
.container-flex {
  display: flex;
}
.bg_experience {
  width: 50%;
  height: 100%;
  overflow: hidden;
  position: relative;
  display: flex;
  justify-content: end;
  &_image {
    height: 100%;
    width: auto;
  }
}
.bg_image {
  height: 100%;
  width: 100%;
}
.signup-form--container {
  display: flex;
  align-items: center;
  height: 100%;
  min-height: 640px;
  overflow: auto;
  justify-content: center;
}

.signup-form--content {
  padding: var(--space-larger);
  max-width: 600px;
  width: 100%;
}

.signup--hero {
  margin-bottom: var(--space-normal);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  .hero--logo {
    width: 160px;
  }

}
.hero--title {
  margin-top: var(--space-medium);
  margin-bottom: 10px;
  font-weight: var(--font-weight-light);
  font-size: 2.5rem;
}

.auth-screen--footer {
  font-size: var(--font-size-small);
}

@media screen and (max-width: 1200px) {
  .testimonial--container {
    display: none;
  }
  .signup-form--container {
    width: 100%;
    flex: 0 0 100%;
    max-width: 100%;
  }
  .signup-form--content {
    margin: 0 auto;
  }
}

.spinner--container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}
</style>
