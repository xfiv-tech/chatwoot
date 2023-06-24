import SettingsContent from '../Wrapper';
import Index from './Index.vue';
import { frontendURL } from '../../../../helper/URLHelper';
import CreateStepWrap from './Create/Index';
import CreateBot from './Create/CreateBot';
import AddTeams from './Create/AddTeams';
import FinishSetup from './Create/FinishSetup';


export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/settings/bots'),
      component: SettingsContent,
      props: {
        headerTitle: 'GENERAL_SETTINGS.BOT_TITLE',
        icon: 'briefcase',
        showNewButton: false,
      },
      children: [
        {
          path: '',
          name: 'botTypebot',
          component: Index,
          roles: ['administrator'],
        },
        {
          path: 'new',
          component: CreateStepWrap,
          children: [
            {
              path: '',
              name: 'settings_bot_new',
              component: CreateBot,
              roles: ['administrator'],
            },
            {
              path: ':bot/finish',
              name: 'settings_bot_finish',
              component: FinishSetup,
              roles: ['administrator'],
            },
            {
              path: ':bot/teams',
              name: 'settings_bot_add_teams',
              roles: ['administrator'],
              component: AddTeams,
            },
          ],
        },
      ],
    },
  ],
};
