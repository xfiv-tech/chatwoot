<template>
  <div class="p-6 bg-white">
    <div class="py-3 border-b border-gray-500 min-w-full">
      <span class="text-lg font-medium">
        {{ $t('WHATSAPP_TEMPLATES.LABEL.NEW_TEMPLATE') }}
      </span>
    </div>
    <div>
      <div class="grid grid-cols-12">
        <div
          id="journal-scroll"
          class="col-span-8 px-1 py-3 mt-4 w-full overflow-auto scrollbar:hidden"
          style="height: 500px"
        >
          <div class="my-6">
            <span class="text-lg font-medium pt-5">
              {{ $t('WHATSAPP_TEMPLATES.LABEL.INFORMATION_TEMPLATE') }}
            </span>
          </div>
          <div class="grid grid-cols-2 gap-4 pr-4 xs:grid-cols-1 w-full">
            <div>
              <label for="fname" class="text-sm text-gray-700">
                {{ $t('WHATSAPP_TEMPLATES.LABEL.NAME') }}
              </label>
              <input
                v-model="templatecomponent.name"
                class="border-b border-gray-500 w-full text-xl px-4 pb-4 pt-2 pl-0 lowercase"
                label="Name"
                placeholder="E.g simple_issue_resolution"
              />
            </div>
            <div>
              <label
                for="category"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400"
              >
                {{ $t('WHATSAPP_TEMPLATES.LABEL.CATEGORY') }}
              </label>
              <select
                id="categories"
                v-model="templatecomponent.category"
                class="bg-gray-50 border border-gray-300  text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 px-2"
              >
                <option
                  v-for="c in categories"
                  :key="c.value"
                  :value="c.value"
                  class="text-lg p-2"
                >
                  {{ c.title }}
                </option>
              </select>
            </div>
            <div>
              <label
                for="countries"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400"
              >
                {{ $t('WHATSAPP_TEMPLATES.LABEL.LANGUAGE') }}
              </label>
              <select
                id="languages"
                v-model="templatecomponent.language"
                class="appearance-none bg-gray-50 border text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 px-2"
              >
                <option
                  v-for="l in languages"
                  :key="l.value"
                  class="text-lg p-2"
                  :value="l.value"
                >
                  {{ l.title }}
                </option>
              </select>
            </div>
            <div>
              <label
                for="templates"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400"
              >
                {{ $t('WHATSAPP_TEMPLATES.LABEL.TEMPLATE') }}
              </label>
              <select
                id="templates"
                v-model="templatetype"
                class="bg-gray-50 border border-gray-300 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5  dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500 px-2"
                @change="templatechanged"
              >
                <option class="text-lg p-2" selected>
                  {{ $t('WHATSAPP_TEMPLATES.DROPDOWN.SELECT_TEMPLATE') }}
                </option>
                <option class="text-lg p-2" value="text">
                  {{ $t('WHATSAPP_TEMPLATES.DROPDOWN.ONLY_TEXT') }}
                </option>
                <option class="text-lg p-2" value="interactive">
                  {{ $t('WHATSAPP_TEMPLATES.DROPDOWN.INTERACTIVE') }}
                </option>
                >
              </select>
            </div>
            <div class="my-6">
              <span class="text-lg font-medium pt-5">
                {{ $t('WHATSAPP_TEMPLATES.LABEL.TEMPLATE_CONTENT') }}
              </span>
            </div>
            <div class="col-span-2">
              <label for="fcategory" class="text-sm text-gray-700">
                {{ $t('WHATSAPP_TEMPLATES.LABEL.BODY') }}
              </label>
              <textarea
                id="bodytextarea"
                v-model="bodycomponent.text"
                type="text"
                class="border-b border-gray-500 w-full text-xl font-medium px-4 pb-4 pt-6 pl-1"
                label="Body"
                :placeholder="placeholder"
              />
            </div>
            <div class="col-span-2 flex justify-end gap-3">
              <VEmojiPicker v-if="emojipicker" @select="emojiselected" />
              <svg
                class="filled-gray-700 rounded-lg border border-gray-600 h-8 w-9 p-1"
                viewBox="0 0 24 24"
                @click="emojipicker = !emojipicker"
              >
                <path
                  d="M12 1.999c5.524 0 10.002 4.478 10.002 10.002 0 5.523-4.478 10.001-10.002 10.001-5.524 0-10.002-4.478-10.002-10.001C1.998 6.477 6.476 1.999 12 1.999Zm0 1.5a8.502 8.502 0 1 0 0 17.003A8.502 8.502 0 0 0 12 3.5ZM8.462 14.784A4.491 4.491 0 0 0 12 16.502a4.492 4.492 0 0 0 3.535-1.714.75.75 0 1 1 1.177.93A5.991 5.991 0 0 1 12 18.002a5.991 5.991 0 0 1-4.716-2.29.75.75 0 0 1 1.178-.928ZM9 8.75a1.25 1.25 0 1 1 0 2.499A1.25 1.25 0 0 1 9 8.75Zm6 0a1.25 1.25 0 1 1 0 2.499 1.25 1.25 0 0 1 0-2.499Z"
                />
              </svg>
              <svg
                class="filled-gray-700 rounded-lg border border-gray-600 h-8 w-9 p-1"
                viewBox="0 0 24 24"
                @click="boldtext"
              >
                <path
                  d="M6.935 4.44A1.5 1.5 0 0 1 7.996 4h4.383C15.017 4 17 6.182 17 8.625a4.63 4.63 0 0 1-.865 2.682c1.077.827 1.866 2.12 1.866 3.813C18 18.232 15.3 20 13.12 20H8a1.5 1.5 0 0 1-1.5-1.5l-.004-13c0-.397.158-.779.44-1.06ZM9.5 10.25h2.88c.903 0 1.62-.76 1.62-1.625S13.281 7 12.38 7H9.498l.002 3.25Zm0 3V17h3.62c.874 0 1.88-.754 1.88-1.88 0-1.13-.974-1.87-1.88-1.87H9.5Z"
                />
              </svg>
              <svg
                class="filled-gray-700 rounded-lg border border-gray-600 h-8 w-9 p-1"
                viewBox="0 0 24 24"
                @click="italizetext"
              >
                <path
                  d="M10.649 18.5h3.847a1 1 0 0 1 0 2h-9.5a.997.997 0 0 1-.996-1c0-.552.445-1 .996-1h3.51L13.332 6H9.997a1 1 0 0 1 0-2H18.5a1 1 0 0 1 0 2h-3.025L10.65 18.5Z"
                />
              </svg>
              <svg
                class="filled-gray-700 rounded-lg border border-gray-600 h-8 w-9 p-1"
                viewBox="0 0 24 24"
                @click="striketext"
              >
                <path
                  d="M13.848 11.5H19.5a1 1 0 0 1 0 2h-2.387a4.03 4.03 0 0 1 .998 2.684c0 2.93-3.28 4.915-7.033 4.48-2.328-.271-3.965-1.22-4.827-2.833-.26-.487-.207-1.016.248-1.331.455-.316 1.256-.099 1.516.388.533.998 1.604 1.592 3.294 1.789 2.586.3 4.802-.91 4.802-2.492 0-1.099-.547-1.94-2.107-2.685H5a1 1 0 1 1 0-2H13.848ZM6.987 9.695a5.122 5.122 0 0 1-.298-.51c-.3-.59-.468-1.214-.435-1.835.16-2.965 2.934-4.713 6.602-4.287 2.26.263 3.99 1.084 5.147 2.487a.993.993 0 0 1-.153 1.4c-.426.351-1.049.326-1.4-.1-.813-.985-2.068-1.596-3.825-1.8-2.56-.298-4.371.718-4.371 2.323 0 .714.239 1.22.762 1.81.225.254.647.525 1.265.815H7.192a38.03 38.03 0 0 1-.205-.303Z"
                />
              </svg>
              <svg
                class="filled-gray-700 rounded-lg border border-gray-600 h-8 w-9 p-1"
                viewBox="0 0 24 24"
                @click="codifytext"
              >
                <path
                  d="M14.6,16.6L19.2,12L14.6,7.4L16,6L22,12L16,18L14.6,16.6M9.4,16.6L4.8,12L9.4,7.4L8,6L2,12L8,18L9.4,16.6Z"
                />
              </svg>
            </div>
            <div v-if="templatetype == 'interactive'" class="col-span-2 mt-5">
              <div>
                <div
                  class="inline-flex justify-between gap-4 content-center justify-items-center"
                >
                  <input
                    type="checkbox"
                    title="Hheader"
                    class="w-5 border-blue-400"
                    @change="header = !header"
                  />
                  <span class="text-lg font-medium">
                    {{ $t('WHATSAPP_TEMPLATES.LABEL.HEADER') }}
                  </span>
                </div>
                <div v-if="header" class="w-full">
                  <div class="mt-6 ml-4 w-full">
                    <div class="inline-flex rounded-md shadow-sm" role="group">
                      <div
                        class="py-2 px-16 font-medium  bg-white rounded-l-lg border-2 border-woot-500 hover:bg-woot-500 hover:text-white focus:text-gray-500 focus:outline-none"
                        :class="
                          media == 1
                            ? 'bg-woot-500 text-white'
                            : 'bg-white text-woot-500'
                        "
                        @click="templatechanged(1)"
                      >
                        {{ $t('WHATSAPP_TEMPLATES.BUTTON.TEXT') }}
                      </div>
                      <div
                        class="py-2 px-16 font-medium  bg-white border-t-2 border-b-2 border-woot-500 hover:bg-woot-500 hover:text-white focus:text-gray-500 focus:outline-none"
                        :class="
                          media == 2
                            ? 'bg-woot-500 text-white'
                            : 'bg-white text-woot-500'
                        "
                        @click="templatechanged(2)"
                      >
                        {{ $t('WHATSAPP_TEMPLATES.BUTTON.IMAGE') }}
                      </div>
                      <div
                        class="py-2 px-16 font-medium  bg-white border-t-2 border-b-2 border-l-2 border-woot-500 hover:bg-woot-500 hover:text-white focus:z-10 focus:text-gray-400 focus:outline-none"
                        :class="
                          media == 3
                            ? 'bg-woot-500 text-white'
                            : 'bg-white text-woot-500'
                        "
                        @click="templatechanged(3)"
                      >
                        {{ $t('WHATSAPP_TEMPLATES.BUTTON.VIDEO') }}
                      </div>
                      <div
                        class="py-2 px-16 font-medium  bg-white rounded-r-md border-2 border-woot-500 hover:bg-woot-500 hover:text-white focus:text-gray-500 focus:outline-none"
                        :class="
                          media == 4
                            ? 'bg-woot-500 text-white'
                            : 'bg-white text-woot-500'
                        "
                        @click="templatechanged(4)"
                      >
                        {{ $t('WHATSAPP_TEMPLATES.BUTTON.DOCUMENT') }}
                      </div>
                    </div>
                    <div
                      v-if="media == 1"
                      class="grid grid-col-1 mt-10 min-w-full"
                    >
                      <label class="text-sm font-normal text-gray-700">
                        {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_HEADER') }}
                      </label>
                      <input
                        v-model="headercomponent.text"
                        maxlength="60"
                        class="border-b border-gray-500 w-full text-xl px-4 pb-4 pt-2 pl-0"
                        placeholder="We have thhis promotion for you"
                      />
                    </div>

                    <div v-if="media == 2">
                      <div class="flex content-center mt-6 gap-4">
                        <div v-if="url" class="h-56 w-2/5">
                          <img
                            class="object-cover shadow-lg rounded-md h-full w-full"
                            :src="url"
                          />
                        </div>
                        <div class="grid content-center">
                          <label
                            for="dropzone-file"
                            class="p-2 px-16 justify-center items-center bg-woot-500 text-white font-semibold text-base h-12 rounded-lg border-2 border-woot-500 text-center"
                          >
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.UPLOAD_IMAGE') }}
                            <input
                              id="dropzone-file"
                              type="file"
                              class="hidden"
                              accept="image/*"
                              @change="onFileChange"
                            />
                          </label>
                        </div>
                      </div>
                    </div>
                    <div v-if="media == 3">
                      <div class="flex content-center mt-6 gap-4">
                        <div v-if="file" class="h-56 w-2/5">
                          <video
                            v-show="file != ''"
                            id="video-preview"
                            controls
                          />
                        </div>
                        <div class="grid content-center">
                          <label
                            for="dropzone-file"
                            class="p-2 px-16 justify-center items-center bg-woot-500 text-white font-semibold text-base h-12 rounded-lg border-2 border-woot-500 text-center"
                          >
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.UPLOAD_VIDEO') }}
                            <input
                              id="dropzone-file"
                              type="file"
                              class="hidden"
                              accept="video/*"
                              @change="handleFileUpload($event)"
                            />
                          </label>
                        </div>
                      </div>
                    </div>
                    <div v-if="media == 4">
                      <div class="flex content-center mt-6 gap-4">
                        <div v-if="url" class="h-56 w-2/5 bg-dash rounded-md">
                          <div>
                            <svg
                              class="fill-dash h-48 w-full"
                              viewBox="0 0 24 24"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                d="M17.75 2.007a2.25 2.25 0 0 1 2.245 2.096l.005.154v15.498A2.25 2.25 0 0 1 17.904 22l-.154.005H6.25a2.25 2.25 0 0 1-2.245-2.096L4 19.755V4.257a2.25 2.25 0 0 1 2.096-2.245l.154-.005h11.5ZM7.75 7a.75.75 0 1 0 0 1.5h8.5a.75.75 0 0 0 0-1.5h-8.5ZM7 11.75c0 .414.336.75.75.75h8.5a.75.75 0 0 0 0-1.5h-8.5a.75.75 0 0 0-.75.75ZM7.75 15a.75.75 0 1 0 0 1.5h8.5a.75.75 0 0 0 0-1.5h-8.5Z"
                              />
                            </svg>
                          </div>
                        </div>
                        <div class="grid content-center">
                          <label
                            for="dropzone-file"
                            class="p-2 px-16 justify-center items-center bg-woot-500 text-white font-semibold text-base h-12 rounded-lg border-2 border-woot-500 text-center"
                          >
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.UPLOAD_DOCUMENT') }}
                            <input
                              id="dropzone-file"
                              type="file"
                              class="hidden"
                              accept="application/*"
                              @change="onFileChange"
                            />
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="mt-10">
                <div
                  class="inline-flex justify-between gap-4 content-center justify-items-center"
                >
                  <input
                    type="checkbox"
                    title="Hheader"
                    class="w-5 border-blue-400"
                    @change="footer = !footer"
                  />
                  <span class="text-lg font-medium">
                    {{ $t('WHATSAPP_TEMPLATES.LABEL.FOOTER') }}
                  </span>
                </div>
                <div v-if="footer" class="mt-6 ml-4">
                  <div class="grid mt-10">
                    <label class="text-sm font-normal text-gray-700">
                      {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_FOOTER') }}
                    </label>
                    <input
                      v-model="footercomponent.text"
                      maxlength="60"
                      class="border-b border-gray-500 w-full text-xl px-4 pb-4 pt-2 pl-0 text-gray-700"
                      placeholder="Promocion valida hasta manana"
                    />
                  </div>
                </div>
              </div>
              <div class="mt-10">
                <div
                  class="inline-flex justify-between gap-4 content-center justify-items-center"
                >
                  <input
                    type="checkbox"
                    title="Header"
                    class="w-5 border-blue-400"
                    @change="buttons = !buttons"
                  />
                  <span class="text-lg font-medium">
                    {{ $t('WHATSAPP_TEMPLATES.LABEL.BUTTONS') }}
                  </span>
                </div>
                <div v-if="buttons" class="mt-6 ml-4">
                  <div>
                    <div class="inline-flex rounded-md shadow-sm" role="group">
                      <div
                        class="py-2 px-16 font-semibold hover:font-semibold rounded-l-lg border-2 border-woot-500 hover:bg-woot-500 focus:text-gray-500 focus:outline-none"
                        :class="
                          simple
                            ? 'bg-woot-500 text-white'
                            : 'bg-woot-50 text-woot-500 hover:text-white'
                        "
                        @click="simple = true"
                      >
                        {{ $t('WHATSAPP_TEMPLATES.BUTTON.SIMPLE') }}
                      </div>
                      <div
                        class="py-2 px-16 font-semibold hover:font-semibold rounded-r-md border-2 border-woot-500 hover:bg-woot-500 focus:text-gray-500 focus:outline-none"
                        :class="
                          !simple
                            ? 'bg-woot-500 text-white'
                            : 'bg-woot-50 text-woot-500 hover:text-white'
                        "
                        @click="simple = false"
                      >
                        {{ $t('WHATSAPP_TEMPLATES.BUTTON.CALL_ACTION') }}
                      </div>
                    </div>
                  </div>

                  <div class="mt-16 mb-16 ml-4">
                    <button
                      v-if="simple"
                      class="text-gray-700 p-2 bg-gray-100 border-2 border-gray-600 rounded-md px-8 flex content-center gap-4 w-56 cursor-pointer"
                      :class="btns > 2 ? 'cursor-not-allowed opacity-50' : ''"
                      @click="addsimplebtn"
                    >
                      <div type="button" class="mt-1 font-medium text-base">
                        <span>
                          {{ $t('WHATSAPP_TEMPLATES.BUTTON.ADD_BUTTON') }}
                        </span>
                      </div>
                      <div>
                        <svg
                          class="h-8 w-8 fill-gray-500"
                          viewBox="0 0 24 24"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            d="M12 2c5.523 0 10 4.477 10 10s-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2Zm0 1.5a8.5 8.5 0 1 0 0 17 8.5 8.5 0 0 0 0-17ZM12 7a.75.75 0 0 1 .75.75v3.5h3.5a.75.75 0 0 1 0 1.5h-3.5v3.5a.75.75 0 0 1-1.5 0v-3.5h-3.5a.75.75 0 0 1 0-1.5h3.5v-3.5A.75.75 0 0 1 12 7Z"
                          />
                        </svg>
                      </div>
                    </button>
                    <button
                      v-else
                      class="text-gray-700 p-2 bg-gray-100 border-2 border-gray-600 rounded-md px-8 flex content-center gap-4 w-56 cursor-pointer"
                      :class="btnc > 1 ? 'cursor-not-allowed opacity-50' : ''"
                      @click="addactionbtns"
                    >
                      <div type="button" class="mt-1 font-medium text-base">
                        <span>
                          {{ $t('WHATSAPP_TEMPLATES.BUTTON.ADD_BUTTON') }}
                        </span>
                      </div>
                      <div>
                        <svg
                          class="h-8 w-8 fill-gray-500"
                          viewBox="0 0 24 24"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            d="M12 2c5.523 0 10 4.477 10 10s-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2Zm0 1.5a8.5 8.5 0 1 0 0 17 8.5 8.5 0 0 0 0-17ZM12 7a.75.75 0 0 1 .75.75v3.5h3.5a.75.75 0 0 1 0 1.5h-3.5v3.5a.75.75 0 0 1-1.5 0v-3.5h-3.5a.75.75 0 0 1 0-1.5h3.5v-3.5A.75.75 0 0 1 12 7Z"
                          />
                        </svg>
                      </div>
                    </button>
                  </div>
                  <div class="grid">
                    <div v-if="simple" class="grid gap-4">
                      <div
                        v-if="btns > 0"
                        class="flex justify-between gap-8 w-full"
                      >
                        <div class="flex justify-center mt-2">
                          <div
                            class="rounded-full border-2 border-woot-500 h-8 w-8 text-woot-500 font-bold text-center"
                          >
                            1
                          </div>
                        </div>
                        <div class="grid w-full">
                          <label class="text-base font-normal text-gray-700">
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_BUTTON') }}
                          </label>
                          <input
                            v-model="simplebuttonscomponent.buttons[0].text"
                            class="border-b border-gray-500 w-full text-xl p-1 text-gray-700"
                          />
                        </div>
                      </div>

                      <div
                        v-if="btns > 1"
                        class="flex justify-between gap-8 w-full"
                      >
                        <div class="flex justify-center mt-2">
                          <div
                            class="rounded-full border-2 border-woot-500 h-8 w-8 text-woot-500 font-bold text-center"
                          >
                            2
                          </div>
                        </div>
                        <div class="grid w-full py-2">
                          <label class="text-base font-normal text-gray-700">
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_BUTTON') }}
                          </label>
                          <input
                            v-model="simplebuttonscomponent.buttons[1].text"
                            class="border-b border-gray-500 w-full text-xl p-1 text-gray-700"
                          />
                        </div>
                      </div>
                      <div
                        v-if="btns > 2"
                        class="flex justify-between gap-8 w-full"
                      >
                        <div class="flex justify-center mt-2">
                          <div
                            class="rounded-full border-2 border-woot-500 h-8 w-8 text-woot-500 font-bold text-center"
                          >
                            3
                          </div>
                        </div>
                        <div class="grid w-full py-2">
                          <label class="text-base font-normal text-gray-700">
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_BUTTON') }}
                          </label>
                          <input
                            v-model="simplebuttonscomponent.buttons[2].text"
                            class="border-b border-gray-500 w-full text-xl p-1 text-gray-700"
                          />
                        </div>
                      </div>
                    </div>
                    <div v-else class="grid grid-cols-12 gap-6 mt-6">
                      <div
                        v-if="btnc > 0"
                        class="flex justify-between col-span-5 gap-8 w-full"
                      >
                        <div class="flex justify-center mt-2">
                          <div
                            class="rounded-full border-2 border-woot-500 h-8 w-8 text-woot-500 font-bold text-center"
                          >
                            1
                          </div>
                        </div>
                        <div class="grid w-full mt-2">
                          <label class="text-base font-normal text-gray-700">
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_BUTTON') }}
                          </label>
                          <input
                            v-model="actionbuttonscomponent.buttons[0].text"
                            placeholder="Button text"
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 min-w-full"
                          />
                        </div>
                      </div>
                      <div v-if="btnc > 0" class="col-span-5">
                        <div class="grid  w-full mt-6">
                          <label class="text-base font-normal text-gray-700">
                            {{
                              actionbuttonscomponent.buttons[0].type === 'URL'
                                ? $t('WHATSAPP_TEMPLATES.LABEL.URL')
                                : $t('WHATSAPP_TEMPLATES.LABEL.MOBILE')
                            }}
                          </label>
                          <input
                            v-if="
                              actionbuttonscomponent.buttons[0].type === 'URL'
                            "
                            v-model="actionbuttonscomponent.buttons[0].url"
                            placeholder="Enter button url"
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 mt-6 min-w-full"
                          />
                          <input
                            v-else
                            v-model="
                              actionbuttonscomponent.buttons[0].phone_number
                            "
                            placeholder="Enter button phone No."
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 mt-6 min-w-full"
                          />
                        </div>
                      </div>
                      <div v-if="btnc > 0" class="col-span-2">
                        <div class="grid w-full mt-2">
                          <label class="text-base font-normal text-gray-700">
                            {{
                              actionbuttonscomponent.buttons[0].type === 'URL'
                                ? $t('WHATSAPP_TEMPLATES.LABEL.URL')
                                : $t('WHATSAPP_TEMPLATES.LABEL.MOBILE')
                            }}
                          </label>
                          <!--<input
                            v-model="actionbuttonscomponent.buttons[0].url"
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 min-w-full"
                          />-->
                          <select
                            id="actiobuttontypes"
                            v-model="actionbuttonscomponent.buttons[0].type"
                            :disabled="btnc > 1 && !nothingselected"
                            class="bg-gray-50 border border-gray-300  text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:text-black dark:focus:ring-blue-500 dark:focus:border-blue-500 px-2"
                            @change="updateselections(1)"
                          >
                            <option
                              v-for="b in actiobuttontypes"
                              :key="b.id"
                              :value="b.value"
                              class="text-lg text-black p-2"
                            >
                              {{ b.label }}
                            </option>
                          </select>
                        </div>
                      </div>
                      <div
                        v-if="btnc > 1"
                        class="flex justify-between col-span-5 gap-8 w-full"
                      >
                        <div class="flex justify-center">
                          <div
                            class="rounded-full border-2 border-woot-500 h-8 w-8 text-woot-500 font-bold text-center"
                          >
                            2
                          </div>
                        </div>
                        <div class="grid w-full mt-2">
                          <label class="text-base font-normal text-gray-700">
                            {{ $t('WHATSAPP_TEMPLATES.LABEL.TEXT_BUTTON') }}
                          </label>
                          <input
                            v-model="actionbuttonscomponent.buttons[1].text"
                            placeholder="Button text"
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 min-w-full"
                          />
                        </div>
                      </div>
                      <div v-if="btnc > 1" class="col-span-5">
                        <div class="grid  w-full mt-6">
                          <label class="text-base font-normal text-gray-700">
                            {{
                              actionbuttonscomponent.buttons[0].type ===
                              'PHONE_NUMBER'
                                ? $t('WHATSAPP_TEMPLATES.LABEL.URL')
                                : $t('WHATSAPP_TEMPLATES.LABEL.MOBILE')
                            }}
                          </label>
                          <input
                            v-if="
                              actionbuttonscomponent.buttons[0].type ===
                                'PHONE_NUMBER'
                            "
                            v-model="actionbuttonscomponent.buttons[1].url"
                            placeholder="Enter button url"
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 mt-6 min-w-full"
                          />
                          <input
                            v-else
                            v-model="
                              actionbuttonscomponent.buttons[1].phone_number
                            "
                            placeholder="Enter button phone No."
                            class="border-b border-gray-500 w-full text-xl pl-2 text-gray-700 mt-6 min-w-full"
                          />
                        </div>
                      </div>
                      <div v-if="btnc > 1" class="col-span-2">
                        <div class="grid  w-full mt-2">
                          <label class="text-base font-normal text-gray-700">
                            {{
                              actionbuttonscomponent.buttons[0].type ===
                              'PHONE_NUMBER'
                                ? $t('WHATSAPP_TEMPLATES.LABEL.URL')
                                : $t('WHATSAPP_TEMPLATES.LABEL.MOBILE')
                            }}
                          </label>
                          <select
                            id="actiobuttontypes"
                            v-model="actionbuttonscomponent.buttons[1].type"
                            :disabled="btnc > 1 && !nothingselected"
                            class="bg-gray-50 border border-gray-300  text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:text-black dark:focus:ring-blue-500 dark:focus:border-blue-500 px-2 "
                            @change="updateselections(2)"
                          >
                            <option
                              v-for="b in actiobuttontypes"
                              :key="b.id"
                              :label="b.value"
                              :value="b.value"
                              class="text-lg p-2"
                            >
                              {{ b.label }}
                            </option>
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-span-4 bg-nexto m-4 p-4">
          <div class="bg-white p-5 rounded-md text-lg grid ">
            <div v-if="headercomponent.text" class="font-medium my-6">
              {{ headercomponent.text }}
            </div>
            <img
              v-if="url && media != 3"
              style="height: 20rem"
              class="object-cover shadow-md rounded-md w-full"
              :src="url"
            />
            <video
              v-if="media == 3"
              v-show="file != ''"
              id="video-preview"
              class="w-full rounded-md shadow-md object-cover"
              autoplay="autoplay"
              muted
              controls
            />
            <div class="mt-4">
              <span
                class="text-gray-600 text-lg font-medium"
                v-html="formatedtext"
              />
            </div>
            <div class="mt-3">
              <span class="text-gray-700"> {{ footercomponent.text }}</span>
            </div>
          </div>
          <div v-if="simple" class="mt-6">
            <div
              v-if="simplebuttonscomponent.buttons[0].text"
              class="bg-white p-4 rounded-md mt-4 flex justify-center"
            >
              <span class="font-semibold text-woot-500 text-xl">
                {{ simplebuttonscomponent.buttons[0].text }}
              </span>
            </div>
            <div
              v-if="simplebuttonscomponent.buttons[1].text"
              class="bg-white p-4 rounded-md mt-4 flex justify-center"
            >
              <span class="font-semibold text-woot-500 text-xl">
                {{ simplebuttonscomponent.buttons[1].text }}
              </span>
            </div>
            <div
              v-if="simplebuttonscomponent.buttons[2].text"
              class="bg-white p-4 rounded-md mt-4 flex justify-center"
            >
              <span class="font-semibold text-woot-500 text-xl">
                {{ simplebuttonscomponent.buttons[2].text }}
              </span>
            </div>
          </div>
          <div v-else class="mt-6">
            <div
              v-if="actionbuttonscomponent.buttons[0].text"
              class="bg-white p-4 rounded-md mt-4 flex justify-center"
            >
              <fluent-icon
                :icon="
                  actionbuttonscomponent.buttons[1].type === 'PHONE_NUMBER'
                    ? 'opennew'
                    : 'call'
                "
                class="text-woot-500 mr-1 h-6 w-6"
              />
              <span class="font-semibold text-woot-500 text-xl ml-1">
                {{ actionbuttonscomponent.buttons[0].text }}
              </span>
            </div>

            <div
              v-if="actionbuttonscomponent.buttons[1].text"
              class="bg-white p-4 rounded-md mt-4 flex justify-center"
            >
              <fluent-icon
                :icon="
                  actionbuttonscomponent.buttons[0].type === 'URL'
                    ? 'call'
                    : 'opennew'
                "
                class="text-woot-500 mr-1 h-6 w-6"
              />
              <span class="font-semibold text-woot-500 text-xl ml-1">{{
                actionbuttonscomponent.buttons[1].text
              }}</span>
            </div>
          </div>
        </div>
      </div>
      <div class="border-t border-gray-700 mt-48 flex justify-end gap-3">
        <div
          class="lg:w-auto w-full h-12 py-6 flex text-white rounded-lg bg-woot-500 px-10 mt-8 justify-center align-middle content-center cursor-pointer"
          @click="$emit('cancel')"
        >
          <p class="pt-1">{{ $t('WHATSAPP_TEMPLATES.BUTTON.CANCEL') }}</p>
        </div>
        <div
          class="lg:w-auto w-full h-12 py-6 flex text-white rounded-lg bg-woot-500 px-10 mt-8 justify-center align-middle content-center cursor-pointer"
          @click="savetemplate"
        >
          <p class="pt-1">{{ $t('WHATSAPP_ACCOUNT.BUTTON.ADD_TEMPLATE') }}</p>
        </div>
      </div>
      <div />
    </div>
  </div>
</template>
<script>
import WhatsAppAPI from '../../../../../api/whatsapp';
import { VEmojiPicker } from 'v-emoji-picker';
export default {
  components: {
    VEmojiPicker,
  },
  props: {
    accountId: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      placeholder:
        'Hi {{ name }}.This summer is about too start, and we want to offer you our products',
      header: false,
      footer: false,
      buttons: false,
      file: null,
      media: 1,
      url: null,
      btns: 0,
      btnc: 0,
      emojipicker: false,
      simple: true,
      templatetype: 'text',
      phoneNumber: '',
      templateUrl: '',
      formats: ['', 'TEXT', 'IMAGE', 'VIDEO', 'DOCUMENT'],
      formData: new FormData(),
      footercomponent: {
        type: 'FOOTER',
        text: null,
      },
      bodycomponent: {
        type: 'BODY',
        text: '',
      },
      headercomponent: {
        text: null,
        type: 'HEADER',
        format: '',
        example: {
          header_handle: [''],
        },
      },
      simplebuttonscomponent: {
        type: 'BUTTONS',
        buttons: [
          {
            type: 'QUICK_REPLY',
            text: null,
          },
          {
            type: 'QUICK_REPLY',
            text: null,
          },
          {
            type: 'QUICK_REPLY',
            text: null,
          },
        ],
      },
      actionbuttonscomponent: {
        type: 'BUTTONS',
        buttons: [
          {
            type: null,
            text: null,
            phone_number: '',
          },
          {
            type: null,
            text: null,
            url: '',
            example: ['https://www.website.com/dynamic-url-example'],
          },
        ],
      },
      actiobuttontypes: [
        {
          id: 1,
          label: 'Phone',
          value: 'PHONE_NUMBER',
        },
        {
          id: 2,
          label: 'Url',
          value: 'URL',
        },
      ],
      templatecomponent: {
        name: '',
        category: '',
        components: [],
        language: '',
      },
      categories: [
        {
          title: 'Select Category',
          value: '',
        },
        {
          title: 'Account Update',
          value: 'ACCOUNT_UPDATE',
        },
        {
          title: 'Alert Update',
          value: 'ALERT_UPDATE',
        },
        {
          title: 'Auto Reply',
          value: 'AUTO_REPLY',
        },
        {
          title: 'Appointment Update',
          value: 'APPOINTMENT_UPDATE',
        },
        {
          title: 'Payment Update',
          value: 'PAYMENT_UPDATE',
        },
        {
          title: 'Personal finance update',
          value: 'PERSONAL_FINANCE_UPDATE',
        },
        {
          title: 'Reservation Update',
          value: 'RESERVATION_UPDATE',
        },
        {
          title: 'Shipping Update',
          value: 'SHIPPING_UPDATE',
        },
        {
          title: 'Ticket Update',
          value: 'TICKET_UPDATE',
        },
        {
          title: 'Issue Resolution',
          value: 'ISSUE_RESOLUTION',
        },
        {
          title: 'Transportation update',
          value: 'TRANSPORTATION_UPDATE',
        },
      ],
      languages: [
        {
          title: 'Select Language',
          value: '',
        },
        {
          title: 'English',
          value: 'es',
        },
        {
          title: 'English-US',
          value: 'en_US',
        },
        {
          title: 'Portugese',
          value: 'pt_BR',
        },
        {
          title: 'Indiana',
          value: 'id',
        },
      ],
      template: {
        header: null,
        body:
          'Hi {{ name }}. This summer is about too start, and we want to offer you our products Lorem ipsum dolor sit de amet consectur del',
        footer: 'Promoción válida hasta mañana',
        simple: {
          text1: null,
          text2: null,
        },
        action: {
          text1: null,
          text2: null,
        },
      },
    };
  },
  computed: {
    filteredsimplebuttons() {
      var btns = this.simplebuttonscomponent.buttons.filter(function _(b) {
        return b.text != null;
      });
      return btns;
    },
    filteredactionbuttons() {
      var btns = this.actionbuttonscomponent.buttons.filter(function _(b) {
        return b.text != null;
      });
      return btns;
    },
    formatedtext() {
      return this.bodycomponent.text
        .replace(/(?:\*)([^*<\n]+)(?:\*)/g, '<strong>$1</strong>')
        .replace(/(?:_)([^_<\n]+)(?:_)/g, '<i>$1</i>')
        .replace(/(?:~)([^~<\n]+)(?:~)/g, '<s>$1</s>')
        .replace(
          /(?:```)([^```<\n]+)(?:```)/g,
          '<tt class="bg-gray-300 font-thin p-1 text-sm">$1</tt>'
        );
    },
    nothingselected() {
      return (
        this.actionbuttonscomponent.buttons[0].type === null &&
        this.actionbuttonscomponent.buttons[1].type === null
      );
    },
  },
  methods: {
    async onFileChange(e) {
      this.headercomponent.example.header_handle = [''];
      const file = e.target.files[0];
      this.formData.append('file', file);
      const rs = await WhatsAppAPI.uploadTemplateResource(this.formData);
      if (rs.status === 200 && rs.data.url) {
        this.headercomponent.example.header_handle = [rs.data.url];
      }
      this.url = URL.createObjectURL(file);
    },
    templatechanged(value) {
      this.media = value;
    },
    updateheaderformat(format) {
      this.headercomponent.format = format;
    },
    updateselections(index) {
      if (index === 1) {
        const selectedObj = this.actiobuttontypes.find(obj => {
          return obj.value === this.actionbuttonscomponent.buttons[0].type;
        });
        const selectedIndex = this.actiobuttontypes.indexOf(selectedObj);
        const unselectedIndex = selectedIndex === 0 ? 1 : 0;
        this.actionbuttonscomponent.buttons[0].type = this.actiobuttontypes[
          selectedIndex
        ].value;
        this.actionbuttonscomponent.buttons[1].type = this.actiobuttontypes[
          unselectedIndex
        ].value;
      }
      if (index === 2) {
        const selectedObj = this.actiobuttontypes.find(obj => {
          return obj.value === this.actionbuttonscomponent.buttons[1].type;
        });
        const selectedIndex = this.actiobuttontypes.indexOf(selectedObj);
        const unselectedIndex = selectedIndex === 0 ? 1 : 0;
        this.actionbuttonscomponent.buttons[1].type = this.actiobuttontypes[
          selectedIndex
        ].value;
        this.actionbuttonscomponent.buttons[0].type = this.actiobuttontypes[
          unselectedIndex
        ].value;
      }
    },
    async previewVideo() {
      let video = document.getElementById('video-preview');
      let reader = new FileReader();

      reader.readAsDataURL(this.file);
      this.formData.append('file', this.file);
      const rs = await WhatsAppAPI.uploadTemplateResource(this.formData);
      if (rs.status === 200 && rs.url) {
        this.headercomponent.example.header_handle = [rs.url];
      }
      reader.addEventListener('load', () => {
        video.src = reader.result;
      });
    },
    async handleFileUpload(event) {
      this.file = event.target.files[0];
      this.formData.append('file', this.file);
      const rs = await WhatsAppAPI.uploadTemplateResource(this.formData);
      if (rs.status === 200 && rs.data.url) {
        this.headercomponent.example.header_handle = [rs.data.url];
      }
      this.previewVideo();
    },
    async savetemplate() {
      var components = [this.bodycomponent];
      this.headercomponent.format = this.formats[this.media];
      if (this.templatetype === 'interactive') {
        if (this.header) {
          if (this.media === 1) {
            delete this.headercomponent.example;
          } else {
            delete this.headercomponent.text;
          }
          components.push(this.headercomponent);
        }
        if (this.footer) {
          components.push(this.footercomponent);
        }
        if (this.buttons) {
          const nbuttons = this.simple
            ? this.filteredsimplebuttons
            : this.filteredactionbuttons;
          components.push({
            type: 'BUTTONS',
            buttons: nbuttons,
          });
        }
      }
      this.templatecomponent.components = components;
      const payload = {
        accountId: this.accountId,
        data: {
          template: this.templatecomponent,
        },
      };
      if (
        this.templatetype === 'interactive' &&
        this.header &&
        this.media !== 1
      ) {
        let foundIndex = components.findIndex(
          element => element.type === 'HEADER'
        );
        components.splice(foundIndex, 1, this.headercomponent);
        const response = await WhatsAppAPI.createWhatsAppTemplate(payload);
        if (response.status === 200) {
          this.$emit('synctemplates');
        }
      } else {
        const response = await WhatsAppAPI.createWhatsAppTemplate(payload);
        if (response.status === 200) {
          this.$emit('synctemplates');
        }
      }
      /** this.$store
        .dispatch('whatsapptemplates/createtemplate', payload)
        .then(() => {
          this.$emit('synctemplates');
        });
        * */
    },
    addsimplebtn() {
      if (this.btns < 3) {
        this.btns += 1;
      }
      this.btnc = 0;
    },
    addactionbtns() {
      if (this.btnc < 2) {
        this.btnc += 1;
      }
      this.btns = 0;
    },
    boldtext() {
      this.getSel('*');
    },
    italizetext() {
      this.getSel('_');
    },
    striketext() {
      this.getSel('~');
    },
    codifytext() {
      this.getSel('```');
    },
    getSel(format) {
      const txtarea = document.getElementById('bodytextarea');

      // Obtain the index of the first selected character
      const start = txtarea.selectionStart;

      // Obtain the index of the last selected character
      const finish = txtarea.selectionEnd;

      // eslint-disable-next-line no-extend-native, func-names
      String.prototype.replaceBetween = function(initial, end, what) {
        return this.substring(0, initial) + what + this.substring(end);
      };

      // Obtain the selected text
      const sel = txtarea.value.substring(start, finish);

      const out = this.bodycomponent.text.replaceBetween(
        start,
        finish,
        format.concat(sel).concat(format)
      );

      this.bodycomponent.text = out;
      // Do something with the selected content
    },
    emojiselected(emoji) {
      this.bodycomponent.text = this.bodycomponent.text.concat(emoji.data);
    },
  },
};
</script>
<style scopes>
#journal-scroll::-webkit-scrollbar {
  width: 8px;
  margin-top: 15px !important;
  cursor: pointer;
  /*background-color: rgba(229, 231, 235, var(--bg-opacity));*/
}
#journal-scroll::-webkit-scrollbar-track {
  background-color: white;
  border: 1px solid #1174ff;
  border-radius: 5px;
  cursor: pointer;
  /*background: red;*/
}
#journal-scroll::-webkit-scrollbar-thumb {
  cursor: pointer;
  border: 0.5px solid #1174ff;
  border-radius: 5px;
  background-color: #1174ff;
  /*outline: 1px solid slategrey;*/
}
</style>
