<template>
    <div class = "top_main">
        <div></div>
        <div class = "main">
            <TeamsPage />
        </div>
        
    </div>
</template>

<script setup>
 import TeamsPage from './TeamsPage.vue';
</script>

<style scoped>
    .top_main{
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .top_main div:nth-child(1){
        width: 20%;
    }
    .main{
        display: flex;
        height: 800px;
        width: 100%;
        overflow-y: auto;
        overflow-x: auto;

    }
</style>