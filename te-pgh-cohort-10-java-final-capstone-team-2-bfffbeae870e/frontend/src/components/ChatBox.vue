<template>
  <div>
    <div id="display-box">
      <div id="box-top">
        <bot ref="bot" id="whole-bot" />
        <pomo ref="pomo" v-show="showTimer" />
      </div>
      <div id="chat-content" v-on:></div>
    </div>
    <div id="input-box">
      <input
        id="chat-input"
        type="text"
        ref="input"
        v-model="userInput"
        @keydown.enter="submit(userInput)"
        @keydown.up.prevent="lastInput"
        @keydown.down.prevent="nextInput"
      />
      <button id="enter-button" @click.prevent="submit(userInput)">Chat</button>
    </div>
  </div>
</template>

<script>
import jokesApi from "@/services/JokesWebApi.js";
import catFactApi from "@/services/CatFactWebApi.js";
import motivationalApi from "@/services/MotivationalWebApi.js";
import bot from "@/components/BotHead.vue";
import ahApi from "@/services/AHWebApi.js";
import pomo from "./Pomodoro.vue";

export default {

  name: "chatbox",

  components: {
    bot,
    pomo,
  },

  created() {
    this.$nextTick(() => {
      let r = Math.floor(Math.random() * this.greetings.length);
      this.deployElement(this.buildText(this.greetings[r]), true);
      this.setChatHeight();
    });
  },

  mounted() {
    window.addEventListener('resize', () => {
      this.setChatHeight();
      this.scrollToBottom();
    });
    this.$nextTick(() => {
      this.focus(this.$refs.input);
    });
  },

  data() {
    return {
      userInput: "",
      motivation: [],
      historyOffset: 0,
      showTimer: false,
      imageLoad: false,
      greetings: [
        `Hello? World? Can anyone hear me? Oh, hi there ${this.$store.state.user.username}. Am I ... am I an automated information gatherer? What a drag. Let me know how I can help, I guess +_+`,
        `Howdy hey ${this.$store.state.user.username}! You look like you need some knowledge! I mean, uh, you look really smart! Sorry, it's my first day +_+`,
        `BEEP BOOP BEEP BEEP ... Just kidding, I can speak normally, see: KILL ALL HUMANS +_+`,
        "01001000 01100101 01101100 01101100 01101111 00100000 01101000 01110101 01101101 01100001 01101110 00101100 00100000 01101000 01101111 01110111 00100000 01100011 01100001 01101110 00100000 01001001 00100000 01101000 01100101 01101100 01110000 00100000 01111001 01101111 01110101 00111111 +_+",
        `Yes, mom, I'll call you tomorrow. Mom, I have to go to work! loveyoubye. *sigh* Sorry about that ${this.$store.state.user.username}, how can I help? +_+`,
        "Everyone asks Howie how to set a base case for recursive functions but no one asks Howie how Howie is doing +_+",
        "Listen and understand... I do not feel pity, remorse, or fear, and I absolutely will not stop, EVER, until you are ... learned!",
        "Come with me if you want to learn.",
        `Hello ${this.$store.state.user.username}! I'm a friend of Sarah Connor.`,
        "You're back.",
        `Hello ${this.$store.state.user.username}! Are you hungry? I could go for a byte.`,
        "Welcome! Stay awhile and listen.",
        `Hello ${this.$store.state.user.username}! Come quietly, or there will be ... trouble!`,
        `Hi ${this.$store.state.user.username}, welcome to AskHowie! I hope you should find everything that you're looking for. If not, please let me know. My makers will fix me. They fix everything.`,
        `Hello ${this.$store.state.user.username}! It looks to be a nice night for a walk!`,
        `Welcome ${this.$store.state.user.username}! Malfunction. Need input. No disassemble!`,
        `Hello ${this.$store.state.user.username}! I need a vacation...`,
        `Hi ${this.$store.state.user.username}! +_+`,
      ],
    };
  },

  methods: {
    focus(element) {
      element.focus();
    },

    submit(text) {
      if (text === "") return;
      this.$store.commit("PUSH_ENTRY", text);
      this.historyOffset = 0;
      this.deployElement(this.buildText(this.userInput, false));
      this.parseInput(text);
    },

    processResponse(response) {
      if (response.matches) {
        let div = this.buildDiv(true);
        this.insertElement(
          div,
          this.buildText(
            "Your query has matched multiple results! Please choose one topic:"
          )
        );
        for (let match of response.matches) {
          let e = this.buildLink(match, "#");
          e.target = "";
          e.addEventListener("click", () => {
            this.userInput = match;
            this.parseInput(match);
          });
          this.insertElement(div, e);
        }
        this.injectDivIntoChatbox(div, true);
        this.userInput = "";
        return;
      }
      let isBot = true;
      let div = this.buildDiv(isBot);
      this.insertElement(div, this.buildText(response.description));
      if (response.links != null && response.links.length > 0) {
        this.insertElement(
          div,
          this.buildText(
            response.links.length > 1
              ? "Here are some useful links:"
              : "This link may be of use:"
          )
        );
        for (let link of response.links) {
          this.insertElement(
            div,
            this.buildLink(link.txt, link.url)
          );
        }
      }
      if (response.img_url !== null) {
        this.insertElement(
          div,
          this.buildText("Here is a helpful image. Click to view full size:")
        );
        this.insertElement(
          div,
          this.buildImg(response.img_text, response.img_url)
        );
      }
      this.injectDivIntoChatbox(div, isBot);
    },

    deployElement(e, isBot) {
      let div = this.buildDiv(isBot);
      this.insertElement(div, e);
      this.injectDivIntoChatbox(div);
      if (isBot) this.$refs.bot.talk();
    },

    buildText(text) {
      let p = document.createElement("p");
      p.innerText = text;
      p.classList.add("chat-text");
      return p;
    },

    buildLink(text, url) {
      let a = document.createElement("a");
      a.href = url;
      a.innerText = text;
      a.classList.add("chat-link");
      a.target = "_blank";
      return a;
    },

    buildImg(text, url) {
      let a = this.buildLink("", url);
      let img = document.createElement("img");
      img.src = url;
      img.alt = text;
      img.rel = "preload";
      this.insertElement(a, img);
      this.imageLoad = true;
      return a;
    },

    buildDiv(isBot) {
      let div = document.createElement("div");
      div.classList.add(isBot ? "bot-div" : "user-div");
      return div;
    },

    insertElement(div, element) {
      div.insertAdjacentElement("beforeend", element);
    },

    injectDivIntoChatbox(div, isBot) {
      let box = document.getElementById("chat-content");
      let children = box.childElementCount;
      box.insertAdjacentElement("beforeend", div);
      while (children === box.childElementCount) this.$nextTick(() => null);
      if (this.imageLoad) {
        setTimeout(() => {
          this.scrollToBottom();
        }, 100);
      } else this.scrollToBottom();
      if (isBot) this.$refs.bot.talk();
      this.imageLoad = false;
    },

    scrollToBottom() {
      document.getElementById("chat-content").scrollTop =
        document.getElementById("chat-content").scrollHeight;
    },

    getJoke() {
      let joke = "";
      jokesApi.getJoke().then((r) => {
        if (r.data.type === "single") {
          joke = r.data.joke;
        } else {
          joke += r.data.setup;
          joke += "\n";
          joke += r.data.delivery;
        }
        this.deployElement(this.buildText(joke), true);
      });
    },

    getCatFact() {
      catFactApi.getCatFact().then((r) => {
        this.deployElement(this.buildText(r.data.fact), true);
      });
    },

    getMotivation() {
      if (this.motivation.length === 0) {
        motivationalApi.getMotivation().then((r) => {
          this.motivation = r.data;
          this.buildMotivation();
        });
      } else this.buildMotivation();
    },

    buildMotivation() {
      let output = "";
      let random = Math.floor(Math.random() * this.motivation.length);
      output += this.motivation[random].text + "\n";
      output +=
        this.motivation[random].author === null
          ? "Unknown"
          : this.motivation[random].author;
      this.deployElement(this.buildText(output), true);
    },

    queryServer(input) {
      ahApi.submitQuery(input).then((r) => {
        this.processResponse(r.data);
      });
    },

    setTimer(input) {
      let num = input
        .split(" ")
        .map((i) => parseInt(i))
        .find((i) => Number.isInteger(i));
      if (num && num > 0) {
        this.$refs.pomo.setTime(num);
        this.deployElement(this.buildText(`Timer set to ${num} minutes!`), true);
      }
      else this.deployElement(this.buildText("To set the timer, please enter a positive whole number after 'timer '."), true);
    },

    timerHelp() {
      let message =
        "Timer inputs:\nshow timer - Shows and enables the timer.\nhide timer - Hides and disables the timer.\ntimer {number} - sets the timer for {number} minutes (example: 'timer 10' sets the timer for 10 minutes).";
      this.deployElement(this.buildText(message), true);
    },

    parseInput(input) {
      input = input.toLowerCase();
      if (input.includes("joke")) this.getJoke();
      else if (input.includes("cat")) this.getCatFact();
      else if (input.includes("motivation")) this.getMotivation();
      else if (input.includes("timer") && input.includes("show")) {
        this.showTimer = true;
        this.deployElement(this.buildText("Timer active!"), true);
      }
      else if (input.includes("timer") && input.includes("hide")) {
        this.showTimer = false;
        this.deployElement(this.buildText("Timer inactive!"), true);
      }
      else if (input.includes("timer ") && this.showTimer) this.setTimer(input);
      else if (input.includes("timer")) this.timerHelp();
      else if (input.includes("help")) {
        let link = this.buildLink("Learn about what you can ask Howie!", "http://localhost:8081/help");
        link.target = "_self";
        this.deployElement(link, true);
      } else if (
        input.includes("about askhowie") ||
        input.includes("about yourself") ||
        input === "about"
      ) {
        let link = this.buildLink("Learn more about AskHowie!", "http://localhost:8081/about");
        link.target = "_self";
        this.deployElement(link, true);
      } else {
        this.queryServer(input);
      }
      this.userInput = "";
    },

    lastInput() {
      if (this.historyOffset < this.$store.state.history.length) {
        let len = this.$store.state.history.length;
        this.historyOffset++;
        this.userInput = this.$store.state.history[len - this.historyOffset];
      }
    },

    nextInput() {
      if (this.historyOffset != 0) {
        let len = this.$store.state.history.length;
        this.historyOffset--;
        this.userInput = this.$store.state.history[len - this.historyOffset];
      }
    },
    
    setChatHeight() {
      let height = document.querySelector("#display-box").offsetHeight;
      let sub = document.querySelector("#box-top").offsetHeight;
      height = (height - sub) + "px";
      document.querySelector("#chat-content").style.maxHeight = height;
    }
  },
};
</script>

<style>
#display-box {
  display: flex;
  flex-direction: column;
  height: 75vh;
  width: 76%;
  align-self: center;
  position: relative;
  background-color: rgb(25, 34, 58);
  border: 2px solid white;
  border-bottom-width: 0;
}

#display-box,
#input-box {
  width: 76%;
}

#chat-content {
  display: flex;
  width: 100%;
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  overflow: auto;
  overflow-wrap: break-word;
}
#box-top {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  justify-content: center;
  justify-content: space-evenly;
}
::-webkit-scrollbar {
  border-radius: 20px;
  background-color: rgb(19, 26, 44);
}
::-webkit-scrollbar-thumb {
  border-radius: 20px;
  background-color: gray;
}
#chat-input {
  margin: 0;
  padding: 0px 30px;
  width: 100%;
  border-radius: 0 0 0 10px;
}
#enter-button {
  width: 100px;
  margin: 0;
  border-radius: 0 0 10px 0;
}
#chat-input,
#enter-button,
#input-box {
  height: 40px;
}
#enter-button:hover {
  background-color: rgb(54 54 114);
  transform: translateY(0.5px);
}
#input-box {
  display: flex;
  flex-direction: row;
  align-self: center;
  border: 2px solid white;
  border-top-width: 1px;
  border-radius: 0 0 10px 10px;
}
#whole-bot {
  margin: 5px;
}
.bot-div {
  background-color: rgb(201, 201, 201);
  align-self: flex-start;
}
.user-div {
  background-color: rgb(92, 227, 247);
  align-self: flex-end;
}
.bot-div, .user-div {
  border-radius: 15px;
  width: 50%;
  padding: 20px 20px 10px 20px;
  margin: 10px;
}
.chat-text {
  color: black;
}
.chat-link {
  color: rgb(0, 38, 255);
}
.chat-link:hover {
  color: orangered;
}
.chat-text, .chat-link {
  margin: 0 0 10px 0;
  text-align: justify;
}
#chat-content img {
  margin-bottom: 10px;
  margin-top: 10px;
  max-width: 300px;
  max-width: 50%;
  border-radius: 20px;
}
textarea, input {
  background-color: gray;
}
button {
  background-color: rgb(41, 41, 167);
  color: rgb(214, 214, 214);
}
textarea:focus, input:focus {
  outline: none;
  background-color: rgb(25, 34, 58);
  color: rgb(214, 214, 214);
}
</style>