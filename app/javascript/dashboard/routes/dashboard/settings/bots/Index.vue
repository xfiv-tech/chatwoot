<template>
  <div class="column content-box">
    <woot-button
      color-scheme="success"
      class-names="button--fixed-top"
      icon="add-circle"
      @click="openAddPopup()"
    >
      {{$t('CREATE_BOT.NEW_BOT')}}
    </woot-button>

    <!-- List Agents -->
    <div class="row">
      <div class="small-5 mr columns with-right-pace" v-for="bot in bots" :key="bot.id">
        <div class="card">
          <div class="row">
            <div class="small-12 columns bot_cont">
              
              <div class="bot_cont_left">
                <h5>{{ bot.name }}</h5>
                <div class="bot_cont_left_info">
                  <div class="bot_cont_left_info_update">
                    <p><strong> {{$t('LIST_BOTS_OPTIONS.CHANNEL')}}</strong></p>
                    <p>{{'Webchat - ' + bot.channels}}</p>
                  </div>
                  <div class="cont bot_cont_left_info_socialmedia" >
                    <div v-if="bot.publicId !== null" class="online_state">
                      <p>{{$t('LIST_BOTS_OPTIONS.ONLINE_STATE')}}</p>
                    </div>
                    <!-- <div class="" v-for="social in socialmedias" :key="social.name">
                      <img class="bot_cont_left_info_socialmedia_img" :src='social.link' />
                    </div> -->
                  </div>
                </div>
              </div>
              <div class="bot_cont_rigth">
                <div
                  class="button_edit"
                  @click="goEditbot(bot)"
                >
                  <p>{{$t('LIST_BOTS_OPTIONS.BUTTON_EDIT')}}</p>
                </div>
                <div 
                  class="button_delete"
                  @click="deleteBot(bot)"
                >
                  <p>{{$t('LIST_BOTS_OPTIONS.BUTTON_DROP')}}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Add Agent -->
    <woot-modal :show.sync="showAddPopup" :on-close="hideAddPopup">
      <add-bot-modal
        :idaccount="this.$route.params.accountId"
        :show="showAddPopup"
        :on-close="hideAddPopup"
        @getbots="getAllbots"
      />
    </woot-modal>
    <!-- Edit Agent -->
    <woot-modal :show.sync="showEditPopup" :on-close="hideEditPopup">

    </woot-modal>

    <!-- Delete Bot -->
    <woot-delete-modal
      :show.sync="showDeletePopup"
      :on-close="hideClosePopup"
      :on-confirm="confirmDeletion"
      :title="$t('DELETE_BOT.COFIRM.TITLE')"
      :message="$t('DELETE_BOT.COFIRM.MESSAGE')"
      :message-value="deleteMessage"
      :confirm-text="deleteConfirmText"
      :reject-text="deleteRejectText"
    />

    <!-- <woot-modal :show.sync="showEditPopup" :on-close="hideEditPopup">

    </woot-modal> -->
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import globalConfigMixin from 'shared/mixins/globalConfigMixin';
import axios from 'axios';
import AddBotModal from './AddBotModal.vue';
import { config } from '../../../../config/config'


export default {
  components: {
    AddBotModal
  },
  mixins: [globalConfigMixin],
  data() {
    return {
      botSelected: {},
      loading: {},
      showAddPopup: false,
      showDeletePopup: false,
      showEditPopup: false,
      idUser:1,
      idUser: null,
      createdBot: true,
      socialmedias: [
        {name: 'whatsapp', link: 'https://cdn-icons-png.flaticon.com/512/124/124034.png?w=360'},
        {name: 'facebook', link: 'https://upload.wikimedia.org/wikipedia/commons/e/ee/Logo_de_Facebook.png'},
        {name: 'instagram', link: 'https://cdn-icons-png.flaticon.com/512/174/174855.png'},
        {name: 'twitter', link: 'https://cdn.icon-icons.com/icons2/836/PNG/512/Twitter_icon-icons.com_66803.png'},
        {name: 'telegram', link: 'https://cdn-icons-png.flaticon.com/512/124/124034.png?w=360'},
      ],
      bots:[
        {
          name: '',
          updatedAt: '',
          path_session: '',
          path_edit: ''
        }
      ],
    };
  },
  computed: {
    ...mapGetters({
      accountId: 'getCurrentAccountId',
      agentBots: 'agentBots/getBots',
      uiFlags: 'agentBots/getUIFlags',
    }),
    deleteMessage() {
      return ` ${this.botSelected.name}?`;
    },
    deleteConfirmText() {
      return `${this.$t('DELETE_BOT.COFIRM.YES')} ${
        this.botSelected.name
      }`;
    },
    deleteRejectText() {
      return `${this.$t('DELETE_BOT.COFIRM.NO')} ${
        this.botSelected.name
      }`;
    },
  },
  mounted() {
  },
  methods: {
    async getAllbots(accountId) {
      const bots = await axios.get(config.ENDPOINT_BACKEND + 'accessconfig/info/account_bot/'+accountId)
      // console.log(bots.data.data)
      this.bots = bots.data.data
    },
    changeFormateDate(date) {
      const dateTransform = new Date(date)
      const dia = dateTransform.getDate();
      const mes = dateTransform.getMonth() + 1; // Los meses en JavaScript se indexan desde 0
      const anio = dateTransform.getFullYear();
      const horas = dateTransform.getHours();
      const minutos = dateTransform.getMinutes();

      const diaFormateado = dia < 10 ? `0${dia}` : dia;
      const mesFormateado = mes < 10 ? `0${mes}` : mes;
      const horasFormateadas = horas < 10 ? `0${horas}` : horas;
      const minutosFormateados = minutos < 10 ? `0${minutos}` : minutos;

      // Construir la cadena de fecha formateada
      const fechaFormateada = `${diaFormateado}/${mesFormateado}/${anio} ${horasFormateadas}:${minutosFormateados}`;
      return fechaFormateada
    },
    generateSession(bot) {
      // return 
    },
    openAddPopup() {
      this.showAddPopup = true;
    },
    async goEditbot(bot) {
      window.open(`${bot.path_session}?redirect=${bot.path_edit}?account_id=${this.idUser}`, '_blank');
    },
    async deleteBot(bot) {
      this.showDeletePopup = true;
      this.botSelected = bot
    },
    async confirmDeletion() {
      const bots = await axios.delete(config.ENDPOINT_BACKEND + 'accessconfig/info/account_bot_delete/'+this.idUser+'/'+this.botSelected.id)
      this.getAllbots(this.idUser)
      this.hideClosePopup()
    },
    hideAddPopup() {
      this.showAddPopup = false;
    },
    hideClosePopup() {
      this.showDeletePopup = false;
    },

    // Edit Function
    openEditPopup(agent) {
      this.showEditPopup = true;
      this.currentAgent = agent;
    },
    hideEditPopup() {
      this.showEditPopup = false;
    },

    // Delete Function
    openDeletePopup(agent) {
      this.showDeletePopup = true;
      this.currentAgent = agent;
    },
    closeDeletePopup() {
      this.showDeletePopup = false;
    }
  },
  created() {
    this.idUser = this.$route.params.accountId;
    this.getAllbots(this.idUser)
  },
};
</script>
<style scoped lang="scss">
  .mr{
    margin-left: 20px;
    margin-bottom: 20px;
  }
  .cont {
    width: 100%;
    height: auto;
  }
  .button_edit {
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
  .online_state {
    position: absolute;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: row;
    align-items: center;
    border-radius: 5px;
    padding: 2px 4px;
    background: rgba(37, 211, 102, 0.1);
    color: #44ce4b;
    font-size: 0.8rem;
    p {
      margin: 0;
    }
  }
  .button_delete {
    background-color: #ffebee;
    color: #de1e27;
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
      background-color: #de1e27;
      color: #ffffff;
    }
  }
  .flex_cont {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .bot_cont{
    width: 100%;
    height: auto;
    display: flex;
    position: relative;
    justify-content: space-between;
    align-items: center;
    &_left {
      width: 80%;
      &_info {
        width: 100%;
        display: flex;
        justify-content: start;
        &_update {
          width: 100%;
          display: flex;
          flex-direction: column;
          color: #5d5d5d;
          margin-right: 10px;
          p{
            margin-bottom: 0;
            padding: 0;
            font-size: 1.2rem;
          }
        }
        &_socialmedia {
          display: flex;
          flex-direction: row;
          gap: 5px;
          &_img {
            border-radius: 2px;
            width: 17px;
            height: 17px;
            
          }
        }
      }
    }
    &_rigth {
      width: 20%;
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
  }
</style>
