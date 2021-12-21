<template>
  <div>
    <navigation />
    <chat-box />
  </div>
</template>

<script>
import ChatBox from '../components/ChatBox.vue'
import Navigation from '../components/Navigation.vue'
export default {
  components: { Navigation, ChatBox },

}
</script>

<style>

</style>