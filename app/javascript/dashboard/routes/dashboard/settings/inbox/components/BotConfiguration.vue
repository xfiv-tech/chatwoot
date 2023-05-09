<template>
  <div class="settings--content">
    <loading-state v-if="uiFlags.isFetching || uiFlags.isFetchingAgentBot" />
    <div class="row">
      <div class="small-12">
        <div class="card">
          <div class="contenedor-img">
            <p>+593 996232139</p>
            <img
              src="https://www.ocu.org/-/media/ta/images/_%20orphaned/qr-code.png?rev=2e1cc496-40d9-4e21-a7fb-9e2c76d6a288&hash=38DA21F2DF33F4BB3CE83BE5D2A723F5&mw=960"
              class="img">
          </div>
          <div class="body-card">
            <h2>✌ Lee antes de escanear</h2>
            <h3>Debes ir a las configuraciones de tu teléfono</h3>
            <p>Encuéntralo en <b>Configuración Dispositivos Vinculados > Vincular un dispositivo</b></p>

            <a class="boton btn-primary">Actualizar</a>
          </div>
        </div>
      </div>
    </div>
    <!-- <form v-else class="row" @submit.prevent="updateActiveAgentBot">
      <settings-section
        :title="$t('AGENT_BOTS.BOT_CONFIGURATION.TITLE')"
        :sub-title="$t('AGENT_BOTS.BOT_CONFIGURATION.DESC')"
      >
        <div class="medium-7 columns">
          <label>
            <select v-model="selectedAgentBotId">
              <option value="" disabled selected>{{
                $t('AGENT_BOTS.BOT_CONFIGURATION.SELECT_PLACEHOLDER')
              }}</option>
              <option
                v-for="agentBot in agentBots"
                :key="agentBot.id"
                :value="agentBot.id"
              >
                {{ agentBot.name }}
              </option>
            </select>
          </label>
          <div class="button-container">
            <woot-submit-button
              :button-text="$t('AGENT_BOTS.BOT_CONFIGURATION.SUBMIT')"
              :loading="uiFlags.isSettingAgentBot"
            />
            <woot-button
              type="button"
              :disabled="!selectedAgentBotId"
              :loading="uiFlags.isDisconnecting"
              variant="smooth"
              color-scheme="alert"
              class="button--disconnect"
              @click="disconnectBot"
            >
              {{ $t('AGENT_BOTS.BOT_CONFIGURATION.DISCONNECT') }}
            </woot-button>
          </div>
        </div>
      </settings-section>
    </form> -->
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import SettingsSection from 'dashboard/components/SettingsSection';
import LoadingState from 'dashboard/components/widgets/LoadingState';
import alertMixin from 'shared/mixins/alertMixin';

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
};
</script>

<style scoped lang="scss">
.button--disconnect {
  margin-left: var(--space-small);
}

.card {
  text-align: center;
  margin-left: auto;
  margin-right: auto;
  padding: 25px;
  display: block;
  justify-content: center;
}

.contenedor-img p {
  font-weight: bold;
  font-size: 25px;
}

.contenedor-img img {
  width: 200px;
  height: 200px;
  border: 1px solid black;
}

.body-card h2 {
  font-size: 30px;
}

.body-card h3 {
  font-size: 25px;
}

.body-card p {
  font-size: 20px;
  margin-bottom: 40px;
}


.boton {
  padding: 15px;
  margin: 30px;
}

.btn-primary {
  background-color: rgb(22, 74, 218);
  color: white;
  font-weight: bold;
  font-size: 18px;
  box-shadow: 2px 2px 10px 2px rgba(130, 130, 130, 0.724);
  cursor: pointer;
}

.btn-primary:hover {
  box-shadow: 2px 2px 10px 2px rgba(59, 59, 59, 0.724);
}
</style>
