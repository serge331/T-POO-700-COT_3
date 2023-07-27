<template>
  <div id="app overflow-x-auto">
    <table>
      <thead>
        <tr>
          <th>Users</th>
          <th></th>
        </tr>
      </thead>
      <tbody class="">
        <tr class="overflow-x-auto cursor-pointer champs" v-for="(user, index) in filteredRows" :key="`user-${index}`">
          <!-- v-on:mouseover="mouseover(user.email,user.username)" -->
          <td class="visible"  @click="user_info(user.email,user.username)" v-text="`${user.firstname } ${user.lastname}`"  
          v-html="highlightMatches(user.firstname) + ' ' + highlightMatches(user.lastname)"
          >
          </td>
          <td @click="user_info(user.email,user.username)" class="tiple">
            <toggle :mail="user.email" :user="user.username" :id="user.id" :state="user.state"/>
            <span class="stable material-icons " @click="delete_user(user.id,index)">delete</span>
            <span class="stable two material-icons" @click="show_dashboard">dashboard_customize</span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  
  
  </template>
  <script>
  import toggle from "./toggle.vue"
  import axios from "axios";
  export default {
    components: { toggle },
    data () {
        return {
            btnDisable: true,
            users : [],
            info : [],
            selected_user: null,
            current_user : "",
            suppr_user : null,
            select_user:null,
        };
    },
    props:{
      filter: "",
      mail_store:""
    },
    methods: {
      async user_info(email, username){
        await axios.get('http://localhost:4000/api/users'
          + '?' + 'email' + '=' +email + '&' + 'username' + '=' +username, { headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }}
        ).then(response=>{
          // console.log(this.selected_user = response.data.data)
          this.selected_user = response.data.data
        })
        this.$emit('userdata',this.selected_user)
      },

      // async mouseover(email, username){
      //   await axios.get('http://localhost:4000/api/users'
      //     + '?' + 'email' + '=' +email + '&' + 'username' + '=' +username
      //   ).then(response=>{
      //     // console.log(this.selected_user = response.data.data)
      //     this.select_user = response.data.data
      //   })
      //   // this.$emit('userdatafortoggle',this.selected_user)
      // },
     
     async getUser(){
        // const userResponse = await axios
        // .get<users>('http://localhost:4000/api/users')
        // this.users = userResponse.data
        await axios.get('http://localhost:4000/api/users/all', { headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }})
        .then(response=>{
          this.users = response.data.data;
          this.users = this.users.filter( user => user.role !=='GM')
        })        
  
      },
      show_dashboard(){
        this.$router.push({ name: "ChartManager"});
      },

      async delete_user(id,index){
        await axios.delete('http://localhost:4000/api/users/'+id, { headers: {
                "session": "session_token=" + localStorage.getItem("session_token")
            }})
        .then(response=>{
          // console.log(this.suppr_user = response.data)
          this.suppr_user = response.data
        })
        this.users.splice(index,1)
      },
      highlightMatches(text) {
        const matchExists = text.
        toLowerCase().
        includes(this.filter.toLowerCase());
        if (!matchExists) return text;
  
        const re = new RegExp(this.filter, "ig");
        return text.replace(re, matchedText => `<strong>${matchedText}</strong>`);
    }, 
  },
    async mounted() {
      await this.getUser()
    },
    computed: {
    filteredRows() {
        return this.users.filter(user => {
        const firstname1 = user.firstname.toString().toLowerCase();
        const search = this.filter.toLowerCase();
        // user.lastname.toString().toLowerCase().includes(this.filter.toLowerCase());
  
        return (
            firstname1.includes(search)
            );
        });
    } 
  }
  
  };
  </script>
  <style>
  .champs:hover{
      transition: 0.3s;
      background-color:rgb(255, 220, 196);
  }
  
  table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
    border: none;
  }
  
  td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
    
    
  }
  
  td{
    border: none;
    border-collapse:collapse 
    /* border-style : hidden!important; */
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
  .stable{
    position: relative;
    top: 4px;
    margin-left: 20px;
    
  }
  .two {
    color: rgb(131, 178, 219);
  }
  .tiple{
    position: relative;
    display: flex;
    justify-content: flex-end;
  }
  </style>