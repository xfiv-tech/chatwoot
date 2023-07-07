<template>
  <woot-modal
    :show="show"
    :on-close="onClose"
  >
    <div class="column content-box">
      <woot-modal-header
        :header-title="$t('UPDATE_BOT.TITLE')"
        :header-content="$t('UPDATE_BOT.SUBTITLE')"
      />
      <div v-if="!hasBots" class="alert-wrap">
        <div class="callout alert">
          <div class="icon-wrap">
            <fluent-icon icon="warning" />
          </div>
          {{ $t('CREATE_BOT.NO_BOTS_WARNING') }}
        </div>
      </div>

      <form class="row" @submit.prevent="updateBot">
        <div class="medium-12 columns">
          <label >
            {{ $t('CREATE_BOT.FORM.NAME.LABEL') }}
            <input
              v-model.trim="botData.name"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.NAME.PLACEHOLDER')"
            />
          </label>
        </div>

        <div class="medium-12 columns">
          <label v-if="botChannel === 'whatsapp-360'" :class="{ error: $v.botData.phoneNumber.$error }">
            <div>
              {{ $t('CREATE_BOT.FORM.PHONENUMBER.LABEL') }}
            </div>
            <input
              v-model.trim="botData.phoneNumber"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.PHONENUMBER.PLACEHOLDER')"
            />
          </label>
        </div>

        <div class="medium-12 columns">
          <label>
            {{ $t('CREATE_BOT.FORM.TOKEN.LABEL') }}
            <input
              v-model.trim="botData.access_token"
              type="text"
              :placeholder="$t('CREATE_BOT.FORM.TOKEN.PLACEHOLDER')"
            />
          </label>
        </div>
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
                  iscreating
              "
              :button-text="$t('CREATE_BOT.FORM.UPDATE')"
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

export default {
  mixins: [alertMixin],
  props: {
    botDataEdit: {
      type: Object,
      required: true
    },
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
      selectedAgents: []
    };
  },
  validations: {
    botName: {
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
    botData: {
      get() {
        return this.botDataEdit
      },
      set(val) {
        this.botDataEdit = value
      }
    }
  },
  methods: {
    changeselect(e){
      this.showWaApiOptions = ["instagram","messanger","whatsapp-cloud"].includes(e.target.value)
      this.show360Options = ["telegram","whatsapp-qr","whatsapp-360"].includes(e.target.value)
    },
    async updateBot() {
      const listid = this.selectedAgents.map(e => e.id)
      // ASIGNACION DE LOS AGENTES A LOS INBOX
      await axios({
        method: 'post',
        url: config.ENDPOINT_BACKEND + `accessconfig/api/v1/inbox/${this.idaccount}/${this.botData.inbox_id}`,
        data: {
          "type": true,
          "user_ids": listid
        }
      })
      console.log(this.botData, 'botData')
      console.log(listid, 'listid')
      const data = {
        ...this.botData,
        "account_identifier": this.botData.account_id,
        "idBot": this.botData.id,
      }
      const update = await axios({
        method: 'put',
        url: config.ENDPOINT_BACKEND + 'accessconfig/api/v1/update_bot/'+this.botData.account_id,
        data: data
      })
      this.$emit('getbots', this.idaccount);
      this.showAlert(this.$t('CREATE_BOT.UPDATE_API.SUCCESS_MESSAGE'));
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
    },
    async getListSelectedAgentsByBot() {
      const agents = await axios({
        method: 'get',
        url: config.ENDPOINT_BACKEND + `accessconfig/api/v1/inbox/${this.botData.account_id}/${this.botData.inbox_id}`
      })
      console.log(agents)
      this.selectedAgents = agents.data.data;
    }
  },
  created() {
    this.getListChannels()
    this.getListSelectedAgentsByBot()
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
