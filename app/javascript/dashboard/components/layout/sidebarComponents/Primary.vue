<template>
  <div class="primary--sidebar">
    <logo
      :source="'https://xfiv-content.s3.amazonaws.com/xfiv-content/external-images/share_dir/Xfiv/20230519/Xfiv.jpeg'"
      :name="installationName"
      :account-id="accountId"
    />
    <nav class="menu vertical">
      <primary-nav-item
        v-for="menuItem in menuItems"
        :key="menuItem.toState"
        :icon="menuItem.icon"
        :name="menuItem.label"
        :to="menuItem.toState"
        :is-child-menu-active="menuItem.key === activeMenuItem"
      />
    </nav>
    <div class="menu vertical user-menu">
      <!-- <primary-nav-item
        v-if="!isACustomBrandedInstance"
        icon="book-open-globe"
        name="DOCS"
        :open-in-new-page="true"
        :to="helpDocsURL"
      /> -->
      <notification-bell @open-notification-panel="openNotificationPanel" />
      <agent-details @toggle-menu="toggleOptions" />
      <options-menu
        :show="showOptionsMenu"
        @toggle-accounts="toggleAccountModal"
        @show-support-chat-window="toggleSupportChatWindow"
        @key-shortcut-modal="$emit('key-shortcut-modal')"
        @close="toggleOptions"
      />
    </div>
  </div>
</template>
<script>
import Logo from './Logo';
import PrimaryNavItem from './PrimaryNavItem';
import OptionsMenu from './OptionsMenu';
import AgentDetails from './AgentDetails';
import NotificationBell from './NotificationBell';
import wootConstants from 'dashboard/constants/globals';
import { frontendURL } from 'dashboard/helper/URLHelper';

export default {
  components: {
    Logo,
    PrimaryNavItem,
    OptionsMenu,
    AgentDetails,
    NotificationBell,
  },
  props: {
    isACustomBrandedInstance: {
      type: Boolean,
      default: false,
    },
    logoSource: {
      type: String,
      default: '',
    },
    installationName: {
      type: String,
      default: '',
    },
    accountId: {
      type: Number,
      default: 0,
    },
    menuItems: {
      type: Array,
      default: () => [],
    },
    activeMenuItem: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      helpDocsURL: wootConstants.DOCS_URL,
      showOptionsMenu: false,
    };
  },
  methods: {
    frontendURL,
    toggleOptions() {
      this.showOptionsMenu = !this.showOptionsMenu;
    },
    toggleAccountModal() {
      this.$emit('toggle-accounts');
    },
    toggleSupportChatWindow() {
      window.$chatwoot.toggle();
    },
    openNotificationPanel() {
      this.$emit('open-notification-panel');
    },
  },
};
</script>
<style lang="scss" scoped>
.primary--sidebar {
  display: flex;
  flex-direction: column;
  width: var(--space-jumbo);
  border-right: 1px solid var(--s-50);
  box-sizing: content-box;
  height: 100%;
  flex-shrink: 0;
}

.menu {
  align-items: center;
  margin-top: var(--space-medium);
}

.user-menu {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  justify-content: flex-end;
  margin-bottom: var(--space-normal);
}
</style>
