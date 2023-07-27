<template>
  <div class="first_div w-full min-h-max">
      
      <div class="forms">
          <form  action="" class="marge">
              <input type="search" name="search" id="search" v-model="filtre"
                  class="taille relative peer z-10 bg-transparent rounded-full border cursor-pointer outline-none pl-12
                      focus:w-full focus:border-lime-500 focus:pl-16 focus:pr-4 "
              >
              <i class="prop fas fa-search inset-y-0 my-auto px-3.5  border-transparent stroke-gray-500 peer-focus:border-lime-300 peer-focus:stroke-lime-500"></i>
          </form>
      </div>
      <router-link class="logout"
            :to="{name:'login'}"
      >
        <span class="material-icons" @click="deconnect">logout</span>
        <!-- <span class="write">Logout</span> -->
      </router-link>
      <div class="page">
        <div class="one_div drop-shadow-md border-2 border-slate-100 hover:drop-shadow-xl">  
          
          <div class="app">
            <button id="show-modal" @click="showModal()" class="open-button"> 
              <span class="sec stable material-icons">edit_square</span></button>
          </div>
              <div class="form-popup" v-if="block === true" >
                <form @submit.prevent="submit" action="" class="form-container bg-white shadow-md rounded px-8 pt-6 pb-8">

                  <div class="one_content">
                    <!-- <label class="absolute text-gray-700 text-sm font-bold mb-2" for="firstName"><b>FirstName</b></label> -->
                    <input class="same1 " type="text" placeholder="First Name" name="firstname" v-model="c_firstname">

                    <!-- <label class="block text-gray-700 text-sm font-bold mb-2" for="LastName"><b>LastName</b></label> -->
                    <input class="same1 " type="text" placeholder="Last Name" name="lastname" v-model="c_lastname">

                    <!-- <label class="block text-gray-700 text-sm font-bold mb-4" for="email"><b>Email</b></label> -->
                    <input class="same1 " type="text" placeholder="Enter mail" name="email" v-model="c_email">
                  </div>
                  <div class="two_content mt-4">
                    <!-- <label class="block text-gray-700 text-sm font-bold -mt-5" for="Old_psw"><b>OldPassword</b></label> -->
                    <input class="same2 shadow appearance-none border rounded py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="password" placeholder="Old Password" name="Old_psw" v-model="c_oldpassword" required>

                    <!-- <label class="block text-gray-700 text-sm font-bold mb-4" for="psw"><b>Password</b></label> -->
                    <input class="same2 shadow appearance-none border rounded py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="password" placeholder="Enter Password" name="psw" v-model="c_password">
                    
                    <!-- <label class="block text-gray-700 text-sm font-bold mb-4" for="Again_psw"><b>ConfirmPassword</b></label> -->
                    <input class="same2 shadow appearance-none border rounded py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="password" placeholder="Enter Password again" name="Again_psw" v-model="c_confpassword">
                  </div>
                  <div class="form_button">
                    <button type="submit" class="btn">Save</button>
                    <button type="button" class="btn cancel" @click="closeForm">Close</button>
                  </div>
                </form>
              </div>
                
          <div class="carrer">
            <div class="av">
              <avataruse 
                class="w-32 h-32 rounded-full marge_im"
                v-model="form.avatar"
                default-src="https://pbs.twimg.com/profile_images/1333896976602193922/MtWztkxt_400x400.jpg"
              />
            </div>
            
            <div class="content">
              <div class="trait"></div>
              <div class="content1">
                <div class="line user_name"> <span>User Name : </span>{{username}}</div>
                <div class="line mail"> <span>Email : </span>{{email}}</div>
              </div>
              <div class="content2">
                <div class="line first_name"> <span>First Name : </span> {{firstname}}</div>
                <div class="line last_name"> <span>Last Name : </span>{{lastname}}</div>
              </div>
              <div class="content3">
                <div class="line teams"> <span>Teams : </span> IT | Project Manager</div>
              </div>
            </div>
          </div>
          
          <div v-if="role_storage != 'GM'" class="inline-flex justify-center items-center w-full ajust">
            <hr class="my-8 w-64 h-1 bg-gray-200 rounded border-0 dark:bg-gray-700 ">
            <div class="absolute left-1/2 px-4 bg-white -translate-x-1/2">
              <svg aria-hidden="true" class="w-5 h-5 text-gray-700 dark:text-gray-300" viewBox="0 0 24 27" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.017 18L14.017 10.609C14.017 4.905 17.748 1.039 23 0L23.995 2.151C21.563 3.068 20 5.789 20 8H24V18H14.017ZM0 18V10.609C0 4.905 3.748 1.038 9 0L9.996 2.151C7.563 3.068 6 5.789 6 8H9.983L9.983 18L0 18Z" fill="currentColor"/></svg>
            </div>
            
          </div>
          
          <!-- div work -->
          <div class="chercher" >
            <search v-if="role_storage == 'GM'" :filter="filtre" @userdata="updateuser" :mail_store="mail_storage" />
            <img v-if="role_storage != 'GM'" class="one_oc" src="../assets/work.png" />
          </div>
          
      </div>
    </div>
  </div>
  
</template>
    
<script >
import search from "./search.vue"
import Avataruse from "./Avataruse.vue"
import bcrypt from 'bcryptjs'
import axios from 'axios'

export default {
  name: "av",
  components: {
    Avataruse,
    search,
  },
  data() {
    return {
      block:Boolean,
      mail_storage:'',
      id_storage:'',
      role_storage:'',
      username_storage:'',
      error: null,
      save_user:null,
      user_info: null,
      filtre: "",
      username: "",
      email: "",
      firstname: "",
      lastname:"",
      team:"",
      //udpade user info
      c_firstname:"",
      c_lastname:"",
      c_email:"",
      c_password:"",
      c_oldpassword:"",
      c_confpassword:"",
      storage_old_password:"",
      response: "",
      form: {
        avatar: null,
      },
      valid_pass:Boolean,
      //fake informations
      // mail:"jane1@gmail.com",
      // user:"name",
    };
  },
  methods:{
    deconnect(){
      localStorage.removeItem('id');
      localStorage.removeItem('email');
      localStorage.removeItem('role');
      localStorage.removeItem('username');
      localStorage.removeItem("session_token")
    },
    verify_user_input(old_info, new_info){
      if (new_info ==''){
        return old_info
      }else{
        return new_info
      }
    },
    verify_user_input1(old_info,new_info,hash){
      if (new_info ==''){
        return old_info
      }else{
        return hash
      }
    },
    showModal(){
      this.block = !this.block
    },
    closeForm(){
      this.block = !this.block
    },
    updateuser(data){
      // console.log(data['firstname'])
      this.username = data['username'],
      this.email = data['email'],
      this.firstname = data['firstname'],
      this.lastname = data['lastname']
    },
    async submit(){
      //get information user
      await axios.get('http://localhost:4000/api/users'
        + '?' + 'email' + '=' +this.mail_storage + '&' + 'username' + '=' +this.username_storage, { headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }}
      ).then(response=>{
        // console.log(this.save_user = response.data.data)
        this.save_user = response.data.data
        // console.log(this.save_user['firstname'])
      })

      bcrypt.compare(this.c_oldpassword, this.storage_old_password).then(validPass => {
        validPass==true
        this.valid_pass = validPass
      }).catch(err => console.log('error: ' + err));

        if (this.valid_pass == true || (this.c_password == this.c_confpassword)){
          let av = this.save_user
          let password = bcrypt.hashSync(this.c_password, bcrypt.genSaltSync(10))
          await axios({
              method: "put",
              url: 'http://localhost:4000/api/users/' + this.id_storage,
              headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            },
              data: {
                  avatar: av['avatar'],
                  deleted: av['deleted'],
                  email: this.verify_user_input(av['email'],this.c_email),
                  firstname: this.verify_user_input(av['firstname'],this.c_firstname),
                  id:av['id'],
                  lastname: this.verify_user_input(av['lastname'],this.c_lastname),
                  password: this.verify_user_input1(av['password'],this.c_password,password),
                  role: av['role'],
                  state: av['state'],
                  username: av['username']
                  
              }
          }).then(response => {
            // console.log(this.response = response.data)
            this.response = response.data
            alert("Changement éffectué")
          }).catch(e => {
              this.response = e.code
          }) 
      }else{
          alert("No same password")
      }  
    },
  },
  async mounted(){
    try {
      this.mail_storage = localStorage.getItem('email')
      this.id_storage = localStorage.getItem('id')
      this.role_storage = localStorage.getItem('role')
      this.username_storage = localStorage.getItem('username')

    }catch (error) {
    this.mail_storage = null;
    this.id_storage = null;
    this.role_storage = null;
    this.username_storage = null;
    this.error = error;
  }
  await axios.get('http://localhost:4000/api/users'
    + '?' + 'email' + '=' +this.mail_storage + '&' + 'username' + '=' +this.username_storage, { headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }}
  ).then(response=>{
    // console.log(this.selected_user = response.data.data)
    this.user_info = response.data.data
  })
  
  this.username = this.user_info['username']
  this.email = this.user_info['email'],
  this.firstname = this.user_info['firstname'],
  this.lastname = this.user_info['lastname'],
  this.storage_old_password = this.user_info['password']
  }

}






</script>
    
<style lang="scss">
.reglage{
  margin-top: -41vh;
}
.reglage1{
 margin-left: 90vh;
 margin-top: -40vh;
}
.ajust{
  position: absolute;
  top: 13em;
}
.one_oc{
  position: relative;
  // top:7vh;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  width: 30vh;
}
.img_un{
  width: 20%;
  margin-left: 35%;
}
.logout {
  position: relative;
  display: flex;
  flex-direction: row;
  margin-left: 84%;
  color: red;
}

.form-popup{
  position: fixed;
  // display: none;
  z-index: 2;
  right: 6vh;
  width: 70%;
  justify-content: flex-end;
  border: 3px solid #f1f1f1;
  
}
.one_content{
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  .same1{
    width: 30%;
  }
}
.two_content{
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  .same2{
    width: 30%;
  }
}
.form_button{
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  width: 100%;
  margin-top: 20px;
}
.form_button .btn {
  background-color: #04AA6D;
  color: white;
  padding: 8px 10px;
  border: solid 5px;
  border-radius: 10px;
  cursor: pointer;
  width: 20%;
  opacity: 0.8;
}
.form_button .cancel {
  background-color: red;
}
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}
.marge{
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin-top: 20px;
  @media screen and (max-width : 770px) {
      margin-right: 40vh;
    }
  .taille{
      width: 60vh;
      height: 2em;
      margin: 1vh;
      @media screen and (max-width : 840px) {
  
      // width: 40vh;
      }
      @media screen and (max-width : 770px) {
          margin-left: 40vh;
          width: 50vh;
      }
  }
  .prop{
      position: absolute;
      margin-top: 16px;
      margin-left: -50vh;
      @media screen and (max-width : 770px) {
          margin-left: 35vh;
          width: 20vh;
      }
  }
}
html,
body,
.page {
  height: 80%;
  // display: flex;
  // flex-direction: column;
}

body { 
  // overflow: hidden;
  font-family: "Times New Roman", Times, serif;
  min-width: 550px;
  
}

.first_div {
height: 100vh;
background: #ffffff;
overflow: scroll;

}
.one_div {
  background-color: #ffffff;
  width: 70%;
  height: 90%;
  position: relative;
  top:7vh;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  @media screen and (max-width:827px), (max-height:597px){
    position: relative;
    height: 110%;
  }
}
.chercher{
  position: relative;
  flex: 1 1 auto;
  overflow-y: auto;
  width: 100%;
  height: 35vh;
  margin-top: 10vh;
}
.av{
}
.av .marge_im{
  margin-top: 4em;
  margin-left: 3em;
  margin-bottom: 30px;
}
.trait{
  position: fixed;
  // position: absolute;
  border-left: 1px solid rgb(236, 217, 217); 
  height: 18vh; 
  // display: inline-block;
  // top: -11em;
  // bottom: 0;
  // left: 20%;
  // right: 0;
  // margin: auto;
  margin-top: -2vh;
}
.content{
  margin-top: -11em;
  margin-left: 32vh;
  margin-right: 2vh;
  font-size: 13px;
  .line{
      margin: 8px;
    }
  @media screen and (max-width:1025px) {
    margin-top: -25%;
    .line{
      margin: 5px;
    }
   
  }
  span{
      font-weight: bold;
  }
    .content1{

    display: flex;
    flex-direction: row;
    justify-content: space-between;
    @media screen and (max-width:1025px) {
    flex-direction: column;
    
   }
  }
  .content2{
    // position: relative;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    @media screen and (max-width:1025px) {
    flex-direction: column;
  }
  }
  .content3{
    

    @media screen and (max-width:1025px) {
  
  }
  }
  
}

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

th {
  background-color: #dddddd;
}

input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 25px;
}

.app{
  display: flex;
  justify-content: flex-end;
  #show-modal{ 
    .sec{
      position:absolute;
      margin-left: -5vh;
      margin-top: 10px;
    }
    
  }
}
@media screen and (max-width : 1030px ){
  .trait{
    height: 25vh;
  }
}

@media screen and (max-width : 742px ), (max-height:597px) {
 .av{
  display: none;
 }
 .trait{
  display: none;
 }
 .content{
  margin-top: 7em;
  margin-left: -0.1vh;
  .content1{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }
  .content2{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }
 }

 .form-popup{
  position: fixed;
  display: none;
  z-index: 2;
  right: 6vh;
  width: 100%;
  justify-content: flex-end;
  border: 3px solid #f1f1f1;
  
}
.one_content{
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-left: 10px;
  .same1{
    width: 100%;
  }
}
.two_content{
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  .same2{
    width: 100%;
    margin: 10px;
  }
}
.form_button{
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 100%;
  margin-top: 20px;
}
.form_button .btn {
  background-color: #04AA6D;
  color: white;
  padding: 8px 10px;
  border: solid 5px;
  border-radius: 10px;
  margin-left: 10px;
  cursor: pointer;
  width: 100%;
  opacity: 0.8;
}
.form_button .cancel {
  background-color: red;
}
    
}
@media screen and (max-width : 1199px) {
  .form-popup{
  position: fixed;
  display: none;
  z-index: 2;
  right: 0vh;
  width: 100%;
  justify-content: flex-end;
  border: 3px solid #f1f1f1;
  
}
.one_content{
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-left: 10px;
  .same1{
    width: 100%;
  }
}
.two_content{
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  .same2{
    width: 100%;
    margin: 10px;
  }
}
.form_button{
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 100%;
  margin-top: 20px;
}
.form_button .btn {
  background-color: #04AA6D;
  color: white;
  padding: 8px 10px;
  border: solid 5px;
  border-radius: 10px;
  margin-left: 10px;
  cursor: pointer;
  width: 100%;
  opacity: 0.8;
}
.form_button .cancel {
  background-color: red;
}
}
// @media screen and (max-height:597px) {
//   .av{
//     display: none;
//   }
// }
</style>