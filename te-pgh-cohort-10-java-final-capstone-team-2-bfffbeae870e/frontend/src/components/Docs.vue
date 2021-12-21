<template>
  <div>
    <h1>Documentation</h1>
    <h2>What can I ask Howie?</h2>
    <p>
      AskHowie was designed to provide resources to coding students and
      professionals, with an emphasis on
      <a class="link" href="https://www.techelevator.com/" target="_blank">Tech Elevator</a>
      students and alumni. To interact with Howie, go to the Chat page and input
      requests. All user input is case-insensitive. You can simply enter keywords, or enter full sentences - Howie
      will do his best to answer your questions!
    </p>
    <br />
    <h3>Pomodoro Timer</h3>
    <p>
      Howie can provide a timer right in the chat window! Here are the related
      commands:
    </p>
    <li>timer - Howie will remind you of the timer commands.</li>
    <li>
      show timer - Shows and enables the timer in the top of the chat window.
      Once enabled, use the buttons to start, stop, and reset the timer.
    </li>
    <li>
      timer {minutes} - If enabled, sets the timer for the given number of
      minutes (example: "timer 10" sets the timer for 10 minutes). The default
      time is 25 minutes.
    </li>
    <li>hide timer - Hides and disables the timer</li>
    <br />
    <h2>List of keywords</h2>
    <h3>Use these keywords to interact with Howie!</h3>
    <p v-for="keyword in keywords" v-bind:key="keyword">{{ keyword }}</p>
  </div>
</template>

<script>
import ahApi from "@/services/AHWebApi.js";

export default {
  beforeMount() {
    ahApi.getKeywordsAndTitles().then((r) => {
      let kw = r.data;
      this.keywords = kw.sort();
    });
  },

  data() {
    return {
      keywords: [],
    };
  },
};
</script>

<style scoped>
p {
  margin: 0.2rem;
}
.link {
  color: white;
}
.link:hover {
  color: orangered;
}
.routes {
  color: orangered;
  text-decoration: none;
  font-size: 16px;
}
</style>