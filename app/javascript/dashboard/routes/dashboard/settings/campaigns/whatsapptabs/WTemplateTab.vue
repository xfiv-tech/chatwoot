<template>
  <div>
    <div
      v-if="dialog"
      tabindex="-1"
      aria-hidden="true"
      class="inset-0 bg-gray-500 bg-opacity-50 rounded-lg flex overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center p-4 w-full md:inset-0 h-modal md:h-full"
    >
      <div class="relative rounded-lg w-4/6 max-w-4/6 h-full md:h-auto">
        <!-- Modal content -->
        <div class="bg-white rounded-lg p-5">
          <w-dialog-component
            :account-id="accountId"
            @cancel="dialog = false"
            @synctemplates="closedialog"
          />
        </div>
      </div>
    </div>
    <div class="flex justify-between ">
      <div class="w-1/4">
        <label class="relative block w-full">
          <span class="sr-only">Search</span>
          <span class="absolute inset-y-0 right-0 flex items-center pr-2">
            <svg class="h-5 w-5 fill-gray-500" viewBox="0 0 20 20">
              <path
                d="M10 2.5a7.5 7.5 0 0 1 5.964 12.048l4.743 4.745a1 1 0 0 1-1.32 1.497l-.094-.083-4.745-4.743A7.5 7.5 0 1 1 10 2.5Zm0 2a5.5 5.5 0 1 0 0 11 5.5 5.5 0 0 0 0-11Z"
              />
            </svg>
          </span>
          <input
            v-model="search"
            class="block w-full min-w-full rounded-md border border-woot-300 bg-white pl-9 pr-3 shadow-sm placeholder:text-slate-400 focus:border-woot-500 focus:outline-none focus:ring-1 focus:ring-woot-500 sm:text-lg"
            placeholder="Search by name"
            type="text"
            name="search"
          />
        </label>
      </div>
      <div class="grid grid-cols-2 gap-1">
        <div class="flex justify-end content-center">
          <div
            class="lg:w-auto w-full h-12 py-6 flex text-white rounded-lg bg-woot-500 px-24 justify-center align-middle content-center"
            @click="$emit('synctemplates')"
          >
            <fluent-icon class="mr-5" icon="sync" />
            <p class="pt-1 font-medium">
              {{ $t('WHATSAPP_ACCOUNT.BUTTON.SYNC_TEMPLATES') }}
            </p>
          </div>
        </div>
        <div class="flex justify-center content-center ">
          <div
            class="lg:w-auto h-12 py-6 w-full flex text-white rounded-lg bg-woot-500 px-24  justify-center align-middle content-center"
            @click="dialog = !dialog"
          >
            <fluent-icon class="mr-5" icon="add" />
            <p class="pt-1 font-medium">
              {{ $t('WHATSAPP_ACCOUNT.BUTTON.ADD_TEMPLATE') }}
            </p>
          </div>
        </div>
      </div>
    </div>
    <div>
      <div class="relative overflow-x-auto sm:rounded-lg">
        <table
          class="w-full text-left text-sm text-gray-500 dark:text-gray-400 table-fixed "
        >
          <thead class="bg-gray-50 text-lg uppercase ">
            <tr>
              <th scope="col" class="py-3 px-6">
                <div class="flex items-center">
                  Name
                  <a>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="ml-1 h-3 w-3"
                      aria-hidden="true"
                      fill="currentColor"
                      viewBox="0 0 320 512"
                    >
                      <path
                        d="M27.66 224h264.7c24.6 0 36.89-29.78 19.54-47.12l-132.3-136.8c-5.406-5.406-12.47-8.107-19.53-8.107c-7.055 0-14.09 2.701-19.45 8.107L8.119 176.9C-9.229 194.2 3.055 224 27.66 224zM292.3 288H27.66c-24.6 0-36.89 29.77-19.54 47.12l132.5 136.8C145.9 477.3 152.1 480 160 480c7.053 0 14.12-2.703 19.53-8.109l132.3-136.8C329.2 317.8 316.9 288 292.3 288z"
                      />
                    </svg>
                  </a>
                </div>
              </th>
              <th scope="col" class="py-3 px-6">
                <div class="flex items-center">
                  Category
                  <a>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="ml-1 h-3 w-3"
                      aria-hidden="true"
                      fill="currentColor"
                      viewBox="0 0 320 512"
                    >
                      <path
                        d="M27.66 224h264.7c24.6 0 36.89-29.78 19.54-47.12l-132.3-136.8c-5.406-5.406-12.47-8.107-19.53-8.107c-7.055 0-14.09 2.701-19.45 8.107L8.119 176.9C-9.229 194.2 3.055 224 27.66 224zM292.3 288H27.66c-24.6 0-36.89 29.77-19.54 47.12l132.5 136.8C145.9 477.3 152.1 480 160 480c7.053 0 14.12-2.703 19.53-8.109l132.3-136.8C329.2 317.8 316.9 288 292.3 288z"
                      />
                    </svg>
                  </a>
                </div>
              </th>
              <th scope="col" class="py-3 px-6">
                Preview
              </th>
              <th scope="col" class="py-3 px-6">
                <div class="flex items-center justify-end">
                  Language
                  <a>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="ml-1 h-3 w-3"
                      aria-hidden="true"
                      fill="currentColor"
                      viewBox="0 0 320 512"
                    >
                      <path
                        d="M27.66 224h264.7c24.6 0 36.89-29.78 19.54-47.12l-132.3-136.8c-5.406-5.406-12.47-8.107-19.53-8.107c-7.055 0-14.09 2.701-19.45 8.107L8.119 176.9C-9.229 194.2 3.055 224 27.66 224zM292.3 288H27.66c-24.6 0-36.89 29.77-19.54 47.12l132.5 136.8C145.9 477.3 152.1 480 160 480c7.053 0 14.12-2.703 19.53-8.109l132.3-136.8C329.2 317.8 316.9 288 292.3 288z"
                      />
                    </svg>
                  </a>
                </div>
              </th>
              <th scope="col" class="py-3 px-6">
                <div class="grid grid-cols-3 gap-1" />
              </th>
            </tr>
          </thead>
          <tbody v-if="templates" class="px-5">
            <tr
              v-for="(t, i) in filteredItems"
              :key="i"
              class="text-gray-700 text-lg"
            >
              <td
                scope="row"
                class="py-4 px-6 rounded-l-2xl bg-dash border-t-4 border-b-4 mr-8  border-white"
              >
                {{ t.name }}
              </td>
              <td class="py-4 px-6 bg-dash border-t-4 border-b-4  border-white">
                {{ t.category }}
              </td>
              <td
                class="py-4 px-6  bg-dash border-t-4 border-b-4  border-white overflow-hidden truncate w-2"
              >
                {{ t.components[0].text }}
              </td>
              <td class="py-4 px-6 bg-dash border-t-4 border-b-4  border-white">
                <div class="flex content-center justify-end gap-2">
                  <span
                    class="rounded-xl border border-woot-500 text-sm p-2 mr-1 flex content-center"
                    :class="
                      t.language == 'es'
                        ? 'bg-woot-500 text-white'
                        : 'bg-woot-50 text-woot-500'
                    "
                  >
                    ES
                  </span>
                  <span
                    class="rounded-lg border border-woot-500 p-2 text-sm mr-1"
                    :class="
                      t.language == 'en_US'
                        ? 'bg-woot-500 text-white'
                        : 'bg-woot-50 text-woot-500'
                    "
                  >
                    ENG_US
                  </span>
                  <span
                    class="rounded-xl border  border-woot-500 text-sm  p-2 mr-1"
                    :class="
                      t.language == 'id'
                        ? 'bg-woot-500 text-white'
                        : 'bg-woot-50 text-woot-500'
                    "
                  >
                    ID
                  </span>
                  <span
                    class="rounded-lg border  border-woot-500 text-sm  p-2 "
                    :class="
                      t.language == 'pt_BR'
                        ? 'bg-woot-500 text-white'
                        : 'bg-woot-50 text-woot-500'
                    "
                  >
                    PT_BR
                  </span>
                </div>
              </td>
              <td
                class="py-4 px-6 text-right rounded-r-2xl bg-dash border-t-4 border-b-4 border-r-8 border-white"
              >
                <div class="flex content-center justify-end">
                  <div>
                    <svg
                      class="h-8 w-8 fill-current text-[#404040]"
                      viewBox="0 0 24 24"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M8.904 16.5h6.192C14.476 19.773 13.234 22 12 22c-1.197 0-2.4-2.094-3.038-5.204l-.058-.294h6.192-6.192Zm-5.838.001H7.37c.365 2.082.983 3.854 1.793 5.093a10.029 10.029 0 0 1-5.952-4.814l-.146-.279Zm13.563 0h4.305a10.028 10.028 0 0 1-6.097 5.093c.755-1.158 1.344-2.778 1.715-4.681l.076-.412h4.306-4.306Zm.302-6.5h4.87a10.055 10.055 0 0 1-.257 5H16.84a28.539 28.539 0 0 0 .13-4.344L16.93 10h4.87-4.87ZM2.198 10h4.87a28.211 28.211 0 0 0 .034 4.42l.057.58H2.456a10.047 10.047 0 0 1-.258-5Zm6.377 0h6.85a25.838 25.838 0 0 1-.037 4.425l-.062.575H8.674a25.979 25.979 0 0 1-.132-4.512L8.575 10h6.85-6.85Zm6.37-7.424-.109-.17A10.027 10.027 0 0 1 21.372 8.5H16.78c-.316-2.416-.956-4.492-1.837-5.923l-.108-.17.108.17Zm-5.903-.133.122-.037C8.283 3.757 7.628 5.736 7.28 8.06l-.061.44H2.628a10.028 10.028 0 0 1 6.414-6.057l.122-.037-.122.037ZM12 2.002c1.319 0 2.646 2.542 3.214 6.183l.047.315H8.739C9.28 4.691 10.643 2.002 12 2.002Z"
                      />
                    </svg>
                  </div>
                  <div>
                    <svg
                      class="h-8 w-8 fill-current text-[#404040]"
                      viewBox="0 0 24 24"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M5.503 4.627 5.5 6.75v10.504a3.25 3.25 0 0 0 3.25 3.25h8.616a2.251 2.251 0 0 1-2.122 1.5H8.75A4.75 4.75 0 0 1 4 17.254V6.75c0-.98.627-1.815 1.503-2.123ZM17.75 2A2.25 2.25 0 0 1 20 4.25v13a2.25 2.25 0 0 1-2.25 2.25h-9a2.25 2.25 0 0 1-2.25-2.25v-13A2.25 2.25 0 0 1 8.75 2h9Z"
                      />
                    </svg>
                  </div>
                  <div>
                    <svg
                      class="h-8 w-8 fill-current text-[#404040]"
                      viewBox="0 0 24 24"
                      xmlns="http://www.w3.org/2000/svg"
                      @click="deletemplate(t.name)"
                    >
                      <path
                        d="M9,3V4H4V6H5V19A2,2 0 0,0 7,21H17A2,2 0 0,0 19,19V6H20V4H15V3H9M7,6H17V19H7V6M9,8V17H11V8H9M13,8V17H15V8H13Z"
                      />
                    </svg>
                  </div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import WhatsappDialogComponent from './WTemplateDialog.vue';
export default {
  components: {
    'w-dialog-component': WhatsappDialogComponent,
  },
  props: {
    templates: {
      type: Array,
      default: () => [],
    },
    accountId: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      dialog: false,
      search: '',
    };
  },
  computed: {
    filteredItems() {
      return this.templates.filter(item => {
        return item.name.toLowerCase().indexOf(this.search.toLowerCase()) > -1;
      });
    },
  },
  methods: {
    deletemplate(name) {
      var payload = {
        accountId: this.accountId,
        templateName: name,
      };
      this.$store
        .dispatch('whatsapptemplates/deletetemplate', payload)
        .then(() => {
          this.$emit('synctemplates');
        });
    },
    closedialog() {
      this.dialog = false;
      this.$emit('synctemplates');
    },
  },
};
</script>
