<script>
import bcrypt from 'bcryptjs'
import axios from 'axios'
import VueAxios from 'vue-axios'
export default{
    name: "registery",
    data(){
        return{
            firstname: "",
            lastname: "",
            email: "",
            username: "",
            password: "",
            c_password: "",
            validate : false,
            response: "",
        }
    },
    /*mounted(){
        axios
            .get('http://10.50.11.177:5000/api/users')
            .then(response => (this.response = response))
            
    },*/
    /*mounted() {
    axios.get('http://10.50.11.177:5000/api/users')
    .then(response => {
      // JSON responses are automatically parsed.
      this.response = response.data
    })
    .catch(e => {
      this.errors.push(e)
    })
  },*/
    methods: {
        async submit(){
             if (this.password == this.c_password){
                let password = bcrypt.hashSync(this.password, bcrypt.genSaltSync(10))
                //alert(password)
                let a
                /*await axios({method: 'get' , url: 'http://localhost:4000/api/users'} ).then(response => {a = response.data}).catch(e => {this.response = e.code})
                this.response = a.data[0].avatar*/
                await axios({
                    method: "post",
                    url: 'http://localhost:4000/api/users',
                    data: {
                       avatar: "avatar",
                       deleted: "false",
                       email: this.email,
                       firstname: this.firstname,
                       lastname: this.lastname,
                       password: password,
                       role: "E",
                       state: "false",
                       username: this.username
                    }
                }).then(response => {
                    this.response = response.data
                    alert("Good registery")
                    this.$router.push({ name: "login"})
                }).catch(e => {
                    this.response = e.code
                })
                
             }else{
                alert("cc")
             }
            
        }
    }
}
</script>

<template>
    <div class="formulaire bg-no-repeat bg-center  h-screen grid place-content-center">
    <div class="mx-auto my-36 flex h-4/6 w-[400px] flex-col  bg-white/[.2] rounded-xl text-black shadow-xl grid place-content-center backdrop-blur-md">
        <div class="justify-self-center w-2/4">
            <img class= "logo" src="../assets/bat.png" alt="">
        </div>
        <div class="mx-8 -mt-7 mb-1 flex flex-row justify-start space-x-2">
        </div>
        <form @submit.prevent="submit">
            <div class="flex flex-col items-center">
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="text" placeholder="First Name" v-model="firstname" required/>
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="text" placeholder="Last Name" v-model="lastname" required />
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="email" placeholder="Email" v-model="email" required/>
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="text" placeholder="Username" v-model="username" required/>
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="password" placeholder="Password" v-model="password" required/>
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="password" placeholder="Confirm Password" v-model="c_password" required/>
            </div>
            <div class="my-2 flex justify-center">
            <input class="w-60 border bg-[#302e2d] p-2 font-sans text-white text-sm rounded-xl cursor-pointer"  type="submit">
            </div>
        </form>
        <!-- <p>{{response}}</p> -->
        <div class="mx-7 my-3 flex justify-center text-sm font-semibold">
        <div class="justify-self-end"><a href="/"> Login </a></div>
        <!-- <div><h1 class="underline underline-offset-2">Signup</h1></div> -->
        </div>
    </div>
</div>
</template>