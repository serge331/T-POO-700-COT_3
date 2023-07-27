<template>
    
   <div class="side_bar">
        <SidebarVue/>
        <RouterView />        
    </div>
    
</template>

<script setup>
import { RouterView } from "vue-router";
import SidebarVue from '../components/Sidebar.vue';

</script>

<style lang="scss" >
:root {
    --grey : #64748b;
    --sidebar-width : 300px;
    --light : white;
}

*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
body{
    background: var(--light);
}
button{
    appearance: none;
    border: none;
    outline: none;
    background: none;
    cursor: pointer;
}
.side_bar{
    display: flex;
    main{
        // flex-direction: row;
        padding: 20px;

        @media screen and (max-width : 600px) {
            body{
                padding: 0 0 0 5em;
                
            }
        }
    }
    
}
</style>