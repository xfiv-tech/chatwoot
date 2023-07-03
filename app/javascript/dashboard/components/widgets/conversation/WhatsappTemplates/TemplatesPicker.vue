<template>
  <div class="medium-12 columns">
    <!-- <div  class="medium-12 columns">
      <label :class="{ error: $v.selectedInboxId.$error }">
        {{ $t('WHATSAPP_TEMPLATES.PICKER.IMBOX_TEMPLATES.LABEL') }}
        <select placeholder="Select Inbox" :style="{padding: '5px 10px'}" @change="selectInbox" v-model="selectedInboxId">
          <option v-for="inbox in listInbox" :key="inbox.id" :value="inbox.id">
            <p>{{ inbox.name }}</p>
          </option>
        </select>
        <span v-if="$v.selectedInboxId.$error" class="message">
          {{ $t('WHATSAPP_TEMPLATES.PICKER.IMBOX_TEMPLATES.ERROR') }}
        </span>
      </label>
    </div> -->
    <div class="templates__list-search">
      <fluent-icon icon="search" class="search-icon" size="16" />
      <input
        ref="search"
        v-model="query"
        type="search"
        :placeholder="$t('WHATSAPP_TEMPLATES.PICKER.SEARCH_PLACEHOLDER')"
        class="templates__search-input"
      />
    </div>
    <div class="template__list-container">
      <div v-for="(template, i) in filteredTemplateMessages" :key="template.id">
        <button
          class="template__list-item"
          @click="$emit('onSelect', template)"
        >
          <div>
            <div class="flex-between">
              <p class="label-title">
                {{ template.name }}
              </p>
              <span class="label-lang label">
                {{ $t('WHATSAPP_TEMPLATES.PICKER.LABELS.LANGUAGE') }} :
                {{ template.language }}
              </span>
            </div>
            <div>
              <p class="strong">
                {{ $t('WHATSAPP_TEMPLATES.PICKER.LABELS.TEMPLATE_BODY') }}
              </p>
              <p class="label-body">{{ getTemplatebody(template) }}</p>
            </div>
            <div class="label-category">
              <p class="strong">
                {{ $t('WHATSAPP_TEMPLATES.PICKER.LABELS.CATEGORY') }}
              </p>
              <p>{{ template.category }}</p>
            </div>
          </div>
        </button>
        <hr v-if="i != filteredTemplateMessages.length - 1" :key="`hr-${i}`" />
      </div>
      <div v-if="!filteredTemplateMessages.length">
        <p>
          {{ $t('WHATSAPP_TEMPLATES.PICKER.NO_TEMPLATES_FOUND') }}
          <strong>{{ query }}</strong>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import inboxes from '../../../../api/inboxes';
import { config } from '../../../../config/config'
import { required, minLength } from 'vuelidate/lib/validators';

// TODO: Remove this when we support all formats
const formatsToRemove = ['DOCUMENT', 'IMAGE', 'VIDEO'];

export default {
  props: {
    inboxId: {
      type: Number,
      default: undefined,
    },
  },
  data() {
    return {
      query: '',
      listAllTemplates: [],
      idInbox: 1,
      listInbox: [],
      inboxSelected: {},
      selectedInboxId: 0,
      idAccount: 0,
    };
  },
  validations: {
    selectedInboxId: {
      required,
      minLength: minLength(1),
    },
  },
  computed: {
    async whatsAppTemplateMessages() {
      // TODO: Remove the last filter when we support all formats
      return this.$store.getters['inboxes/getWhatsAppTemplates'](this.inboxId)
        .filter(template => template.status.toLowerCase() === 'approved')
        .filter(template => {
          return template.components.every(component => {
            return !formatsToRemove.includes(component.format);
          });
        });
    },
    filteredTemplateMessages() {
      return  this.listAllTemplates.length > 0 && this.listAllTemplates.filter(template =>
        template.name.toLowerCase().includes(this.query.toLowerCase())
      );
    },
  },
  methods: {
    //Trae la lista de los templates desde el endpoint
    async getAllWhatsappTemplates(){
      const listTemplates = await axios.get(config.ENDPOINT_BACKEND + 'accessconfig/info/account_plantillas/'+this.idAccount)
      const filtertemplates = listTemplates.data.data?.filter(template => template.status.toLowerCase() === 'approved')
        .filter(template => {
          return template.components.every(component => {
            return !formatsToRemove.includes(component.format);
          });
        });
      this.listAllTemplates = filtertemplates
    },
    selectInbox(e){
      this.$emit('change-inbox', e.target.value);
      this.idInbox = e.target.value
      this.getAllTemplatesByInbox(e.target.value)
    },
    async getAllTemplatesByInbox(id){
      const listTemplates = await axios({
        method: 'get',
        headers: { 
          'api-info-xfiv': config.api_token
        },
        url: config.ENDPOINT_BACKEND + `accessconfig/api/v1/internal/account_plantillas/${this.idAccount}?inbox_id=${id}`,
      })
      const filtertemplates = listTemplates.data.data?.filter(template => template.status.toLowerCase() === 'approved')
      
      const filterdelfilter = filtertemplates.filter(template => {
        return template.components.every(component => {
          return !formatsToRemove.includes(component.format);
        });
      });
      this.listAllTemplates = filtertemplates
    },
    async getAllInbox(){
      const listInbox = await axios.get(config.ENDPOINT_BACKEND +`accessconfig/api/v1/inbox/${this.idAccount}`)
      this.listInbox = listInbox.data.data
    },
    getTemplatebody(template) {
      return template.components.find(component => component.type === 'BODY')
        .text;
    },
  },
  created(){
    this.idAccount = this.$route.params.accountId
    this.getAllInbox()
    this.getAllTemplatesByInbox(this.inboxId)
  }
};
</script>

<style scoped lang="scss">
.list_inbox{
  width: 100%;
  height: auto;
  display: flex;
  border-radius: 5px;
  justify-content: space-between;
  scrollbar-width: 0;
  overflow: auto;
  &_name {
    padding: 5px 10px;
    margin: 0 4px;
    border: .5px solid #007EF3;
  }
}
.active {
    padding: 5px 10px;
    margin: 0 4px;
    background-color: #b1d6f8;
  }
.flex-between {
  display: flex;
  justify-content: space-between;
  margin-bottom: var(--space-one);
}

.templates__list-search {
  align-items: center;
  background-color: var(--s-25);
  border-radius: var(--border-radius-medium);
  border: 1px solid var(--s-100);
  display: flex;
  margin-bottom: var(--space-one);
  padding: 0 var(--space-one);
  margin-top: 20px;
  .search-icon {
    color: var(--s-400);
  }

  .templates__search-input {
    background-color: transparent;
    border: var(--space-large);
    font-size: var(--font-size-mini);
    height: unset;
    margin: var(--space-zero);
  }
}
.template__list-container {
  background-color: var(--s-25);
  border-radius: var(--border-radius-medium);
  max-height: 30rem;
  overflow-y: auto;
  padding: var(--space-one);

  .template__list-item {
    border-radius: var(--border-radius-medium);
    cursor: pointer;
    display: block;
    padding: var(--space-one);
    text-align: left;
    width: 100%;

    &:hover {
      background-color: var(--w-50);
    }

    .label-title {
      font-size: var(--font-size-small);
    }

    .label-category {
      margin-top: var(--space-two);

      span {
        font-size: var(--font-size-small);
        font-weight: var(--font-weight-bold);
      }
    }

    .label-body {
      font-family: monospace;
    }
  }
}

.strong {
  font-size: var(--font-size-mini);
  font-weight: var(--font-weight-bold);
}

hr {
  border-bottom: 1px solid var(--s-100);
  margin: var(--space-one) auto;
  max-width: 95%;
}
</style>
