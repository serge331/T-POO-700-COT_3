<template>
    
    <div class="w-screen flex flex-row flex-wrap justify-around">
    <div class="w-2/5 rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-center text-xl mb-2">Monthly Chart</div>
        <BarChart />
      </div>
    </div>
    <div class="w-2/5 rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-center text-xl mb-2">Abscences Chart</div>
        <AbsChart />
      </div>
    </div>
    <div class="w-3/4 rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-center text-xl mb-2">Weekly Chart</div>
        <LineChart />
      </div>
    </div>

</div>
</template>
  
  <script>
import BarChart from "../components/charts/barMonth.vue";
import AbsChart from "../components/charts/pieAbscence";
import LineChart from "../components/charts/lineWeek";
import { h } from "vue";

export default {
  render() {
    return h("div");
  },
  components: {
    BarChart,
    AbsChart,
    LineChart,
  },
};
</script>
  
  
  
  <style lang="scss">
.row {
  bottom: 0;
  right: 0;
}
</style>