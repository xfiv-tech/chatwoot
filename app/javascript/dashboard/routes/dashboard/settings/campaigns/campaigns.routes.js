import Index from './Index';
import WhatsappBusiness from './Whatsapp';
import SettingsContent from '../Wrapper';
import { frontendURL } from '../../../../helper/URLHelper';

export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/campaigns'),
      component: SettingsContent,
      props: {
        headerTitle: 'CAMPAIGN.ONGOING.HEADER',
        icon: 'arrow-swap',
      },
      children: [
        {
          path: '',
          redirect: 'ongoing',
        },
        {
          path: 'ongoing',
          name: 'settings_account_campaigns',
          roles: ['administrator'],
          component: { ...Index },
        },
      ],
    },
    {
      path: frontendURL('accounts/:accountId/campaigns'),
      component: SettingsContent,
      props: {
        headerTitle: 'CAMPAIGN.ONE_OFF.HEADER',
        icon: 'sound-source',
      },
      children: [
        {
          path: 'one_off',
          name: 'one_off',
          roles: ['administrator'],
          component: { ...Index },
        },
      ],
    },
    {
      path: frontendURL('accounts/:accountId/campaigns'),
      component: SettingsContent,
      props: {
        headerTitle: 'CAMPAIGN.WHATSAPP_BUSINESS.HEADER',
        icon: 'brand-whatsapp',
      },
      children: [
        {
          path: 'wbusiness',
          name: 'wbusiness',
          roles: ['administrator'],
          component: { ...WhatsappBusiness },
        },
      ],
    },
    {
      path: frontendURL('accounts/:accountId/campaigns'),
      component: SettingsContent,
      props: {
        headerTitle: 'CAMPAIGN.WHATSAPP_BUSINESS.HEADER',
        icon: 'settings',
      },
      children: [
        {
          path: 'wprofiles',
          name: 'wprofiles',
          roles: ['administrator'],
          component: { ...WhatsappBusiness },
        },
      ],
    },
  ],
};
