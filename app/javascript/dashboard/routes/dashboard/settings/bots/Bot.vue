<template>
<div class="card">
    <div class="row">
      <div class="small-12 columns bot_cont">
        <div class="bot_cont_left">
          <div class="bot_cont_left_input">
            <div>
                <input
                class="input_style"
                v-if="editName"
                v-model.trim="bot.name"
                type="text"
                placeholder="Nombre"
                />
                <h5 v-else>{{ bot.name }}</h5>
            </div>
            <div class="bot_cont_left_input_icons">
                <div class="bot_cont_left_input_icons_icon" v-if="!editName" @click="showInputEdit">
                    <IconEdit />
                </div>
                <div class="bot_cont_left_input_icons_icon" v-if="editName" @click="updateBot(bot, 'name')">
                    <IconCheck />
                </div>
                <div class="bot_cont_left_input_icons_icon" v-if="editName" @click="cancelEdit">
                    <IconCancel />
                </div>
            </div>
          </div>
          <div class="bot_cont_left_info">
            <div class="bot_cont_left_info_update">
                <div>
                    <p><strong> {{$t('LIST_BOTS_OPTIONS.CHANNEL')}}</strong></p>
                    <p>{{'Webchat - ' + bot.channels}}</p>
                </div>
                <div>
                    <p><strong> {{$t('LIST_BOTS_OPTIONS.PHONENUMBER')}}</strong></p>
                    <p>{{bot.phoneNumber}}</p>
                </div>
            </div>
            <div class="cont bot_cont_left_info_socialmedia" >
              <div v-if="bot.publishedTypebot !== null" class="online_state" @click="updateBot(bot, 'publishedTypebot')">
                <p>{{$t('LIST_BOTS_OPTIONS.ONLINE_STATE')}}</p>
              </div>
            </div>
          </div>
        </div>
        <div class="bot_cont_rigth">
          <div
            class="button_edit"
            @click="$emit('goEditbot',bot)"
          >
            <p>{{$t('LIST_BOTS_OPTIONS.BUTTON_EDIT')}}</p>
          </div>
          <div
            class="button_edit"
            @click="$emit('cloneBot',bot)"
          >
            <p>{{$t('LIST_BOTS_OPTIONS.BUTTON_CLONE')}}</p>
          </div>
          <div
            class="button_delete"
            @click="$emit('deleteBot',bot)"
          >
            <p>{{$t('LIST_BOTS_OPTIONS.BUTTON_DROP')}}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

import AddBotModal from './AddBotModal.vue';
import Bot from './Bot.vue';
import Spinner from '../../../../../shared/components/Spinner.vue';
import IconCancel from './icons/IconCancel.vue'
import IconCheck from './icons/IconCheck.vue'
import IconEdit from './icons/IconEdit.vue'
import { config } from '../../../../config/config'

export default {
  components: {
    Spinner,
    AddBotModal,
    Bot,
    IconCancel,
    IconCheck,
    IconEdit
  },
  props: {
    bot: {
      type: Object,
    },
    index: {
      type: Number,
    },
  },
  data() {
    return {
      editName: false,
      inputNameBot: "",
      isLoading: true,
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
          name: 'prueba',
          updatedAt: '',
          path_session: '',
          path_edit: '',
          publishedTypebot: 'online'
        }
      ],
    };
  },
  computed: {
    nameBot: {
      get(){
        return this.bot.name
      },
      set(newval){
        this.bot.name = newval
      }
    }
  },
  methods: {
    
    showInputEdit(){
        this.editName=true
    },
    cancelEdit(){
        this.editName=false
        this.bot.name = this.inputNameBot
    },
    async updateBot(bot, name) {
        const newbot = {
            ...bot,
            name: this.nameBot
        }
        this.$emit('updateBot', bot, name)
        this.editName=false
    }
  },
  mounted() {
    this.inputNameBot = this.bot.name
  }
};
</script>
<style scoped lang="scss">
@import '~dashboard/assets/scss/woot';
  .mr{
    margin-left: 20px;
    margin-bottom: 20px;
  }
  .input_style {
    width: 15rem;
    height: auto;
    margin-bottom: 0;
  }
  .spinner {
    margin-top: var(--space-normal);
    margin-bottom: var(--space-normal);
  }
  .loader {
    width: 100%;
    height: auto;
    align-items: center;
    display: flex;
    font-size: var(--font-size-default);
    justify-content: center;
    padding: var(--space-large);
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
    height: 30px;
    display: flex;
    flex-direction: row;
    align-items: center;
    border-radius: 7px;
    padding: 2px 10px;
    background: rgba(37, 211, 102, 0.1);
    color: #44ce4b;
    cursor: pointer;
    font-size: 0.7rem;
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
      &_input {
        display: flex;
        align-items: center;
        gap: 10px;
        &_icons {
            display: flex;
            align-items: center;
            gap: 5px;
            &_icon {
                cursor: pointer;
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
