<template>
  <div class="relative inline-block overflow-hidden">
    <input
      type="file"
      accept="image/*"
      class="hidden"
      ref="file"
      @change="change"
    />
    <img :src="src" alt="Avatar" class="h-full w-full object-cover" />
    <div
      class="absolute top-0 h-full w-full bg-black bg-opacity-25 flex items-center justify-center"
    >
      <button
        type="button"
        @click="browse()"
        class="rounded-full hover:bg-white hover:bg-opacity-25 p-2 focus:outline-none text-white transition duration-200"
      >
      </button>
      <!-- <button
        type="button"
        v-if="value"
        @click="remove()"
        class="rounded-full hover:bg-white hover:bg-opacity-25 p-2 focus:outline-none text-white transition duration-200"
      >
      </button> -->
      <!-- <div class="rounded-ful p-4 focus:outline-none text-white transition duration-200"></div>
      <i class="fas fa-camera"></i> -->
    </div>
  </div>
</template>

<script>

export default {
  props: {
    value: File,
    defaultSrc: String,
  },
  data() {
    return {
      src: this.defaultSrc,
      save_user : null,
      id:'14',
      response:'',
      //fake informations
      mail:"jane1@gmail.com",
      user:"name",
    };
  },
  methods: {
    change(e) {
      // this.$emit("input", e.target.files[0]);
      let reader = new FileReader();
      reader.readAsDataURL(e.target.files[0]);
      reader.onload = (e) => {
        this.src = e.target.result;
      }
    },
    browse() {
     
      this.$refs.file.click();

      
    },
    // remove() {
    //   this.$emit("input", null);
    // },
    
  },
};
</script>
<style>

</style>