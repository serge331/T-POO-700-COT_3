<template>
  <Bar
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    :plugins="plugins"
    :css-classes="cssClasses"
    :styles="styles"
    :width="400"
    :height="250"
  />
</template>
    
<script>
import axios from "axios";
import moment from "moment";
import { Bar } from "vue-chartjs";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);

export default {
  name: "BarChart",
  components: { Bar },
  props: {
    chartId: {
      type: String,
      default: "bar-chart",
    },
    datasetIdKey: {
      type: String,
      default: "label",
    },
    width: {
      type: Number,
      default: 400,
    },
    height: {
      type: Number,
      default: 400,
    },
    cssClasses: {
      default: "",
      type: String,
    },
    styles: {
      type: Object,
      default: () => {},
    },
    plugins: {
      type: Object,
      default: () => {},
    },
  },
  methods: {
    dateDiff(startDateString, endDateString) {
      let start = moment(startDateString);
      let end = moment(endDateString);
      let duration = moment.duration(end.diff(start));
      let days = duration.asMonths();
      return Math.round(days);
    },
    async getData() {
      await axios({
        method: "get",
        url: "http://localhost:4000/api/workingtimes",
      })
        .then((response) => {
          this.start = response.data.data[0].start;
          this.end = response.data.data[0].end;
          console.log(this.start);
          console.log(this.end);
          this.difference = this.dateDiff(this.start, this.end);
          console.log(this.difference);
          //this.chartData.datasets.data.push(this.difference);
          //console.log(this.chartData.datasets.data);
          // console.log(this.chartData)
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  async mounted() {
    this.getData();
    //console.log(this.difference)
  },
  data() {
    return {
      chartData: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [
          { label: "Working times", data: [0, 0, 0, 0, 0, 0, 0, 0] },
        ],
      },
      chartOptions: {
        responsive: true,
      },
    };
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    lineTension: 1,
  },
};
</script>