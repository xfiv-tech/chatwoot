import SettingsContent from '../Wrapper';
import Index from './Index.vue';
import { frontendURL } from '../../../../helper/URLHelper';

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
          roles: ['administrator', 'agent'],
        },
      ],
    },
  ],
};
