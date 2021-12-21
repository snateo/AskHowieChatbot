<template>
  <div>
    <div id="bot-ball" v-bind:style="{backgroundColor: ballColor, color: ballColor}">-</div>
    <div id="bot-antenna">.</div>
    <div id="bot-head">
      <h2 id="bot-face">{{ face }}</h2>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      face: "+_+",
      mainFace: "+_+",
      altFace: "+.+",
      faces: ["+o+", "^_^", "d^_^b", "+_+", "^o^"],
      intId: null,
      count: 0,
      ballColor: "orangered"
    };
  },
  methods: {
    talk() {
      this.count = 8;
      if (!this.intId) {
        this.intId = setInterval(this.change, 100);
      }
    },
    change() {
      if (this.count === 0) {
        clearInterval(this.intId);
        this.intId = null;
        this.face = this.mainFace;
        this.ballColor = "orangered";
      } else {
        if (this.ballColor != "orange") this.ballColor = "orange";
        this.face = this.face === this.mainFace ? this.altFace : this.mainFace;
        this.count--;
      }
    },
  },
};
</script>

<style>
#bot-ball {
  background-color: orangered;
  color: orangered;
  width: 25px;
  line-height: 25px;
  margin: 5px auto -2px auto;
  border-radius: 50%;
  float: none;
}
#bot-antenna {
  background-color: gray;
  color: gray;
  line-height: 30px;
  width: 10px;
  margin: auto;
}
#bot-face {
  text-decoration: none;
  font-family: "JetBrains Mono", monospace;
  margin: 0 5px 0 5px;
  font-size: 90px;
  padding: 0;
  padding-bottom: 10px;
  color: rgb(92, 255, 92);
  line-height: 5rem;
}
#bot-head {
  padding: 0 5px 15px 5px;
  margin: auto;
  margin-bottom: 20px;
  background-color: gray;
  border-radius: 30px;
}
</style>