<template>
  <div>
    <navigation />
    <register />
  </div>
</template>

<script>
import register from '@/components/Register.vue';
import navigation from '../components/Navigation.vue';

export default {
  components: { navigation, register }
  }
</script>

