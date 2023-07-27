<template>
    <div class = "UserList">
        <div class = "avatar">
          <img src = "../assets/profil.jpg"/>
        </div>
        <div>
          <p> {{ user.firstname }} </p>
          <p> {{ user.lastname }} </p>
          <i v-if="add" class="fas fa-check"></i>
        </div>
    </div>
  </template>
  
  <script>
    export default {
    name: 'UserList',
    props: {
      user: Object,
      add: Boolean,
    }
    
  }
  </script>
  
  <style scoped>
  
  .UserList{
    display: flex;
    align-items: center;
    height: 70px;
    /*box-shadow: 0px 1px 20px 1px;*/
    margin-bottom: 5px;
    margin-top: 5px;
    border-radius: 10px;
    /*border: 1px solid grey;*/
    width: 200px;
  }

  .UserList:hover{
    background-color: rgb(236, 232, 232);
  }
  
  .avatar{
    border: 5px solid rgb(240, 238, 238);
    height: 50px;
    width: 50px;
    border-radius: 50% 50% 50% 50%;
    background-color: rgb(245, 240, 240);

  }
  .UserList div:nth-child(1){
    margin : 10px;
  }
  .UserList div:nth-child(2){
    padding: 10px;
  }
  
 
  
  </style>
  