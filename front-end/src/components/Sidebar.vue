<template>
  <aside :class="`${large_tail ? 'large_tail' : ''}`" id="tail" class="bg-slate-800 min-h-screen p-4 truncate">
    <div class="logo">
        <img src="../assets/bat.png" alt="Gotham">
    </div>

    <div class="Menutoggle">
        <button class="toggle" @click="ToggleMenu">
            <span class="rotate-180 material-icons">menu_open</span>
        </button>
    </div>
    <hr>
    <menu class="my-1.5 underline underline-offset-4">Menu</menu>
    <div class="options">
        <router-link class="button"
            :to="{name:'ChartManager'}"
        >
        <span class="material-icons">dashboard</span>
        <span class="write">Chart Manager</span>

        </router-link>

        <router-link class="button"
            :to="{name:'user'}"
        >
        <span class="material-icons">groups</span>
        <span class="write">User-Teams</span>
        </router-link>

        <router-link class="button"
            :to="{name:'ClockManager'}"
        >
        <span class="material-icons">history</span>
        <span class="write">Clock Manager</span>
    
        </router-link>

        <!-- <router-link class="button"
            :to="{name:'WorkingTime'}"
        >
        <span class="material-icons">schedule</span>
        <span class="write">Working Time</span>

        </router-link> -->

        
        <router-link class="button"
            :to="{name:'account'}"
        >
        <span class="material-icons">manage_accounts</span>
        <span class="write">Manage Accounts</span>

        </router-link>
    </div>

    <div class="down"></div>
    <div class="options">
        <router-link class="button"
                :to="{name:'settings'}"
        >
            <span class="material-icons">settings</span>
            <span class="write">Settings</span>
        
        </router-link>
    </div>
  </aside>
</template>

<script setup>
import { ref } from 'vue'

const large_tail = ref(false)

const ToggleMenu = () => {
    large_tail.value = !large_tail.value
}
</script>

<style lang="scss" scoped>
#tail{
    display: flex;
    flex-direction: column;
    width: calc(2em + 40px);
    color: white;
    transition: 0.3 ease-in-out;
    @media screen and (max-width : 768px) {
        position : fixed;
        z-index: 100;
    }

    .down {
		flex: 1 1;
	} 

    .logo {
        margin: 0 0 1em -0.8em;
        width: 4em;
       
    }

    .Menutoggle{
        display: flex;
        justify-content: flex-end;
        position: relative;
        
        .toggle {
            transition: 0.5s;
            .material-icons{
                font-size: 2em;
                margin-left: -1.3em;
            }
            &:hover{
                .material-icons{
                    transform: translateX(0.2em);
                    color: bisque;
                }
            }
        }
    }


    menu{
        opacity: 0%;
    }
    .options{
        display: flex;
        flex-direction: column;
        margin: -1em;
        .button {
            margin: 30%;
            .write{
                position: relative;
                top: -20%;
                opacity: 0%;
            }
            &.router-link-exact-active{
                background-color: green($color: #96e191);
				border-right: 5px solid rgb(111, 227, 121);
                margin: 1em;
                
            }
        }
    }
     

    &.large_tail {
		width: var(--sidebar-width);
        .toggle{
            position: relative;
            top: -3.2em;
            transform: rotate(-180deg);
            margin-right: 2em;
        }
        hr{
            opacity: 0%;
        }
        menu{
            color: gray;
            font-size: 10px;
            opacity: 100%;
            margin-bottom: 2em;
        }
    
        menu, .options {
            position: relative;
            .button{
                margin: 5%;
                &:hover {
                    background-color: #e5e9eb;
                    color: #454545;
                }
                .write{
                    margin: 7%;
                    opacity: 100%;
                    &:hover{
                        transition: 0.3s;

                    }
                }
            }
        }
	}


    
}

</style>