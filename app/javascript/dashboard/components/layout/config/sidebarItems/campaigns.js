import { frontendURL } from '../../../../helper/URLHelper';

const campaigns = accountId => ({
  parentNav: 'campaigns',
  routes: ['settings_account_campaigns', 'one_off', 'wbusiness', 'wprofiles'],
  menuItems: [
    {
      icon: 'arrow-swap',
      label: 'ONGOING',
      key: 'ongoingCampaigns',
      hasSubMenu: false,
      toState: frontendURL(`accounts/${accountId}/campaigns/ongoing`),
      toStateName: 'settings_account_campaigns',
    },
    {
      key: 'oneOffCampaigns',
      icon: 'sound-source',
      label: 'ONE_OFF',
      hasSubMenu: false,
      toState: frontendURL(`accounts/${accountId}/campaigns/one_off`),
      toStateName: 'one_off',
    },
    {
      key: 'whatsappBusiness',
      icon: 'brand-whatsapp',
      label: 'WHATSAPP_BUSINESS',
      hasSubMenu: false,
      toState: frontendURL(`accounts/${accountId}/campaigns/wbusiness`),
      toStateName: 'wbusiness',
    },
    {
      key: 'whatsappProfiles',
      icon: 'settings',
      label: 'WHATSAPP_PROFILES',
      hasSubMenu: false,
      toState: frontendURL(`accounts/${accountId}/campaigns/wprofiles`),
      toStateName: 'wprofiles',
    },
  ],
});

export default campaigns;
