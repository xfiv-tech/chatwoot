/* global axios */
import ApiClient from './ApiClient';

class WhatsAppAPI extends ApiClient {
  constructor() {
    super('', { accountScoped: true });
  }

  createWhatsAppTemplate(payload) {
    return axios.post(
      `${this.url}/whatsapp_business/${payload.accountId}/templates`,
      payload.data
    );
  }

  getWhatsAppBusinessTemplates() {
    return axios.get(`${this.url}whatsapp_business`);
  }

  syncWhatsAppTemplates(accountId) {
    return axios.get(
      `${this.url}whatsapp_business/${accountId}/sync_templates`
    );
  }

  deleteWhatsAppTemplate(businessAccountId, templateName) {
    return axios.delete(
      `${this.url}whatsapp_business/${businessAccountId}/templates/${templateName}`
    );
  }

  updateProfileAbout(accountId, body) {
    return axios.put(
      `${this.url}whatsapp_business/${accountId}/update_profile_about`,
      body
    );
  }

  uploadTemplateResource(body) {
    return axios.post(`${this.url}whatsapp_business/s3_upload`, body);
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

export default new WhatsAppAPI();
