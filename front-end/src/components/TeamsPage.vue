<script>
import CompComp from "./TeamComp.vue"
import UserComp from "./UserComp.vue"
import axios from 'axios'
import VueAxios from 'vue-axios'
let id = 0
let val = "Team"
let man = "Manager"
let user = "user"
let lastname = "lastname"
let firstname = "firstname"
let user_id = 0
const axios_inst = axios.create({
    baseURL: "http://localhost:4000/api",
    headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }
})
    export default{
        name: "TeamsPage",
        components:{
            CompComp,
            UserComp
        },
        data(){
            return {
                current_team: "",
                team_name: "",
                team_manager: "",
                teams: "teams",
                add_team_: false,
                filteredTeam: [],
                search: "",
                user: {id: user_id++ , username: user + user_id  , lastname: lastname + user_id , firstname: firstname + user_id},
                champs: [
               /*{id: id++ , text: val + id , box: "box1" , manager: man + id , url: "../assets/profil.jpg"},
                {id: id++ , text: val + id , box: "box2" , manager: man + id , url: "../assets/profil.jpg"},
                {id: id++ , text: val + id, box: "box3" , manager: man + id , url: "../assets/profil.jpg"},*/
            ],
                users:[
                ]
        }
    },
    methods:{
       async create_team(){
            if (this.team_name != 0 && this.team_manager != 0){

                await axios_inst.get("/user/exist/" + this.team_manager)
                .then(response => {
                    this.response = response.data.data
                })
                .catch(e => {
                    this.response = e.code
                })

                //alert(this.response.id)

                if (typeof(this.response.id) != "undefined"){

                    await axios_inst.post("/teams",
                    {
                        name: this.team_name,
                        manager:this.team_manager,
                        deleted: false
                    })
                    .then(response => {
                        this.response = response.data
                    })
                    .catch(e => {
                        this.response = e.code
                    })

                    this.$router.go()
                }
            }
        },
        fil_users(){
            if (this.search == ""){

            }else{
                this.users = this.users.filter((t) => t.firstname === this.search)
            }
            
            //alert(this.filteredUser)
        },
        back(){
            this.teams = "teams"
        }
    },
    async mounted(){

        await axios_inst.get("/teams")
                .then(response => {
                    this.response = response.data.data
                })
                .catch(e => {
                    this.response = e.code
                }) 

                if (typeof(this.response[0].id) != "undefined")
        {
            this.filteredTeam = this.response
        }

        await axios_inst.get("/users/all")
                .then(response => {
                    this.response = response.data.data
                })
                .catch(e => {
                    this.response = e.code
                }) 
                
                this.users = this.response
        
           
    }
}

</script>

<template>
<div class = "global">
    <div id = "header">
        <p></p>
    </div>
    <div id = "body">
        <div v-if = "teams === 'teams'" class = "teams">
                <div  v-for="champ in filteredTeam" :key="champ.id">
                   <CompComp :teams="champ" :teamss="this.champs" :users="users" @response="(msg) => this.teams = msg" @delete="(msg) => this.filteredTeam = msg" @select="(msg) => this.current_team = msg"/>
                </div>

                <div class="box1">
                    <div id = "plus" class = "avatar" @click = "create_team()" >
                        <img src="../assets/plus.png" />
                    </div>
                    <div class = "add_t">
                        <input v-model="team_name" placeholder="Nom de la team" required/>
                        <input v-model="team_manager" placeholder="Manager de la team" required/>
                    </div>
                </div>
                <div v-if = "add_team_">
                    
                </div>
        </div>
        <div v-else-if = "teams === 'team_details'" class = "users">
            <div class = "details_header">
                <div @click="back" >
                    <i class="fas fa-angle-left"></i>
                </div>
                <div>
                    <img src = "../assets/logo.png" />
                </div>
                <div>
                    <p>{{this.current_team}}</p>
                </div>
                <div>
                    <input v-model="search" />
                </div>
                <div @click="fil_users">
                    <i class="fas fa-search"></i>
                </div>
                
            </div>
            <div class = "details_body">
                    <div v-for = "user in users" :key="user.id" >
                        <UserComp :user="user"/>
                    </div>
            </div> 
            <div class = "details_footer">
                
            </div>
        </div>
    </div>
    <div id = "footer">

    </div>
</div>
</template>

<style>
    .global{
        flex: 1;
    }
    #header{
        height: 20px;
    }
    #body{
        display: flex;
        flex-flow:row wrap;
        align-items: flex-end;
        width: 80%;
    }

    .teams{
        display: flex;
        flex-flow:row wrap;
        align-items: flex-end;
        flex-direction: row;
    }

    /*.teams div:nth-child(2){
        justify-content: center;
    }*/

    .team{
       
    }



    .add_t{
        display: flex;
        flex-direction: column;
    }

    .add_t input{
        padding: 1vh;
        margin-top: 2vh;
        margin-bottom: 1vh;
        border-radius: 1vh ;
        border: 1px solid grey;
    }

    /*.box{
        border-radius: 10px;
        background-color: white;
        width: 300px;
        margin: 10px;
        text-align: center;
        height: 300px;
        animation-name: appear;
        animation-duration: 1s;
        animation-timing-function: linear;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 10px;
        border: 1px solid grey;
        
    }*/

    .box1{
        border-radius: 10px;
        background-color: white;
        width: 250px;
        margin: 10px;
       /* text-align: center;*/
        height: 250px;
        animation-name: appear;
        animation-duration: 1s;
        animation-timing-function: linear;
        display: flex;
        flex-direction: column;
        /*align-items: center;
        justify-content: center;*/
        padding: 10px;
        border: 1px solid grey;
    }

    #plus{

    }

    #plus:hover {
        background-color: rgb(224, 221, 221);
    }

    #plus:active{
        background-color: rgb(180, 177, 177);
    }

    .avatar{
        /*background-image: url("../assets/profil.jpg");*/
        border: 5px solid rgb(240, 238, 238);
        height: 25px;
        width: 25px;
        border-radius: 50% 50% 50% 50%;
        background-color: rgb(245, 240, 240);
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

   /* .box > div > button{
        border: none;
        width: 100px;
        padding: 10px;
        border-radius: 20px 20px 20px 20px / 50% 50% 50% 50%;
    }*/


    .users{
        /*margin-left: 20px;*/
        display: flex;
        flex-direction: column;
        align-content: space-around;
        flex-wrap: wrap;
    }

    .details_body{

        overflow-y: auto;
        height: 500px;
        padding: 50px;
        
    }

   /* .details_body div:nth-child(1){
        height: 20%;
    }*/

    /*.users div:nth-child(2){
        
    }*/

   @keyframes appear{
        from {
            opacity: 0;
            position:relative;
            top:-20px;
        }
        to {
            opacity: 1;
            position:relative;
            top:0px;
        }     

   }


.details_header{
    /*position: sticky;*/
    border-bottom: 4px solid rgb(221, 220, 220);
    width: 100%;
    height: 15vh;
    display: flex;
    align-items: center;
    flex-direction: row;
    flex-wrap: nowrap;
}

.details_header div:nth-child(1){
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    height: 1vh;
    width: 1vh;
    border-radius: 50% 50% 50% 50%;
    background-color: rgb(245, 240, 240);  
    margin: 20px;
}

.details_header div:nth-child(1):hover{
    background-color: rgb(209, 208, 208);
}

.details_header div:nth-child(1):active{
    background-color: rgb(165, 165, 165);
}


.details_header div:nth-child(2){
    border: 5px solid rgb(240, 238, 238);
    height: 10vh;
    width: 10vh;
    border-radius: 50% 50% 50% 50%;
    background-color: rgb(245, 240, 240);  
    margin-right: 5vh;

}

.details_header div:nth-child(2) img{
    width: 100%;
    height: 100%;
    border-radius: 50% 50% 50% 50%;
}

.details_header div:nth-child(3){
    height: 9vh;
    width: 90vh;

}

.details_header div:nth-child(4){
    width: 40vh;
    display: flex;
    justify-content: center;
}

.details_header div:nth-child(4) input{
    border-radius: 5% 5% 5% 5% / 50% 50% 50% 50%;
    border: 2px solid rgb(218, 215, 215);
    padding: 5px 50px ;
}


</style>