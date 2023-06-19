import * as MutationHelpers from 'shared/helpers/vuex/mutationHelpers';
import types from '../mutation-types';
import WhatsAppAPI from '../../api/whatsapp';

export const state = {
  records: [],
  uiFlags: {
    isFetching: false,
    isCreating: false,
  },
};

export const getters = {};

export const actions = {
  createtemplate: async function createWhatsappTemplate({ commit }, payload) {
    commit(types.SET_WHATSAPP_TEMPLATE_UI_FLAG, { isFetching: true });
    try {
      const response = await WhatsAppAPI.createWhatsAppTemplate(payload);
      commit(types.ADD_WHATSAPP_TEMPLATE, response.data);
    } catch (error) {
      // Ignore error
    } finally {
      commit(types.SET_WHATSAPP_TEMPLATE_UI_FLAG, { isFetching: false });
    }
  },

  deletetemplate: async function deleteWhatsappTemplate({ commit }, payload) {
    commit(types.SET_WHATSAPP_TEMPLATE_UI_FLAG, { isFetching: true });
    try {
      const response = await WhatsAppAPI.deleteWhatsAppTemplate(
        payload.accountId,
        payload.templateName
      );
      commit(types.DELETE_WHATSAPP_TEMPLATE, response.data);
    } catch (error) {
      // Ignore error
    } finally {
      commit(types.SET_WHATSAPP_TEMPLATE_UI_FLAG, { isFetching: false });
    }
  },
};

export const mutations = {
  [types.SET_WHATSAPP_TEMPLATE_UI_FLAG](_state, data) {
    _state.uiFlags = {
      ..._state.uiFlags,
      ...data,
    };
  },
  [types.SET_WHATSAPP_TEMPLATE_ACCOUNTS]: MutationHelpers.set,
};

export default {
  namespaced: true,
  actions,
  state,
  getters,
  mutations,
};
