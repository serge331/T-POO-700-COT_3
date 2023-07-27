<template>
<div class = "global_box">
    <div class = "box">
        <div class ="delete">
            <button @click="add_users()"> <i class="fas fa-user-plus"></i></button>
            <button @click="delete_team()"> <i class="fas fa-trash-alt"></i> </button>
        </div>
        <div class = "avatar">
            <img src="../assets/profil.jpg" />
        </div>
        <div class="details"> 
            <p>{{teams.name}}</p>
            <p>{{teams.manager}}</p>
        </div>
        <div class = "touchs">
            <button @click="select_team()">{{teams.name}}</button>
        </div>
    </div>
    <div v-if="add_user_team" class = "popup" >
        <div>
            <input v-model="search" />
        </div>
        <div @click="fil_users">
            <i class="fas fa-search"></i>
        </div>
        <p>Choisissez un utilisateur:</p>
        <div v-for="user in users" :key="user.id" :id="user.id" @click="some_adds(user.id)"><UserList :user="user" :add="add"/> </div>
    </div>
    
</div>
</template>
  
  <script>
  import UserList from "./UserList.vue";
  import axios from 'axios'
  import VueAxios from 'vue-axios'
  const axios_inst = axios.create({
    baseURL: "http://localhost:4000/api",
    headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }
})
  export default {
    emits: ['response' , 'delete' , 'select' , "users"],
    name: 'CompComp',
    props: {
      teams: Object,
      teamss: Array,
      users: Array,
    },
    components:{
        UserList,
    },
    data(){
        return{
            check: "",
            add_user_team: false,
            filteredTeams: this.teamss,
            search: "",
            response: "",
            add: false,
            t_users: null,
            filteredUsers: [],
            teams_users: [],
            filtered_tusers: []
        }
        
    },
    async mounted(){
        await axios_inst.get("/team_content/")
                .then(response => {
                    this.response = response.data
                })
                .catch(e => {
                    this.response = e.code
                })
                this.t_users = this.response.data
                //alert(this.t_users)
    },
    methods:{
       async  select_team(){
            this.check = "team_details"
            await axios_inst.get("/team_content/team/" + this.teams.id)
                .then(response => {
                    this.response = response.data.data
                })
                .catch(e => {
                    this.response = e.code
                })  
            this.teams_users = this.response

            await axios_inst.get("/users/all")
                .then(response => {
                    this.response = response.data.data
                })
                .catch(e => {
                    this.response = e.code
                }) 
                /*for (let t in this.teams_users){
                    for (let n in this.response){
                        if (t.user_id = n.id){
                            this.filtered_tusers.push(n)
                        }
                    }
                }
            this.$emit('users' , this.filtered_tusers)*/
            this.$emit('response' , this.check)
            this.$emit('select' , this.teams.name)
            /*alert(this.check)*/
        },

        async delete_team(){
            //alert(this.teamss)
            await axios_inst.delete('/teams/' + this.teams.id,
                ).then(response => {
                    this.response = response.data
                }).catch(e => {
                    this.response = e.code
                })
                this.$router.go()
            
        },
        async add_users(){
            this.add_user_team =!this.add_user_team
            if (this.add_user_team == true){
                await axios_inst.get("/users/all")
                .then(response => {
                    this.response = response.data.data
                })
                .catch(e => {
                    this.response = e.code
                }) 
            this.users = this.response
            }
            
        },
        fil_users(){

        },
        async some_adds(e){
            await axios_inst.post("/team_content",
                    {
                        user_id: e,
                        team_id: this.teams.id
                    })
                    .then(response => {
                        this.response = response.data
                    })
                    .catch(e => {
                        this.response = e.code
                    })
                
                if (typeof(this.response.data.id) != "undefined"){
                    document.getElementById(e).style["display"] = "none"
                }
        }
    }
  }
  </script>
  
  <style scoped>
    
    .global_box{
        display: flex;
        flex-direction: row;
    }
    .box{
        border-radius: 10px;
        /*background-color: rgba(115, 202, 236, 0.842);*/
        width: 300px;
        margin: 10px;
        text-align: center;
        height: 350px;
        animation-name: appear;
        animation-duration: 1s;
        animation-timing-function: linear;
        display: flex;
        flex-direction:column;
        align-items: center;
        justify-content: center;
        padding: 10px;
        border: 1px solid grey;
        
    }
    .avatar{
        /*background-image: url("../assets/profil.jpg");*/
        border: 5px solid rgb(240, 238, 238);
        height: 100px;
        width: 100px;
        border-radius: 50% 50% 50% 50%;
        background-color: rgb(184, 180, 180);
    }

    .avatar img{
        width: 100%;
        height: 100%;
        border-radius: 50% 50% 50% 50%;
    }

    .details{
        width: 100px;
        height: 100px;
    }

    .details p:nth-child(2){
        font-size: 10px;
    }

    .details p{
        margin: 10px;
    }

    .touchs{
        background-color:white;
        width: 100%;
        /*height: 100px;*/
        border-bottom-left-radius: 5px;
        border-bottom-right-radius: 5px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .touchs > button:nth-child(1){
        border: 1px solid grey;
        background-color: rgb(190, 189, 189);
        width: 100px;
        padding: 10px;
        border-radius: 20px 20px 20px 20px / 50% 50% 50% 50%;
    }

    .touchs > button:nth-child(1):hover{
        background-color: rgb(173, 172, 172);
    }

   

    .delete{
        display: flex;
        /*align-items:center;*/
        justify-content: right;
        width: 100%;
        text-align: center;

    }


    .delete > button{
        margin-bottom: 10px;
        width: 14%;
        padding: 2px;
        height: 100%;
        border-radius: 50% 50% 50% 50%;
        /*border: 1px solid gray;
        background-color: rgb(201, 199, 199);*/
    }

    .delete > button:nth-child(1):hover{
        background-color: rgb(4, 0, 255);
        box-shadow: 1px 1px 1px 1px;
    }
    .delete > button:nth-child(2):hover{
        background-color: red;
        box-shadow: 1px 1px 1px 1px;
    }

    .display_users{
        z-index: 1;
    }

    .popup{
        height: 200px;
        overflow-y: auto;
        border: 1px solid grey;
        padding: 5px;
        border-radius: 5px;
        animation-name: popup;
        animation-duration: 2s;
    }

    .popup div:nth-child(1) input{
        border-radius: 5% 5% 5% 5% / 50% 50% 50% 50%;
        border: 2px solid rgb(218, 215, 215);
        padding-left: 10px ;
        padding-right: 10px;
    }

    @keyframes popup{
        from{
            opacity:0
        }
        to{
            opacity: 1;
        }
    }
    
  </style>
  