<template>
    <div id="nav">
        <div>
            <router-link class="routes" v-bind:to="{ name: 'chatbox' }">
            <logo />
            </router-link>
        </div>
        <div id="links">
            <router-link class="routes" v-bind:to="{ name: 'about'}">About</router-link>
            <router-link class="routes" v-bind:to="{name: 'help'}">Help</router-link>
            <router-link class="routes" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
        </div>
    </div>
</template>

<script>
import logo from '@/components/Logo.vue';
export default {
    components: {
        logo
    },

    data() {
        return {}
    },

    computed: {
    }
}
</script>

<style>

    #logo-image {
        max-height: 60px;
    }

    .routes:hover{
        color: orangered
    }
    .routes{
        color: #0b507a;
        text-decoration: none;
        font-size: 25px;
    }
    
</style>