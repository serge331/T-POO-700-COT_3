<script>
import axios from 'axios'
import VueAxios from 'vue-axios'
export default{
    name: "login",
    data(){
        return{
            email:"",
            password:"",
            response:null
        }
    },
    methods:{
        async submit(){
            await axios({
                    method: "post",
                    url: 'http://localhost:4000/api/login',
                    data: {
                       email: this.email,
                       password: this.password
                    }
                }).then(response => {
                    this.response = response.data
                    console.log(this.response)
                }).catch(e => {
                    this.response = e.code
                    console.log(this.response)
                })
                //alert(this.response.id)

                if (typeof(this.response.id) != "undefined"){
                    localStorage.setItem('id' , this.response.id)
                    localStorage.setItem('email' , this.response.email)
                    localStorage.setItem('username' , this.response.username)
                    localStorage.setItem('role' , this.response.role)
                    localStorage.setItem("session_token" , this.response.session_token)
                    window.location.replace("http://localhost:3000/dashboard");
                   // alert(localStorage.getItem("id"))
                }else{
                    alert(this.response.incorrect)
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
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="email" placeholder="Email"  v-model="email" required/>
            <input class="my-2 w-60 border p-2 rounded-xl border-black text-sm" type="password" placeholder="Password" v-model="password" required/>
            </div>
            <div class="my-4 flex justify-center">
            <button class="w-60 border bg-[#302e2d] p-2 font-sans text-white text-sm rounded-xl">Login</button>
            </div>
        </form>
        <div class="mx-7 my-3 flex justify-between text-sm font-semibold">
        <!-- <div>{{response}}</div> -->
        <div><a href="#"> Forget Password </a></div>
        <div><a href="/registery" class="underline underline-offset-2">Signup</a></div>
        </div>
    </div>
</div>
</template>


<style>
.formulaire {
    background: url(../assets/background.jpg);
    background-size: cover;
}

</style>