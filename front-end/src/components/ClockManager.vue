<template>

    <div class="h-screen w-screen">
        <div :class="afficherModal === true ? 'modal bg-slate-800 bg-opacity-50 flex justify-center items-center absolute top-0 right-0 bottom-0 left-0 ': 'hidden'">
            <div class="bg-white px-16 py-14 rounded-md text-center">
                <h1 class="text-xl mb-4 font-bold text-slate-500">Do you confirm the end of your day?</h1>
                <button @click="cacherLeModal" class="bg-red-500 px-4 py-2 rounded-md text-md text-white">Cancel</button>
                <button @click="confirmerLeModal" class="bg-indigo-500 px-7 py-2 ml-2 rounded-md text-md text-white font-semibold">Ok</button>
            </div>
        </div>


        <div v-if="newDay">
            <h1 class=" titre uppercase text-3xl">day to day timing</h1>

            <div class="test w-1/2">
                <p class="mb-5">Arrival time: {{arrivalHour}}</p>
                <p>Departure time: {{departureHour}}</p>
            </div>

            <div class="flex justify-center mb-20">
                <button @click="startTheDay" :class="newDay===true ?'starter rounded-xl border-solid border-2 border-indigo-600  px-4 text-indigo-600 drop-shadow-xl font-bold  active:drop-shadow-none' : 'hidden'">NEW DAY</button>
                <button @click="startHandler" :class="newDay===true ?'hidden' : 'starter rounded-xl border-solid border-2 border-indigo-600  px-4 text-indigo-600 drop-shadow-xl font-bold  active:drop-shadow-none'">Start</button>
                <button @click="endHandler" :class="newDay===true ?'hidden' : 'ender rounded-xl  border-solid border-2 border-indigo-600 px-4 text-indigo-600 drop-shadow-xl font-bold  active:drop-shadow-none'">End</button>
            </div>
        </div>

        <div v-else>
            <h1 class=" titre uppercase text-3xl">day to day timing</h1>

            <div class="flex justify-center mb-20">
                <button @click="startTheDay" :class="newDay===true ?'starter rounded-xl border-solid border-2 border-indigo-600  px-4 text-indigo-600 drop-shadow-xl font-bold  active:drop-shadow-none' : 'hidden'">NEW DAY</button>
                <button @click="startHandler" :class="newDay===true ?'hidden' : 'starter rounded-xl border-solid border-2 border-indigo-600  px-4 text-indigo-600 drop-shadow-xl font-bold  active:drop-shadow-none'">Start</button>
                <button @click="endHandler" :class="newDay===true ?'hidden' : 'ender rounded-xl  border-solid border-2 border-indigo-600 px-4 text-indigo-600 drop-shadow-xl font-bold  active:drop-shadow-none'">End</button>
            </div>


            <div :class="newDay === true ? 'hidden' : 'test w-1/2'">
                <p class="mb-5">Arrival time: {{arrivalHour}}</p>
                <p>Departure time: {{departureHour}}</p>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name: 'clockManager',
    data(){
        return {
            arrivalHour :'',
            departureHour: '',
            arrivalHourToSend: '',
            departureHourToSend: '',
            afficherModal:false,
            newDay: true,
        }
    },
    methods: {
        giveHour(){
            const d = new Date();
            d.setHours(d.getUTCHours() + 1);

            let dateLocale = d.toLocaleString('fr-FR',{
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: 'numeric',
                minute: 'numeric',
                second: 'numeric'
            });

            return dateLocale;
        },
        startHandler(){
            this.arrivalHour=this.giveHour();    
            this.arrivalHourToSend = new Date();  
        },
        endHandler(){
            this.afficherModal = true;
            this.departureHour=this.giveHour();
            this.departureHourToSend = new Date();     

        },
        cacherLeModal() {
            this.afficherModal = false;
            this.departureHour = '';
        },
        confirmerLeModal() {
            this.newDay = true;
            this.afficherModal = false;
            this.sendData();
        },
        startTheDay() {
            this.newDay = false;
            this.arrivalHour ='';
            this.departureHour= '';
        },
        async sendData() {
            // let cookieContent = document.cookie
            await axios({
                method: "post",
                url: 'http://localhost:4000/api/workingtimes/1',
                data: {
                    start: this.arrivalHourToSend,
                    end: this.departureHourToSend
                }
            }).then(response => {
                    console.log(response.data)
            }).catch(error => {
                    console.log(error)
            })  
        },
        // async sendDataBis() {
        //     const diffTime = Math.abs(this.departureHourToSend - this.arrivalHourToSend)
        //     await axios({
        //         method: "post",
        //         url: 'http://10.50.11.97:4000/api/workingtimes/1',
        //         data: {
        //             time: diffTime,
        //             status: true
        //         }
        //     }).then(response => {
        //             console.log(response.data)
        //     }).catch(error => {
        //             console.log(error)
        //     })  
        // }
        
    }
}
// import SidebarVue from '../components/Sidebar.vue';
</script>

<style>
    .conteneur{
        margin: 0 auto;
        margin-top: 15px;
    }
    .titre{
        text-align: center;
        margin: 50px auto;
    }
    .starter,
    .ender{
        margin-right: 20px;
    }
    .test {
        margin: 10px auto;
    }
</style>