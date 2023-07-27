import { defineComponent, h, PropType } from 'vue'
import axios from "axios";
import moment from "moment";
import { Line } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
  Plugin
} from 'chart.js'

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale
)

export default defineComponent({
  name: 'LineChart',
  components: {
    Line
  },
  props: {
    chartId: {
      type: String,
      default: 'line-chart'
    },
    width: {
      type: Number,
      default: 800
    },
    height: {
      type: Number,
      default: 300
    },
    cssClasses: {
      default: '',
      type: String
    },
    styles: {
      type: Object as PropType<Partial<CSSStyleDeclaration>>,
      default: () => {}
    },
    plugins: {
      type: Array as PropType<Plugin<'line'>[]>,
      default: () => []
    }
  },
  /*methods: {
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
  },*/
  setup(props) {
    const chartData = {
      labels: ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"],
      datasets: [
        {
          label: 'Working Times',
          backgroundColor: '#f87979',
          data: [3, 0, 0, 0, 0, 0, 0, 0]
        }
      ]
    }

    const chartOptions = {
      responsive: true,
      maintainAspectRatio: false
    }

    return () =>
      h(Line, {
        chartData,
        chartOptions,
        chartId: props.chartId,
        width: props.width,
        height: props.height,
        cssClasses: props.cssClasses,
        styles: props.styles,
        plugins: props.plugins
      })
  }
})