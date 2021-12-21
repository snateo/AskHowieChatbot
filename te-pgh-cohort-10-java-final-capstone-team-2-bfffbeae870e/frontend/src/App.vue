<template>
  <div id="app">
    <router-view />
  </div>
</template>

<style>

  @import url('https://fonts.googleapis.com/css2?family=Inter&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@500&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Bakbak+One&display=swap');

  body {
    background-color: rgb(26, 28, 30);
    font-family: 'Inter', sans-serif;
  }

  input, button {
    height: 1.5rem;
    margin: 5px 0px 5px 0px;
    border-radius: 6px;
    border: 0px;
  }

  input:focus {
    outline: none;
  }

  #form-box {
    width: 400px;
    height: 400px;
    background-color: rgb(54, 186, 238);
    border-radius: 3px;
    align-self: center;
    margin-top: 50px;
  }

  #username-group, #password-group, #confirmedPassword-group {
  display: flex;
  flex-direction: column;
  width: 100%;
  }

  .form-signin, .form-register {
  height: 80%;
  width: 80%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin: auto;
  }

  .article{
    display: flex;
    flex-direction: column;
    align-self: center;
    color: #dfdfdf;
    padding: 10px 0 50px;
    width: 700px;
    min-height: 75vh;
  }
  .article-container, .article {
    background-color:#0b507a;
    border-radius: 0 0 10px 10px;
  }
  #nav, .article-container {
    margin: 0;
    width: 76%;
    align-self: center;
    padding: 2px;
  }
  #nav {
    background-color: white;
    display: flex;
    flex-direction: row;
    align-items: center;
    border-radius: 10px 10px 0 0;
    }
  #links {
    display: flex;
    width: 35%;
    flex-direction: row;
    justify-content: space-evenly;
    flex-grow: .6;
    font-size: 1.3rem;
    }
  .form-control {
    background-color: white;
  }
  button.form-control {
    color: black;
  }
    

</style>