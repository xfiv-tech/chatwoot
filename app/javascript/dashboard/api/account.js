/* global axios */
import ApiClient from './ApiClient';

class AccountAPI extends ApiClient {
  constructor() {
    super('', { accountScoped: true });
  }

  createAccount(data) {
    return axios.post(`${this.apiVersion}/accounts`, data);
  }

  getWhatsappAccounts() {
    return axios.get(`${this.url}whatsapp_business`);
  }

  getWhatsappAccountById(accountId) {
    return axios.get(`${this.url}whatsapp_business/${accountId}`);
  }

  updateBusinessProfile(accountId, body) {
    return axios.put(
      `${this.url}whatsapp_business/${accountId}/update_business_profile`,
      body
    );
  }

  updateProfileAbout(accountId, body) {
    return axios.put(
      `${this.url}whatsapp_business/${accountId}/update_profile_about`,
      body
    );
  }

  updateProfilePhoto(accountId, body) {
    return axios.put(
      `${this.url}whatsapp_business/${accountId}/update_profile_photo`,
      body
    );
  }

  attachment(data) {
    return axios.post(
      `${this.apiVersion}/accounts/${data.id}/upload_logo`,
      data.file,
      {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      }
    );
  }
}

export default new AccountAPI();
