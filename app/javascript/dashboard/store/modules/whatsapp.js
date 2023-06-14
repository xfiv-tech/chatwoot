import * as MutationHelpers from 'shared/helpers/vuex/mutationHelpers';
import types from '../mutation-types';
import AccountAPI from '../../api/account';

export const state = {
  records: [],
  uiFlags: {
    isFetching: false,
    isCreating: false,
  },
};

export const getters = {
  whatsappaccounts($state) {
    return $state.records;
  },
};

export const actions = {
  get: async function getWhatsaAccounts({ commit }) {
    commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: true });
    try {
      const response = await AccountAPI.getWhatsappAccounts();
      commit(types.SET_WHATSAPP_ACCOUNTS, response.data);
    } catch (error) {
      // Ignore error
    } finally {
      commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: false });
    }
  },
  updateprofile: async function updateBusinessProfile({ commit }, payload) {
    commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: true });
    try {
      const response = await AccountAPI.updateBusinessProfile(
        payload.id,
        payload.data
      );
      commit(types.EDIT_WHATSAPP, response.data);
    } catch (error) {
      // Ignore error
    } finally {
      commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: false });
    }
  },
  updateprofileabout: async function updateProfileAbout({ commit }, payload) {
    commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: true });
    try {
      const response = await AccountAPI.updateProfileAbout(
        payload.id,
        payload.data
      );
      commit(types.EDIT_WHATSAPP, response.data);
    } catch (error) {
      // Ignore error
    } finally {
      commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: false });
    }
  },
  updateprofilephoto: async function updateProfilePhoto({ commit }, payload) {
    commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: true });
    try {
      const response = await AccountAPI.updateProfilePhoto(
        payload.id,
        payload.data
      );
      commit(types.EDIT_WHATSAPP, response.data);
    } catch (error) {
      // Ignore error
    } finally {
      commit(types.SET_WHATSAPP_UI_FLAG, { isFetching: false });
    }
  },
};

export const mutations = {
  [types.SET_WHATSAPP_UI_FLAG](_state, data) {
    _state.uiFlags = {
      ..._state.uiFlags,
      ...data,
    };
  },
  [types.SET_WHATSAPP_ACCOUNTS]: MutationHelpers.set,
};

export default {
  namespaced: true,
  actions,
  state,
  getters,
  mutations,
};
