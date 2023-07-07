<template>
  <div class="wizard-body small-9 columns">
    <page-header
      :header-title="$t('TEAMS_SETTINGS.CREATE_FLOW.CREATE.TITLE')"
      :header-content="$t('TEAMS_SETTINGS.CREATE_FLOW.CREATE.DESC')"
    />
    <div class="row channels">
      <team-form
        :on-submit="createTeam"
        :submit-in-progress="false"
        :submit-button-text="$t('TEAMS_SETTINGS.FORM.SUBMIT_CREATE')"
      />
    </div>
  </div>
</template>

<script>
import TeamForm from '../TeamForm';
import router from '../../../../index';
import PageHeader from '../../SettingsSubPageHeader';
import alertMixin from 'shared/mixins/alertMixin';
import { config } from '../../../../../config/config'

import axios from 'axios'

export default {
  components: {
    TeamForm,
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
        // const team = await this.$store.dispatch('teams/create', {
        //   ...data,
        // });
        const team = await axios({
          method: 'post',
          url: config.ENDPOINT_BACKEND + 'accessconfig/api/v1/crear_team/'+this.$route.params.accountId,
          data: {
            "team_name": data.name,
            "imbox_id": 0,
            "msg_transfer": "ha sido transferido " + data.name.toUpperCase()
          }
        })
        console.log(team)
        await axios.get(config.ENDPOINT_BACKEND + 'accessconfig/api/v1/async_teams/'+this.$route.params.accountId)

        router.replace({
          name: 'settings_teams_add_agents',
          params: {
            page: 'new',
            teamId: team.data.data.id,
          },
        });
      } catch (error) {
        this.showAlert(this.$t('TEAMS_SETTINGS.TEAM_FORM.ERROR_MESSAGE'));
      }
    },
  },
};
</script>
