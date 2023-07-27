<template>
    <div class = "UserComp">
        <div class = "avatar">
          <img src = "../assets/profil.jpg"/>
        </div>
      <div>
          <p>{{user.lastname + " " +  user.firstname}} </p>
      </div>
      <div>
        <ul>
          <li>
              <button @click = "promouvoir"> Promouvoir </button>
          </li>
          <li>
            <button @click = "retrograder"> Retrograder </button>
          </li>
          <li>
            <p> {{ user.role }} </p>
          </li>
        </ul>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios'
  import VueAxios from 'vue-axios'
  const axios_inst = axios.create({
    baseURL: "http://localhost:4000/api",
    headers: {
                "session": "session_token=" + localStorage.getItem("")
            }
})
    export default {
    emits: ['response'],
    name: 'UserComp',
    props: {
      user: Object
    },
    data(){
      return {
          users: [],
          check: false,
      } 
    },
    async mounted(){
      
    },
    methods:{
      async promouvoir(){
        this.user.role = "Manager"
        await axios_inst.put("/users/" + this.user.id,
                    {
                      deleted: this.user.deleted,
                      email: this.user.email,
                      firstname: this.user.firstname,
                      lastname: this.user.lastname,
                      role: "Manager",
                      username: this.user.username,
                      state: this.user.state,
                      avatar: this.user.avatar,
                      password: this.user.password  
                    })
                    .then(response => {
                        this.response = response.data
                    })
                    .catch(e => {
                        this.response = e.code
                    })
                    /*this.$router.go()
            this.check = "team_details"
            this.$emit('response' , this.check)*/

      },
      async retrograder(){
        this.user.role = "Employee"
        await axios_inst.put("/users/" + this.user.id,
                    {
                      deleted: this.user.deleted,
                      email: this.user.email,
                      firstname: this.user.firstname,
                      lastname: this.user.lastname,
                      role: "Employee",
                      username: this.user.username,
                      state: this.user.state,
                      avatar: this.user.avatar,
                      password: this.user.password  
                    })
                    .then(response => {
                        this.response = response.data
                    })
                    .catch(e => {
                        this.response = e.code
                    })
                    /*this.$router.go()
            this.check = "team_details"
            this.$emit('response' , this.check)*/

      }
    }
    
  }
  </script>
  
  <style scoped>
  
  .UserComp{
    display: flex;
    align-items: center;
    height: 100px;
    box-shadow: 0px 1px 5px 1px;
    margin-bottom: 5px;
    margin-top: 5px;
    border-radius: 10px;
  }
  
  .avatar{
    border: 5px solid rgb(240, 238, 238);
    height: 50px;
    width: 50px;
    border-radius: 50% 50% 50% 50%;
    background-color: rgb(245, 240, 240);
    margin-left: 10px;
  }
  
  .UserComp div:nth-child(1){
    width: 100px;
    height: 100px;
    display: flex;
    align-items: center;
  }
  .UserComp div:nth-child(2){
    width: 50vh;
    text-align: center;
  }
  
  .UserComp div:nth-child(3){
    width: 50vh;
    text-align: center;
  }
  
  ul{
    float: left;
    display: flex;
    flex-direction: row;
    list-style: none;
  }
  
  ul li{
    width: 250px;
  }
  
  li button{
    border: none;
    background-color: rgb(240, 239, 239);
    width: 125px;
    padding: 10px;
    border-radius: 20px 20px 20px 20px / 50% 50% 50% 50%;
  }
  
  </style>
  