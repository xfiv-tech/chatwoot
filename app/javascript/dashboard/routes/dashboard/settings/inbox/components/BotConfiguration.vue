<template>
  <div class="settings--content">
    <loading-state v-if="uiFlags.isFetching || uiFlags.isFetchingAgentBot" />
    <div class="row">
      <div class="small-12">
        <div class="container_qr">
          <div class="container_qr_contimg">
            <div class="container_qr_contimg_box">
              <!-- <img class="container_qr_contimg_box_icon" src="./refreshicon.png" /> -->
              <div v-if="status === 'Conectado'" class="container_qr_contimg_box_connected">
                <p>Ya se encuentra conectado✌</p>
              </div>
              <div v-if="status === 'Conectado'" class="container_qr_contimg_box_bg">
              </div>
              <div :style="changeClassStatus" class="container_qr_contimg_box_img" v-html="svgContent"></div>
            </div>
            
          </div>
          <div class="container_qr_bot">
            <!-- <h2>✌ Lee antes de escanear</h2> -->
            <p>Para configurar debes ir a las configuraciones de tu teléfono</p>
            <p>Encuéntralo en <b>Configuración Dispositivos Vinculados > Vincular un dispositivo</b></p>
            <div class="button_container">
              <div v-if="status === 'Conectado'" @click="cleanSessionQRCode()" class="button_container_btn">
                <p> Desconectar</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import SettingsSection from 'dashboard/components/SettingsSection';
import LoadingState from 'dashboard/components/widgets/LoadingState';
import alertMixin from 'shared/mixins/alertMixin';
import { config } from '../../../../../config/config'
import axios from 'axios'

export default {
  components: {
    LoadingState,
    SettingsSection,
  },
  mixins: [alertMixin],
  props: {
    inbox: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      selectedAgentBotId: null,
      svgContent: '',
      statusQRSession: '',
      timerInterval: null,
      userAccount: '',
      status: '' //Conectado, Error de conexion, Reconectando, Generando nuevo token qr
    };
  },
  computed: {
    ...mapGetters({
      agentBots: 'agentBots/getBots',
      uiFlags: 'agentBots/getUIFlags',
    }),
    activeAgentBot() {
      return this.$store.getters['agentBots/getActiveAgentBot'](this.inbox.id);
    },
  },
  watch: {
    activeAgentBot() {
      this.selectedAgentBotId = this.activeAgentBot.id;
    },
  },
  mounted() {
    this.$store.dispatch('agentBots/get');
    this.$store.dispatch('agentBots/fetchAgentBotInbox', this.inbox.id);
  },
  methods: {
    changeClassStatus() {
      return {
        filter: this.status !== 'Conectado' ? 'blur(0)' : 'blur(3px)',
      };

    },
    async getQrCode() {
      const {data} = await axios.get(config.ENDPOINT_BACKEND + 'accessconfig/info/account_qr/' + this.userAccount);
      const generatedQR = await axios.get(data.data.host + data.data.path_qr);
      this.svgContent = generatedQR.data;
    },
    async cleanSessionQRCode() {
      const {data} = await axios.get(config.ENDPOINT_BACKEND + 'accessconfig/info/account_qr/' + this.userAccount);
      const clean = await axios.get(data.data.host + data.data.path_qr_limpiar)
      const statusSess = this.getStatusSession();
      this.status = statusSess;
      this.getQrCode()
      this.timerInterval = setInterval(this.getQrCode, 30000);
    },
    async getStatusSession() {
      const {data} = await axios.get(config.ENDPOINT_BACKEND + 'accessconfig/info/account_qr/' + this.userAccount);
      const session = await axios.get(data.data.host + data.data.path_qr_stado)
      this.status = session.data.message;
      console.log(session.data.message)
      return session.data.message
    }, 
    async updateActiveAgentBot() {
      try {
        await this.$store.dispatch('agentBots/setAgentBotInbox', {
          inboxId: this.inbox.id,
          // Added this to make sure that empty values are not sent to the API
          botId: this.selectedAgentBotId ? this.selectedAgentBotId : undefined,
        });
        this.showAlert(this.$t('AGENT_BOTS.BOT_CONFIGURATION.SUCCESS_MESSAGE'));
      } catch (error) {
        this.showAlert(this.$t('AGENT_BOTS.BOT_CONFIGURATION.ERROR_MESSAGE'));
      }
    },
    async disconnectBot() {
      try {
        await this.$store.dispatch('agentBots/disconnectBot', {
          inboxId: this.inbox.id,
        });
        this.showAlert(
          this.$t('AGENT_BOTS.BOT_CONFIGURATION.DISCONNECTED_SUCCESS_MESSAGE')
        );
      } catch (error) {
        this.showAlert(
          error?.message ||
          this.$t('AGENT_BOTS.BOT_CONFIGURATION.DISCONNECTED_ERROR_MESSAGE')
        );
      }
    },
  },
  created() {
    this.userAccount = this.$route.params.accountId;
    this.getStatusSession();
    if (this.status !== 'Conectado') {
      this.getQrCode();
    }
    setInterval(this.getStatusSession, 5000);
  },
  beforeDestroy() {
    clearInterval(this.timerInterval);
    // clearInterval(this.getStatusSession);
  }
};
</script>

<style scoped lang="scss">
.button--disconnect {
  margin-left: var(--space-small);
}

.button_container {
  width: 100%;
  display: flex;
  justify-content: center;
  &_btn {
    background-color: #007EF3;
    color: #ffffff;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
    padding: 7px 12px;
    cursor: pointer;
    p {
      font-weight: 600;
      margin: 0;
      padding: 0;
    }
    &:hover {
      background-color: #0774da;
    }
  }
}
.container_qr {
  text-align: center;
  margin-left: auto;
  margin-right: auto;
  padding: 25px;
  display: block;
  justify-content: center;
  &_contimg {
    display: flex;
    justify-content: center;
    width: 100%;
    height: auto;
    &_box {
      width: 200px;
      height: 200px;
      position: relative;
      border-radius: 20px;
      &_connected {
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 1rem;
        font-size: 1.3rem;
        color: #ffffff;
        font-weight: 600;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 12;
      }
      &_icon {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 12;
      }
      &_bg {
        width: 100%;
        height: 100%;
        position: absolute;
        background-color: #000000;
        opacity: .6;
        top: 0;
        left: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 10;
      }
      &_img {
        // filter: blur(3px);
        width: 100%;
        height: 100%;
        border: 1px solid #000000;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 1;
      }
    }
  }
  &_bot {
    margin-top: 30px;
    p {
      font-size: 1.5rem;
    }
  }
}
</style>
