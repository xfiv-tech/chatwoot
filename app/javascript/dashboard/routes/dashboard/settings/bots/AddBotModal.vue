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
        <!-- WHATSAPP CLOUD API -->
        <div v-if="showWaApiOptions" class="medium-12 columns">

          <div v-if="botChannel === 'whatsapp-360' || botChannel ===  'telegram'" >
            <label
              :class="{
                error: isPhoneNumberNotValid,
              }"
            >
              {{ $t('CONTACT_FORM.FORM.PHONE_NUMBER.LABEL') }}
              <woot-phone-input
                v-model="phoneNumber"
                :value="phoneNumber"
                :error="isPhoneNumberNotValid"
                :placeholder="$t('CONTACT_FORM.FORM.PHONE_NUMBER.PLACEHOLDER')"
                @input="onPhoneNumberInputChange"
                @blur="$v.phoneNumber.$touch"
                @setCode="setPhoneCode"
              />
              <span v-if="isPhoneNumberNotValid" class="message">
                {{ phoneNumberError }}
              </span>
            </label>
            <div
              v-if="isPhoneNumberNotValid || !phoneNumber"
              class="callout small warning"
            >
              {{ $t('CONTACT_FORM.FORM.PHONE_NUMBER.HELP') }}
            </div>
          </div>
          <label v-else :class="{ error: $v.phoneNumber.$error }">
            <div v-if="botChannel === 'whatsapp-cloud'">
              {{ $t('CREATE_BOT.FORM.ID_NUMBER_CLOUD.LABEL') }}
            </div>
            <div v-else>
              {{ $t('CREATE_BOT.FORM.PHONENUMBER.LABEL') }}
            </div>
            <input
              v-model.trim="phoneNumber"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.PHONENUMBER.PLACEHOLDER')"
              @input="$v.phoneNumber.$touch"
            />
          </label>
          <label :class="{ error: $v.idApiWA.$error }">
            {{ $t('CREATE_BOT.FORM.CLOUD_IDENTIFIER.LABEL') }}
            <input
              v-model.trim="idApiWA"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.CLOUD_IDENTIFIER.PLACEHOLDER')"
              @input="$v.idApiWA.$touch"
            />
          </label>
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
        <!-- WHATSAPP CLOUD API -->
        <!-- WHATSAPP 360 DIALOG -->
        <div v-if="show360Options" class="medium-12 columns">
          <div v-if="botChannel === 'whatsapp-360' || botChannel ===  'telegram'" >
            <label
              :class="{
                error: isPhoneNumberNotValid,
              }"
            >
              {{ $t('CONTACT_FORM.FORM.PHONE_NUMBER.LABEL') }}
              <woot-phone-input
                v-model="phoneNumber"
                :value="phoneNumber"
                :error="isPhoneNumberNotValid"
                :placeholder="$t('CONTACT_FORM.FORM.PHONE_NUMBER.PLACEHOLDER')"
                @input="onPhoneNumberInputChange"
                @blur="$v.phoneNumber.$touch"
                @setCode="setPhoneCode"
              />
              <span v-if="isPhoneNumberNotValid" class="message">
                {{ phoneNumberError }}
              </span>
            </label>
            <div
              v-if="isPhoneNumberNotValid || !phoneNumber"
              class="callout small warning"
            >
              {{ $t('CONTACT_FORM.FORM.PHONE_NUMBER.HELP') }}
            </div>
          </div>

          <label v-else :class="{ error: $v.phoneNumber.$error }">
            {{ $t('CREATE_BOT.FORM.PHONENUMBER.LABEL') }}
            <input
              v-model.trim="phoneNumber"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.PHONENUMBER.PLACEHOLDER')"
              @input="$v.phoneNumber.$touch"
            />
          </label>
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

        
        <!-- WHATSAPP CLOUD API -->
        <div class="medium-12 columns">
          <label >
              {{ $t('CREATE_BOT.FORM.TEAMS_BOT.LABEL') }}
              <multiselect
                v-model="selectedAgents"
                :options="listAgents"
                track-by="id"
                label="available_name"
                :multiple="true"
                :close-on-select="false"
                :clear-on-select="false"
                :hide-selected="true"
                placeholder="Pick some"
                selected-label
                :select-label="$t('FORMS.MULTISELECT.ENTER_TO_SELECT')"
                :deselect-label="$t('FORMS.MULTISELECT.ENTER_TO_REMOVE')"
                @select="$v.selectedAgents.$touch"
              />
          </label>
        </div>
        
        <div class="modal-footer">
          <div class="medium-12 columns">
            <woot-submit-button
              :disabled="
                $v.botName.$invalid ||
                $v.botChannel.$invalid ||
                  iscreating
              "
              :button-text="$t('CREATE_BOT.FORM.SUBMIT')"
              :loading="iscreating"
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
import { isPhoneNumberValid } from 'shared/helpers/Validators';
import parsePhoneNumber from 'libphonenumber-js';

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
      iscreating: false,
      botName: '',
      botChannel: '',
      botAccessToken: '',
      phoneNumber: '',
      showToken: false,
      showWhatsappId: false,
      showWaApiOptions: false,
      show360Options: false,
      channels: [],
      idApiWA: '',
      listAgents: [],
      selectedAgents: [],
      activeDialCode: '',
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
    phoneNumber: {},
    wappid: {
      required,
      minLength: minLength(1),
    },
    idApiWA: {
      required,
      minLength: minLength(1),
    },
    selectedAgents: {
      required
    },
    
  },
  computed: {
    ...mapGetters({
      uiFlags: 'agents/getUIFlags',
    }),
    vaidateTokenForChannels() {
      return this.tokensChannels.includes(this.channel)
    },
    parsePhoneNumber() {
      return parsePhoneNumber(this.phoneNumber);
    },
    isPhoneNumberNotValid() {
      if (this.phoneNumber !== '') {
        return (
          !isPhoneNumberValid(this.phoneNumber, this.activeDialCode) ||
          (this.phoneNumber !== '' ? this.activeDialCode === '' : false)
        );
      }
      return false;
    },
    phoneNumberError() {
      if (this.activeDialCode === '') {
        return this.$t('CONTACT_FORM.FORM.PHONE_NUMBER.DIAL_CODE_ERROR');
      }
      if (!isPhoneNumberValid(this.phoneNumber, this.activeDialCode)) {
        return this.$t('CONTACT_FORM.FORM.PHONE_NUMBER.ERROR');
      }
      return '';
    },
  },
  methods: {
    // Numero de telefono con componente
    setPhoneCode(code) {
      if (this.phoneNumber !== '' && this.parsePhoneNumber) {
        const dialCode = this.parsePhoneNumber.countryCallingCode;
        if (dialCode === code) {
          return;
        }
        this.activeDialCode = `+${dialCode}`;
        const newPhoneNumber = this.phoneNumber.replace(
          `+${dialCode}`,
          `${code}`
        );
        this.phoneNumber = newPhoneNumber;
      } else {
        this.activeDialCode = code;
      }
    },
    onPhoneNumberInputChange(value, code) {
      this.activeDialCode = code;
    },
    changeselect(e){
      this.showWaApiOptions = ["instagram","messanger","whatsapp-cloud"].includes(e.target.value)
      this.show360Options = ["telegram","whatsapp-qr","whatsapp-360"].includes(e.target.value)
    },
    async addBot() {
      const { data } = await axios({
        method: 'post',
        url: config.ENDPOINT_BACKEND + 'accessconfig/api/v1/inbox/'+this.idaccount,
        data: {
          "name": `${this.botChannel}-${this.phoneNumber.slice(-4)}`
        }
      })
      const listid = this.selectedAgents.map(e => e.id)
      // ASIGNACION DE LOS AGENTES A LOS INBOX
      await axios({
        method: 'post',
        url: config.ENDPOINT_BACKEND + `accessconfig/api/v1/inbox/${this.idaccount}/${data.data.id}`,
        data: {
          "type": false,
          "inbox_id": data.data.id,
          "user_ids": listid
        }
      })
      const createbot = await axios({
        method: 'post',
        url: config.ENDPOINT_BACKEND + 'accessconfig/info/account_bot_creatd/'+this.idaccount,
        data: {
          "bots": [
              {
                "name": this.botName,
                "phoneNumber": this.phoneNumber,
                "channels": this.botChannel,
                "access_token": this.botAccessToken,
                "IdWhatsAppBusiness": this.idApiWA,
                "inbox_id": data.data.id,
              }
          ]
        }
      })
      console.log(createbot, "create bot")
      this.$emit('getbots', this.idaccount);
      this.showAlert(this.$t('CREATE_BOT.API.SUCCESS_MESSAGE'));
      this.onClose()
      this.iscreating = true;
    },
    async getListChannels() {
      const channels = await axios({
        method: 'get',
        url: config.ENDPOINT_BACKEND + 'accessconfig/api/v1/channelhost'
      })
      this.channels = channels.data;
    },
    async getAllAgents() {
      const agents = await axios({
        method: 'get',
        url: config.ENDPOINT_BACKEND + 'accessconfig/api/v1/agents/'+this.idaccount
      })
      console.log(agents.data)
      this.listAgents = agents.data;
    }
  },
  created() {
    this.getListChannels()
    this.getAllAgents()
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
