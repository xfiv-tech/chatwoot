<template>
  <div class="wizard-body small-9 columns">
    <page-header
      :header-title="$t('AGENT_BOTS.CREATE_FLOW.CREATE.TITLE')"
      :header-content="$t('AGENT_BOTS.CREATE_FLOW.CREATE.DESC')"
    />
    <div class="row channels">
      <bot-form
        :on-submit="createTeam"
        :submit-in-progress="false"
        :submit-button-text="$t('AGENT_BOTS.FORM.SUBMIT_CREATE')"
      />
    </div>
  </div>
</template>

<script>
import BotForm from '../BotForm.vue';
import router from '../../../../index';
import PageHeader from '../../SettingsSubPageHeader';
import alertMixin from 'shared/mixins/alertMixin';

export default {
  components: {
    BotForm,
    PageHeader,
  },
  mixins: [alertMixin],
  data() {
    return {
      enabledFeatures: {},
    };
  },
  methods: {
    async createTeam(data) {
      try {
        const team = await this.$store.dispatch('teams/create', {
          ...data,
        });

        router.replace({
          name: 'settings_teams_add_agents',
          params: {
            page: 'new',
            teamId: team.id,
          },
        });
      } catch (error) {
        this.showAlert(this.$t('TEAMS_SETTINGS.TEAM_FORM.ERROR_MESSAGE'));
      }
    },
  },
};
</script>
