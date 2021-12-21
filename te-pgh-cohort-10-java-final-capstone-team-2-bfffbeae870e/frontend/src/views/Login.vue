<template>
  <div>
    <navigation />
    <login-form />
  </div>

</template>

<script>
import loginForm from '@/components/LoginForm.vue';
import navigation from '@/components/Navigation.vue';

export default {
  components: {
    loginForm,
    navigation
    }
}
</script>

<style>

  div {
    display: flex;
    flex-direction: column;
  }

</style>