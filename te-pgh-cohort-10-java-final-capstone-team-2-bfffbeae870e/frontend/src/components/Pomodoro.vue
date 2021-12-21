<template>
  <div id="app">
    <div id="timer">
      <span id="minutes">{{ minutes }}</span>
      <span id="middle">:</span>
      <span id="seconds">{{ seconds }}</span>
    </div>

    <div id="buttons">
      <button
        id="start"
        class="button"
        v-if="!timer"
        @click.prevent="startTimer"
      >
        Start
      </button>
      <button id="stop" class="button" v-if="timer" @click.prevent="stopTimer">
        Stop
      </button>
      <button
        id="reset"
        class="button"
        v-if="resetButton"
        @click.prevent="resetTimer"
      >
        Reset
      </button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      timer: null,
      totalTime: 25 * 60,
      defaultTime: 25,
      resetButton: false,
    };
  },
  // ========================
  methods: {
    startTimer: function () {
      this.timer = setInterval(() => this.countdown(), 1000);
      this.resetButton = true;
    },
    stopTimer: function () {
      clearInterval(this.timer);
      this.timer = null;
      this.resetButton = true;
    },
    resetTimer: function () {
      this.totalTime = this.defaultTime * 60;
      clearInterval(this.timer);
      this.timer = null;
      this.resetButton = false;
    },
    padTime: function (time) {
      return (time < 10 ? "0" : "") + time;
    },
    countdown: function () {
      if (this.totalTime >= 1) {
        this.totalTime--;
      } else {
        this.totalTime = 0;
        this.resetTimer();
      }
    },
    setTime: function (minutes) {
      this.defaultTime = minutes
      this.resetTimer();
    }
  },
  // ========================
  computed: {
    minutes: function () {
      const minutes = Math.floor(this.totalTime / 60);
      return this.padTime(minutes);
    },
    seconds: function () {
      const seconds = this.totalTime - this.minutes * 60;
      return this.padTime(seconds);
    },
  },
};
</script>

<style scoped>
#app {
  display: flex;
  align-items: center;
  width: 25%;
  margin: 5% 0 15px;
}

#timer {
  font-size: 50px;
  margin: 0 15% 5% 15%;
  display: inline-block;
  background-color: rgb(25, 34, 58);
  color: white;
}

#buttons {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}
.button {
  font-size: 20px;
  padding: 18px;
  line-height: 0;
  margin: 0 10px;
  background-color: white;
  color: black;
}
</style>