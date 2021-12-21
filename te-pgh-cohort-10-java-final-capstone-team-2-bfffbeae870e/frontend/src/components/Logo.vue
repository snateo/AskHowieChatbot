<template>
  <div id="logo" @mousedown.prevent="openMouth" @mouseup="closeMouth" @mouseleave="mouseLeave" @mouseover="textOrange">
        <div>
            <div id="logo-ball" v-bind:style="{backgroundColor: ballColor, color: ballColor}">-</div>
            <div id="logo-antenna">.</div>
            <div id="logo-head">
                <h2 id="logo-face">{{face}}</h2>
            </div>
        </div>
        <h1 id="logo-text" v-bind:style="{color: textColor}">AskHowie</h1>
    </div>
</template>

<script>
export default {
    data() {
        return {
            face: "+_+",
            default: "+_+",
            alt: "+.+",
            textColor: "rgb(0, 149, 248)",
            ballColor: "orangered"
        }
    },
    methods: {
        openMouth() {
            this.face = this.alt;
            this.ballColor = "orange";
        },
        closeMouth() {
            this.face = this.default;
            this.ballColor = "orangered";
        },
        textOrange() {
            this.textColor = "orangered";
        },
        textBlue() {
            this.textColor = "rgb(0, 149, 248)";
        },
        mouseLeave() {
            this.closeMouth();
            this.textBlue();
        }
    }
}
</script>

<style>
#logo {
    display: flex;
    flex-direction: row;
    align-items: flex-end;
    background-color: rgb(20, 14, 34);
    background-color: white;
    width: auto;
    margin: 0 0 10px 10px;
}
#logo-text {
    font-size: 54px;
    line-height: 40px;
    font-family: "Bakbak One", sans-serif;
    margin: 0 0 0 5px;
    color: rgb(0, 149, 248);
}
#logo-ball {
  background-color: orangered;
  color: orangered;
  width: 12px;
  line-height: 12px;
  margin: 5px auto -2px auto;
  border-radius: 50%;
  float: none;
}
#logo-antenna {
  background-color: gray;
  color: gray;
  line-height: 10px;
  width: 5px;
  margin: auto;
}
#logo-face {
  text-decoration: none;
  font-family: "JetBrains Mono", monospace;
  margin: 0 5px 0 5px;
  font-size: 30px;
  padding: 0;
  padding-bottom: 5px;
  color: rgb(92, 255, 92);
  line-height: 30px;
}
#logo-head {
  padding: 0 1px 5px 1px;
  margin: auto;
  background-color: gray;
  border-radius: 15px;
}
</style>