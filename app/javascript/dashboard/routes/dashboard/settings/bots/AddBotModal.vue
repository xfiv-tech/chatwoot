<template>
  <woot-modal
    :show="show"
    :on-close="onClose"
    class="account-selector--modal"
  >
    <div class="column content-box">
      <woot-modal-header
        :header-title="$t('CREATE_BOT.NEW_BOT')"
        :header-content="$t('CREATE_BOT.SELECTOR_SUBTITLE')"
      />
      <div v-if="!hasBots" class="alert-wrap">
        <div class="callout alert">
          <div class="icon-wrap">
            <fluent-icon icon="warning" />
          </div>
          {{ $t('CREATE_BOT.NO_BOTS_WARNING') }}
        </div>
      </div>

      <form class="row" @submit.prevent="addBot">
        <div class="medium-12 columns">
          <label :class="{ error: $v.botName.$error }">
            {{ $t('CREATE_BOT.FORM.NAME.LABEL') }}
            <input
              v-model.trim="botName"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.NAME.PLACEHOLDER')"
              @input="$v.botName.$touch"
            />
          </label>
        </div>
        <div class="modal-footer">
          <div class="medium-12 columns">
            <woot-submit-button
              :disabled="
                $v.botName.$invalid ||
                  uiFlags.isCreating
              "
              :button-text="$t('CREATE_BOT.FORM.SUBMIT')"
              :loading="uiFlags.isCreating"
            />
            <button class="button clear" @click.prevent="onClose">
              {{ $t('CREATE_BOT.FORM.CANCEL') }}
            </button>
          </div>
        </div>
      </form>
    </div>
  </woot-modal>
</template>

<script>
import { required, minLength } from 'vuelidate/lib/validators';
import { mapGetters } from 'vuex';
import alertMixin from 'shared/mixins/alertMixin';
import axios from 'axios';

export default {
  mixins: [alertMixin],
  props: {
    show: {
      type: Boolean,
      default: false,
    },
    idaccount: {
      type: String,
      default: true,
    },
    hasBots: {
      type: Boolean,
      default: true,
    },
    onClose: {
      type: Function,
      default: () => {},
    },
  },
  data() {
    return {
      botName: '',
    };
  },
  validations: {
    botName: {
      required,
      minLength: minLength(1),
    },
  },
  computed: {
    ...mapGetters({
      uiFlags: 'agents/getUIFlags',
    }),
  },
  methods: {
    async addBot() {
      try {
        const createAccount = await axios.post('https://cloud-dev.xfiv.chat/accessconfig/info/account_bot_creatd/'+idaccount,{
          "bots": [
            {
                "name": this.botName,
                "identity": ""
            }
          ]
        })
        console.log(createAccount)
        this.showAlert(this.$t('CREATE_BOT.API.SUCCESS_MESSAGE'));
      } catch (error) {
        this.showAlert(this.$t('CREATE_BOT.API.ERROR_MESSAGE'));
        // if (error.response.status === 422) {
        //   this.showAlert(this.$t('CREATE_BOT.API.EXIST_MESSAGE'));
        // } else {
        //   this.showAlert(this.$t('CREATE_BOT.API.ERROR_MESSAGE'));
        // }
      }
    },
  },
};
</script>
<style lang="scss" scoped>
.alert-wrap {
  font-size: var(--font-size-small);
  margin: var(--space-medium) var(--space-large) var(--space-zero);

  .callout {
    align-items: center;
    border-radius: var(--border-radius-normal);
    display: flex;
  }
}

.icon-wrap {
  margin-left: var(--space-smaller);
  margin-right: var(--space-slab);
}
</style>
