<template>
  <div class="column content-box">
    <woot-button
      color-scheme="success"
      class-names="button--fixed-top"
      icon="add-circle"
      @click="openAddPopup()"
    >
      NUEVO BOT
    </woot-button>

    <!-- List Agents -->
    <div class="row">
      <div class="small-5 mr columns with-right-space" v-for="bot in bots" :key="bot.id">
        <div class="card">
          <div class="row">
            <div class="small-12 columns">
              <h5>{{ bots.name }}</h5>
              <!-- DROPDAWN -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Add Agent -->
    <woot-modal :show.sync="showAddPopup" :on-close="hideAddPopup">

    </woot-modal>
    <!-- Edit Agent -->
    <woot-modal :show.sync="showEditPopup" :on-close="hideEditPopup">

    </woot-modal>

    <!-- Delete Agent -->
    <woot-modal :show.sync="showEditPopup" :on-close="hideEditPopup">

    </woot-modal>
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import globalConfigMixin from 'shared/mixins/globalConfigMixin';

export default {
  components: {

  },
  mixins: [globalConfigMixin],
  data() {
    return {
      loading: {},
      showAddPopup: false,
      showDeletePopup: false,
      showEditPopup: false,
      idUser:1,
      createdBot: true,
      bots:[],
    };
  },
  computed: {
    ...mapGetters({
      accountId: 'getCurrentAccountId',
      agentBots: 'agentBots/getBots',
      uiFlags: 'agentBots/getUIFlags',
    }),
  },
  mounted() {
    // this.$store.dispatch('agents/get');
    this.obtenerId();
  },
  methods: {

    obtenerId(){
      let url = windows.location.href;
      let array = url.split('/');
      this.idUser = array[4];
    },
    // Edit Function
    openAddPopup() {
      this.showAddPopup = true;
    },
    hideAddPopup() {
      this.showAddPopup = false;
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
};
</script>
<style scoped>
.mr{
  margin-left: 20px;
  margin-bottom: 20px;
}
</style>
