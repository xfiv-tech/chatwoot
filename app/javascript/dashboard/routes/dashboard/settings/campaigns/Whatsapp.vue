<template>
  <div class="column content-box">
    <div class="grid grid-cols-5 border-b-2 border-gray-500 p-3">
      <div class="col-span-1">
        <p class="text-2xl">{{ $t('WHATSAPP_ACCOUNT.TITLE.USER_ACCOUNT') }}</p>
      </div>
      <div class="col-span-3" />
      <div class="col-span-1">
        <p class="text-2xl mr-5">{{ $t('WHATSAPP_ACCOUNT.TITLE.STATE') }}</p>
      </div>
    </div>
    <div v-if="!viewaccount">
      <div
        v-for="ac in accounts"
        :key="ac.id"
        class="mt-5 rounded-lg bg-dash"
        @click.stop="openaccount(ac.id)"
      >
        <div class="grid grid-cols-5 p-4 mb-2">
          <div class="col-span-1">
            <p class="text-1xl">{{ ac.phone_number }}</p>
            <p class="text-xl">Xfiv Omnichanel</p>
          </div>
          <div class="col-span-3" />
          <div class="col-span-1 flex flex-col-reverse">
            <div class="flex justify-start gap-4 flex-wrap content-center">
              <span>
                <p>
                  {{ $t('WHATSAPP_ACCOUNT.STATUS.CONNECTED') }}
                </p>
              </span>
              <fluent-icon
                class="text-yellow-600 mt-1"
                size="15"
                icon="circle"
              />
              <fluent-icon class="text-black mt-2 " icon="caret-up" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <div v-else class="mt-5 p-5 pb-32 rounded-lg bg-dash ">
      <div
        v-if="whatccount == null"
        class="flex justify-center align-middle py-16"
      >
        <p type="button" class="text-woot-500" disabled>
          {{ $t('WHATSAPP_ACCOUNT.LOADER.PLEASE_WAIT') }}
        </p>
      </div>
      <div v-else>
        <div
          class="grid grid-cols-5 border-b-2 border-gray-500 pb-2 mb-2"
          @click="viewaccount = !viewaccount"
        >
          <div class="col-span-1">
            <p class="text-xl">573225381516</p>
            <p class="text-xl">Xfiv Omnichanel</p>
          </div>
          <div class="col-span-3" />
          <div class="col-span-1 flex flex-col-reverse">
            <div class="flex justify-start  gap-4 content-center">
              <p>{{ $t('WHATSAPP_ACCOUNT.STATUS.CONNECTED') }}</p>
              <fluent-icon
                class="text-green-600 mt-1"
                size="15"
                icon="circle"
              />
              <fluent-icon class="text-black " size="18" icon="caret-down" />
            </div>
          </div>
        </div>
        <div class="bg-white rounded-lg mt-4">
          <div class="mb-0 border-b border-gray-400 dark:border-gray-700">
            <ul
              id="myTab"
              class="flex flex-wrap -mb-px text-sm font-medium text-center"
              data-tabs-toggle="#myTabContent"
              role="tablist"
            >
              <li
                v-for="(tab, i) in wtabs"
                :key="tab"
                :class="
                  wtab == i
                    ? 'mr-2 border-b-2 border-opacity-0 hover:border-opacity-100 hover:border-woot-500 border-home active:border-wtoo-500 active:border-opacity-100'
                    : ''
                "
                role="presentation"
                @click="opentab(i)"
              >
                <p
                  id="profile-tab"
                  class="inline-block pt-8 px-10 pb-2  text-gray-700 hover:text-woot-600 dark:text-woot-500 dark:hover:text-blue-500 text-xl"
                  data-tabs-target="#profile"
                  role="tab"
                  aria-controls="profile"
                  aria-selected="true"
                >
                  {{ $t('WHATSAPP_ACCOUNT.TITLE.' + tab) }}
                </p>
              </li>
            </ul>
          </div>
          <div v-if="wtab == 0">
            <div class="flex flex-col-reverse lg:grid lg:grid-cols-12 gap-4">
              <div class="lg:col-span-9 border-r-2 p-8 border-gray-300">
                <div
                  class="flex flex-col md:grid md:grid-cols-12 justify-between"
                >
                  <div
                    class="col-span-4 flex justify-center md:justify-start mb-10 md:mb-0"
                  >
                    <div class="grid justify-between content-center">
                      <div class="flex justify-center">
                        <p class="font-bold">
                          {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.PROFILE_IMAGE') }}
                        </p>
                      </div>
                      <div
                        class="flex py-4 justify-center content-center align-middle"
                      >
                        <div class="border p-3">
                          <img
                            class="w-96 h-96 h-auto"
                            :src="`${whatccount.profile_photo_link}`"
                          />
                        </div>
                      </div>
                      <div
                        class="flex justify-center content-center align-middle"
                      >
                        <button
                          v-if="!selectfile"
                          type="button"
                          class="bg-woot-500 px-8 py-2 text-white font-bold rounded-lg mt-2 cursor-pointer"
                          @click="selectfile = !selectfile"
                        >
                          {{ $t('WHATSAPP_ACCOUNT.BUTTON.UPDATE_PHOTO') }}
                        </button>
                        <input
                          v-else
                          ref="upload"
                          type="file"
                          name="file-upload"
                          multiple=""
                          accept="image/jpeg, image/png"
                          @change="updateprofileimage"
                        />
                      </div>
                    </div>
                  </div>
                  <div class="col-span-8 justify-start">
                    <div class="justify-start content-start">
                      <div class="flex justify-start">
                        <p class="font-bold">
                          {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.ABOUT_TEXT') }}
                        </p>
                      </div>
                      <div class="grow flex w-full py-4">
                        <div class="grow w-full">
                          <textarea
                            id="message"
                            v-model="whatccount.about"
                            rows="6"
                            :disabled="!editabout"
                            :style="
                              editabout
                                ? 'background-color: white !important;'
                                : 'background-color: #FAFAFA !important; border: none !important; outline: none !important;'
                            "
                            class="focus:bg-white block p-4 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                            placeholder="Your message..."
                          />
                        </div>
                        <div @click="editabout = !editabout">
                          <fluent-icon icon="pencil" class="ml-4" />
                        </div>
                      </div>
                      <div class="flex align-middle">
                        <button
                          type="button"
                          class="bg-woot-500 px-8 py-2 text-white font-bold rounded-lg mt-2 cursor-pointer"
                          @click.stop="updateabout()"
                        >
                          {{ $t('WHATSAPP_ACCOUNT.BUTTON.UPDATE_ABOUT') }}
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <p class="text-xl font-bold mt-10 pb-4">
                  {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.INFORMATION') }}
                </p>
                <div
                  class="flex md:grid md:grid-cols-12 justify-between mt-2 pl-5 border-b pb-2 py-2 border-gray-300"
                >
                  <div class="col-span-4">
                    <p class="text-lg font-bold py-2">
                      {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.ADDRESS') }}
                    </p>
                  </div>
                  <div v-if="editadd" class="col-span-7">
                    <input
                      v-model="whatccount.address"
                      class="border border-woot-900 text-gray-700 text-lg rounded-lg px-4 py-2 focus:ring-wtoo-500 focus:border-wtoo-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    />
                  </div>
                  <div v-else class="col-span-7">
                    <p class="py-2 content-start">{{ whatccount.address }}</p>
                  </div>
                  <div
                    class="invisible md:visible flex justify-end"
                    @click="editadd = !editadd"
                  >
                    <fluent-icon icon="pencil" />
                  </div>
                </div>
                <div
                  class="flex md:grid md:grid-cols-12 justify-between mt-2 pl-5 border-b pb-2 py-2 border-gray-300"
                >
                  <div class="col-span-4">
                    <p class="text-lg font-bold py-2">
                      {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.DESCRIPTION') }}
                    </p>
                  </div>
                  <div v-if="editdesc" class="col-span-7">
                    <input
                      v-model="whatccount.description"
                      class="border border-woot-900 text-gray-700 text-lg rounded-lg px-4 py-2 focus:ring-wtoo-500 focus:border-wtoo-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    />
                  </div>
                  <div v-else class="col-span-7">
                    <p class="py-2 content-start">
                      {{ whatccount.description }}
                    </p>
                  </div>
                  <div
                    class="invisible md:visible flex justify-end"
                    @click="editdesc = !editdesc"
                  >
                    <fluent-icon icon="pencil" />
                  </div>
                </div>
                <div
                  class="flex md:grid md:grid-cols-12 justify-between mt-2 pl-5 border-b pb-2 py-2 border-gray-300"
                >
                  <div class="col-span-4">
                    <p class="text-lg font-bold py-2">
                      {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.EMAIL') }}
                    </p>
                  </div>
                  <div v-if="editemail" class="col-span-7">
                    <input
                      v-model="whatccount.email"
                      class="border border-woot-900 text-gray-700 text-lg rounded-lg px-4 py-2 focus:ring-wtoo-500 focus:border-wtoo-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    />
                  </div>
                  <div v-else class="col-span-7">
                    <p class="py-2 content-start">{{ whatccount.email }}</p>
                  </div>
                  <div
                    class="invisible md:visible flex justify-end"
                    @click="editemail = !editemail"
                  >
                    <fluent-icon icon="pencil" />
                  </div>
                </div>
                <div
                  class="flex md:grid md:grid-cols-12 justify-between mt-2 pl-5 border-b pb-2 py-2 border-gray-300"
                >
                  <div class="col-span-4">
                    <p class="text-lg font-bold py-2">
                      {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.WEBSITE') }}
                    </p>
                  </div>
                  <div v-if="editweb" class="col-span-7">
                    <input
                      v-model="whatccount.website"
                      class="border border-woot-900 text-gray-700 text-lg rounded-lg px-4 py-2 focus:ring-wtoo-500 focus:border-wtoo-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    />
                  </div>
                  <div v-else class="col-span-7">
                    <p
                      class="py-2 content-start text-woot-500 text-underline font-xs"
                    >
                      {{ whatccount.website }}
                    </p>
                  </div>
                  <div
                    class="invisible md:visible flex justify-end"
                    @click="editweb = !editweb"
                  >
                    <fluent-icon icon="pencil" />
                  </div>
                </div>
                <div
                  class="flex md:grid md:grid-cols-12 justify-between mt-2 pl-5 border-b pb-2 py-2 border-gray-300"
                >
                  <div class="col-span-4">
                    <p class="text-lg font-bold py-2">
                      {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.CATEGORY') }}
                    </p>
                  </div>
                  <div v-if="editcategoria" class="col-span-7">
                    <input
                      v-model="whatccount.vert"
                      class="border border-woot-900 text-gray-700 text-lg rounded-lg px-4 py-2 focus:ring-wtoo-500 focus:border-wtoo-500 block w-full dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    />
                  </div>
                  <div v-else class="col-span-7">
                    <p class="py-2 content-start">{{ whatccount.vertical }}</p>
                  </div>
                  <div
                    class="invisible md:visible flex justify-end"
                    @click="editcategoria = !editcategoria"
                  >
                    <fluent-icon icon="pencil" />
                  </div>
                </div>
              </div>
              <div class="lg:col-span-3 p-2 mt-4">
                <div class="flex lg:justify-start justify-center">
                  <p class="font-bold pb-4">
                    {{ $t('WHATSAPP_ACCOUNT.ACCOUNT.PREVIEW') }}
                  </p>
                </div>
                <div class="p-4 bg-nexto">
                  <div class="bg-white py-12">
                    <div
                      class="flex justify-center content-center align-middle"
                    >
                      <div class="rounded-full bg-woot-100">
                        <img
                          class="max-w-full h-auto"
                          :src="`${whatccount.profile_photo_link}`"
                        />
                      </div>
                    </div>
                    <div
                      class="flex justify-center mt-2 content-center align-middle"
                    >
                      <p class="font-medium">Intelnexo SA</p>
                    </div>
                  </div>
                  <div class="my-4 bg-white p-5">Intelnexo SA</div>
                  <div class="bg-white p-5">
                    <div class="flex justify-start">
                      <div>
                        <fluent-icon icon="store-front" />
                      </div>
                      <div class="col-span-10 px-4">
                        {{ whatccount.description }}
                      </div>
                    </div>
                    <div class="flex justify-start pt-5">
                      <div>
                        <fluent-icon icon="tag" />
                      </div>
                      <div class="col-span-10 pl-4">
                        {{ whatccount.vertical }}
                      </div>
                    </div>
                    <div class="flex justify-start pt-5">
                      <div>
                        <fluent-icon icon="marker" />
                      </div>
                      <div class="col-span-10 pl-4">
                        {{ whatccount.address }}
                      </div>
                    </div>
                    <div class="flex justify-start pt-5">
                      <div>
                        <fluent-icon icon="mail-filled" />
                      </div>
                      <div class="col-span-10 pl-4">
                        {{ whatccount.email }}
                      </div>
                    </div>
                    <div class="flex justify-start pt-5">
                      <div>
                        <fluent-icon icon="earth" />
                      </div>
                      <div class="col-span-10 pl-4">
                        <div
                          :href="whatccount.website"
                          target="_blank"
                          class="text-woot-500 font-xs"
                        >
                          {{ whatccount.website }}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="flex justify-end py-5 px-12">
              <div
                class="lg:w-auto w-full flex text-white text-lg font-bold rounded-lg bg-woot-500 px-10 py-3 justify-center align-middle content-center cursor-pointer"
                @click="updateprofile()"
              >
                <fluent-icon class="mr-5" icon="save" />
                <p class="pt-1">{{ $t('WHATSAPP_ACCOUNT.BUTTON.SAVE') }}</p>
              </div>
            </div>
          </div>
          <div v-if="wtab == 1" class="p-10">
            <w-template-tab
              :templates="templates"
              :account-id="accountId"
              @synctemplates="fetchTemplates(accountId)"
            />
          </div>
          <div v-if="wtab == 2" class="p-10">
            <div
              class="max-w-lg mx-auto mt-16 text-center rounded overflow-hidden shadow-lg p-10 bg-orange-300"
            >
              <h1 class="mb-4 text-3xl font-black">Under Development!</h1>
              <p class="text-lg leading-snug">
                If this looks nice, it means the Campaign page is under
                construction.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import AccountAPI from '../../../../api/account';
import WhatsappAPI from '../../../../api/whatsapp';
import WhatsappTemplateTab from './whatsapptabs/WTemplateTab.vue';
export default {
  components: {
    'w-template-tab': WhatsappTemplateTab,
  },
  data() {
    return {
      editdesc: false,
      editadd: false,
      editemail: false,
      editweb: false,
      editcategoria: false,
      editabout: false,
      templates: null,
      wtab: 0,
      accountId: null,
      viewaccount: false,
      whatccount: null,
      upload: null,
      selectfile: false,
      wtabs: ['WHATSAPP_PROFILE', 'TEMPLATES', 'CAMPAIGN'],
    };
  },
  computed: {
    ...mapGetters({
      accounts: 'whatsapp/whatsappaccounts',
    }),
  },
  mounted() {
    this.viewaccount = false;
    this.$store.dispatch('whatsapp/get');
  },
  created() {
    const route = this.$router.history.current.name;
    if (route === 'wprofiles') {
      this.wtab = 1;
    }
    if (this.accounts) {
      // this.openaccount(this.accounts[0].id);
    }
  },
  methods: {
    opentab(wtab) {
      this.wtab = wtab;
      if (wtab === 1) {
        this.fetchTemplates(this.accountId);
      }
    },
    updateprofile() {
      var payload = {
        id: this.whatccount.id,
        data: {
          address: this.whatccount.address,
          description: this.whatccount.description,
          email: this.whatccount.email,
          vertical: this.whatccount.vertical,
          websites: this.whatccount.websites,
        },
      };

      this.$store.dispatch('whatsapp/updateprofile', payload).then(() => {
        this.openaccount(this.whatccount.id);
      });
      this.editdesc = false;
      this.editadd = false;
      this.editemail = false;
      this.editweb = false;
      this.editcategoria = false;
      this.editabout = false;
    },
    updateabout() {
      var payload = {
        id: this.whatccount.id,
        data: {
          about: this.whatccount.about,
        },
      };

      this.$store.dispatch('whatsapp/updateprofileabout', payload).then(() => {
        this.openaccount(this.whatccount.id);
      });
    },
    updateprofileimage(event) {
      var formData = new FormData();
      formData.append('photo', event.target.files[0]);
      let payload = {
        id: this.whatccount.id,
        data: formData,
      };

      this.$store.dispatch('whatsapp/updateprofilephoto', payload).then(() => {
        this.openaccount(this.whatccount.id);
      });
    },
    async openaccount(accountId) {
      this.selectfile = false;
      this.viewaccount = true;
      this.accountId = accountId;
      const response = await AccountAPI.getWhatsappAccountById(accountId);

      if (response.status === 200) {
        this.whatccount = response.data;
        this.whatccount.website = response.data.websites[0];
        this.whatccount.websites = response.data.websites;
        this.whatccount.id = accountId;
      }
      if (this.wtab === 1) {
        this.fetchTemplates(accountId);
      }
    },
    async fetchTemplates(accountId) {
      const response = await WhatsappAPI.syncWhatsAppTemplates(accountId);

      if (response.status === 200) {
        this.templates = response.data;
      }
    },
  },
};
</script>
<style lang="css" scoped>
.divider {
  border-width: 40px !important;
  border-color: black !important;
}

.v-tab--active {
  color: #1174ff !important;
  text-decoration-color: #1174ff !important;
}

.account {
  background-color: #eaf0f6 !important;
  padding: 20px !important;
}

.title1 {
  position: absolute;

  font-family: 'Inter';
  font-style: normal;
  font-weight: 600;
  font-size: 16px;
  line-height: 22px;
}

.profile {
  background-color: #ffffff !important;
  margin-top: 50px;
  width: 66.37px;
  height: 76.96px !important;
}

.rowa {
  display: flex;
  justify-content: center;
  align-items: center;
}

.v-text-field {
  textarea {
    margin-top: 10px !important;
  }
}
</style>
