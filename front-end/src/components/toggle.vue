<!-- <template>
    <div
        class="w-14 h-8 flex items-center bg-gray-300 rounded-full p-1 transition-color duration-300 cursor-pointer"
        :class="value ? 'bg-orange-500' : 'bg-gray-400'"
        :aria-checked="value.toString()"
        @click="toggle"
    >
        <div
            class="propert bg-white w-6 h-6 rounded-full shadow-md transform duration-300 transition-transform"
            :class="{ 'translate-x-6': value }"
        >
        </div>
    </div>
</template>
  
<script>
export default {
props: {
    value: {
    type: Boolean,
    }
},
// data () {
//   return {
//     classObject:{
//         value: false,
//     }
//   };
// },
methods: {
    toggle() {
    console.log(!this.value)
        this.$emit('update:value', !this.value);
    }
},
};
</script>
<style>
.propert{
    transform: none;
}
</style>
   -->
   <template>
    <button
     class="ui button big w-12 h-8 rounded-full p-1 transition-color duration-300 cursor-pointer"
     :class="[isActive ? 'bg-emerald-500' : 'bg-red-600']"
     @click="toggle"
   >{{isActive ? 'on' : 'off'}}</button>
   </template>
   
   <script>
   import axios from 'axios'
   export default {
     data() {
       return {
        save_user:null,
        isActive:this.state
        //fake informations
       };
     },
     props:{
      mail:"",
      user:"",
      id:"",
      state:""
     },
     methods:{
      async toggle() {
           this.isActive = !this.isActive;
   
         //get information user
         await axios.get('http://localhost:4000/api/users'
           + '?' + 'email' + '=' +this.mail + '&' + 'username' + '=' +this.user, { headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }}
         ).then(response=>{
           // console.log(this.save_user = response.data.data)
           this.save_user = response.data.data
         })
         await axios({
             method: "put",
             url: 'http://localhost:4000/api/users/' + this.id,
             headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            },
             data: {
                 avatar: this.save_user['avatar'],
                 deleted: this.save_user['deleted'],
                 email: this.save_user['email'],
                 firstname: this.save_user['firstname'],
                 id: this.save_user['id'],
                 lastname: this.save_user['lastname'],
                 password: this.save_user['password'],
                 role: this.save_user['role'],
                 state: this.isActive,
                 username: this.save_user['username']
                 
             }
         }).then(response => {
           // console.log(this.response = response.data)
           this.response = response.data
         }).catch(e => {
             this.response = e.code
         })  
       }, 
     },
     
    
   };
   </script>
   
   <style>
   
   </style>