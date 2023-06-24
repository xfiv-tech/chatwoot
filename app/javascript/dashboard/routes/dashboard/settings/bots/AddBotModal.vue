<template>
  <woot-modal
    :show="show"
    :on-close="onClose"
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
        <div class="medium-12 columns">
          <label :class="{ error: $v.botChannel.$error }">
            {{ $t('CREATE_BOT.FORM.CHANNEL.LABEL') }}
            <select @change="changeselect" v-model="botChannel">
              <option v-for="channel in channels" :key="channel.channel" :value="channel.channel">
                {{ channel.channel }}
              </option>
            </select>
            <span v-if="$v.botChannel.$error" class="message">
              {{ $t('CREATE_BOT.FORM.CHANNEL.ERROR') }}
            </span>
          </label>
        </div>
        <!-- <div v-if="showToken" class="medium-12 columns">
          <label :class="{ error: $v.phoneNumber.$error }">
            {{ $t('CREATE_BOT.FORM.PHONENUMBER.LABEL') }}
            <input
              v-model.trim="phoneNumber"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.PHONENUMBER.PLACEHOLDER')"
              @input="$v.phoneNumber.$touch"
            />
          </label>
        </div>
        <div v-if="showToken" class="medium-12 columns">
          <label :class="{ error: $v.botAccessToken.$error }">
            {{ $t('CREATE_BOT.FORM.TOKEN.LABEL') }}
            <input
              v-model.trim="botAccessToken"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.TOKEN.PLACEHOLDER')"
              @input="$v.botAccessToken.$touch"
            />
          </label>
        </div>
        <div v-if="showWhatsappId" class="medium-12 columns">
          <label :class="{ error: $v.wappid.$error }">
            WhatsApp Business ID
            <input
              v-model.trim="wappid"
              type="text"
              placeholder="Id..."
              @input="$v.wappid.$touch"
            />
          </label>
        </div> -->
        <!-- WHATSAPP CLOUD API -->
        <div v-if="showWaApiOptions" class="medium-12 columns">
          <label :class="{ error: $v.tokenApiWA.$error }">
            {{ $t('CREATE_BOT.FORM.WHATSAPP_CLOUD_API.TOKEN.LABEL') }}
            <input
              v-model.trim="tokenApiWA"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.WHATSAPP_CLOUD_API.TOKEN.PLACEHOLDER')"
              @input="$v.tokenApiWA.$touch"
            />
          </label>
          <label :class="{ error: $v.idApiWA.$error }">
            {{ $t('CREATE_BOT.FORM.WHATSAPP_CLOUD_API.IDENTIFIER.LABEL') }}
            <input
              v-model.trim="idApiWA"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.WHATSAPP_CLOUD_API.IDENTIFIER.PLACEHOLDER')"
              @input="$v.idApiWA.$touch"
            />
          </label>
          <label :class="{ error: $v.numberApiWA.$error }">
            {{ $t('CREATE_BOT.FORM.WHATSAPP_CLOUD_API.MOBILE.LABEL') }}
            <input
              v-model.trim="numberApiWA"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.WHATSAPP_CLOUD_API.MOBILE.PLACEHOLDER')"
              @input="$v.numberApiWA.$touch"
            />
          </label>
        </div>
        <!-- WHATSAPP CLOUD API -->
        <!-- WHATSAPP 360 DIALOG -->
        <div v-if="show360Options" class="medium-12 columns">
          <label :class="{ error: $v.number360dialog.$error }">
            {{ $t('CREATE_BOT.FORM.WHATSAPP_360_DIALOG.MOBILE.LABEL') }}
            <input
              v-model.trim="number360dialog"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.WHATSAPP_360_DIALOG.MOBILE.PLACEHOLDER')"
              @input="$v.number360dialog.$touch"
            />
          </label>
          <label :class="{ error: $v.key360dialog.$error }">
            {{ $t('CREATE_BOT.FORM.WHATSAPP_360_DIALOG.KEY.LABEL') }}
            <input
              v-model.trim="key360dialog"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.WHATSAPP_360_DIALOG.KEY.PLACEHOLDER')"
              @input="$v.key360dialog.$touch"
            />
          </label>
        </div>
        <!-- WHATSAPP CLOUD API -->
        <div class="modal-footer">
          <div class="medium-12 columns">
            <woot-submit-button
              :disabled="
                $v.botName.$invalid ||
                $v.botChannel.$invalid ||
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
import { config } from '../../../../config/config'

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
      tokensChannels: ["whatsapp-360","whatsapp-cloud","telegram"],
      botName: '',
      botChannel: '',
      botAccessToken: '',
      phoneNumber: '',
      showToken: false,
      showWhatsappId: false,
      showWaApiOptions: false,
      show360Options: false,
      channels: [],
      tokenApiWA: '',
      idApiWA: '',
      numberApiWA: '',
      number360dialog: '',
      key360dialog: '',
    };
  },
  validations: {
    botName: {
      required,
      minLength: minLength(1),
    },
    botChannel: {
      required,
      minLength: minLength(1),
    },
    botAccessToken: {
      required,
      minLength: minLength(1),
    },
    phoneNumber: {
      required,
      minLength: minLength(1),
    },
    wappid: {
      required,
      minLength: minLength(1),
    },
    tokenApiWA: {
      required,
      minLength: minLength(1),
    },
    idApiWA: {
      required,
      minLength: minLength(1),
    },
    numberApiWA: {
      required,
      minLength: minLength(1),
    },
    number360dialog: {
      required,
      minLength: minLength(1),
    },
    key360dialog: {
      required,
      minLength: minLength(1),
    },
  },
  computed: {
    ...mapGetters({
      uiFlags: 'agents/getUIFlags',
    }),
    vaidateTokenForChannels() {
      return this.tokensChannels.includes(this.channel)
    },
  },
  methods: {
    changeselect(e){
      // const validate = this.tokensChannels.includes(e.target.value)
      // this.showToken = validate
      this.showWaApiOptions = e.target.value === "whatsapp-cloud" && true
      this.show360Options = e.target.value === "whatsapp-360" && true
    },
    async addBot() {
      // try {
      const createAccount = await axios({
        method: 'post',
        url: config.ENDPOINT_BACKEND + 'accessconfig/info/account_bot_creatd/'+this.idaccount,
        data: {
          "bots": [
              {
                "name": this.botName,
                "phoneNumber": this.phoneNumber,
                "channels": this.botChannel,
                "access_token": this.botAccessToken
              }
          ]
        }
      })
      console.log(createAccount)
      this.$emit('getbots', this.idaccount);
      this.showAlert(this.$t('CREATE_BOT.API.SUCCESS_MESSAGE'));
      this.onClose()
    },
    async listChannels() {
      const channels = await axios({
        method: 'get',
        url: config.ENDPOINT_BACKEND + 'accessconfig/api/v1/channelhost'
      })
      this.channels = channels.data;
    }
  },
  created() {
    this.listChannels()
  }
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
