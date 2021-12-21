<template>
  <div class="main">
    <navigation />
    <div class="article-container">
      <div class="article">
        <h1>About AskHowie</h1>
        <p>
          Welcome to AskHowie, the revolutionary way to fetch information from
          the internet! Who needs google when you have Howie at your disposal?
          AskHowie is an interactive chat bot that can assist you in elevating
          your skills by giving you information to ensure you will be at your
          best for landing a job in tech! Whether you need to brush up on loops,
          seek advice on making a resume that would even bring a tear to your
          pathway director's eye, or just a much needed motivational quote to
          get you through the day; Howie has your back!
        </p>
        <br>

        <img src="http://localhost:8080/images/askhowiedemo.gif" alt="An animated gif of Howie in action">

        <h2 class="title">Meet the Team Behind AskHowie:</h2>
        <img class="image" src="@/assets/images/KentonBandyPicture.jpg" />
        <h3 class="names">Kenton Bandy</h3>
        <a class="link" href="https://github.com/kentonbandy">Github</a>
        <a class="link" href="https://www.linkedin.com/in/kentonbandy/">LinkedIn</a>
        <ul>
          <li>
            My hobbies include biking, writing electronic music, gaming, and
            sneaking cheeky recursive functions in my Tech Elevator homework to
            see if anyone's paying attention.
          </li>
          <li>My background is in classical trumpet performance.</li>
          <li>
            Word across cable / swim like fish to bearded friend / but is he
            listen? -Brian
          </li>
        </ul>
        <img class="image" src="../assets/images/ChrisNicolettiPicture.jpg" />
        <h3 class="names">Christopher Nicoletti</h3>
        <a class="link" href="https://www.linkedin.com/in/christopher-nicoletti/">LinkedIn</a>
        <ul>
          <li>
            I can quote almost any episode of "It's Always Sunny in
            Philadelphia"
          </li>
          <li>I have had a bunch of extra roles in some Netflix series.</li>
          <li>
            I owned the highest rank in Halo 3 which was a level 50 in multiple
            ranked game modes including slayer, Team objective, doubles, and
            swat.
          </li>
          <li>
            "Home is where you make it!" -Rambling guy from the movie Joe Dirt
          </li>
        </ul>
        <img class="image" src="../assets/images/NateODonnellPicture.png" />
        <h3 class="names">Nathan O'Donnell</h3>
        <a class="link" href="https://github.com/snateo">Github</a>
        <a class="link" href="https://www.linkedin.com/in/nate-odonnell/">LinkedIn</a>
        <ul>
          <li>
            I enjoy gaming, collecting various hot sauces, and music trivia.
          </li>
          <li>"If you're not first, you're last." -Ricky Bobby</li>
        </ul>
        <img class="image" src="../assets/images/RomanOliverPicture.jpeg" />
        <h3 class="names">Roman Oliver</h3>
        <a class="link" href="https://github.com/Rohanzeus">Github</a>
        <a class="link" href="https://www.linkedin.com/in/roman-m-oliver/">LinkedIn</a>
        <ul>
          <li>My interests include Virtual Reality and 3D Printing.</li>
          <li>I also enjoy playing ice hockey and building models.</li>
          <li>
            "Society grows great when old men plant trees whose shade they know
            they shall never sit in." -Anonymous Greek Proverb
          </li>
        </ul>
        <img class="image" src="../assets/images/MattKirbyPicture.jpg" />
        <h3 class="names">Matthew Kirby</h3>
        <a class="link" href="https://github.com/mrkirby88">Github</a>
        <a class="link" href="https://www.linkedin.com/in/matthew-r-kirby/">LinkedIn</a>
        <ul>
          <li>
            One of my favorite hobbies is I love to use my smoker for different
            meats! It is quite the tasty challenge!
          </li>
          <li>
            I graduated from West Virginia University and bleed gold and blue!
            Go Mountaineers!!.
          </li>
          <li>
            "Your life does not get better by chance, it gets better by change."
            -Jim Rohn.
          </li>
        </ul>
      </div>
    </div>

    <body></body>
  </div>
</template>

<script>
import navigation from "../components/Navigation.vue";

export default {
  components: { navigation },
};
</script>

<style scoped>
.header {
  align-items: center;
  text-decoration: underline;
  color: #ffffff;
  padding: 5px;
  font-size: 80px;
}
.title {
  color: #ffffff;
  font-size: 40px;
}
.link,
.names {
  margin: 0 0 10px;
  color: white;
}
.link:hover {
  color: orangered;
}
.names {
  font-size: 2em;
}
li,
.paragraph {
  font-size: 1em;
  margin-bottom: 5px;
  color: #dfdfdf;
}
li {
  font-style: italic;
}
.image {
  width: 300px;
  margin: 20px 0;
  border-radius: 20%;
}
.main {
  background-color: rgb(26, 28, 30);
}
</style>