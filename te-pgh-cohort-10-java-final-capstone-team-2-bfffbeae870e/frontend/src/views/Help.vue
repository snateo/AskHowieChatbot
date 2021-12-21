<template>
    <div>
        <navigation />
        <div class="article-container">
            <div class="article">
                <docs />
            </div>               
        </div>
    </div>

</template>

<script>
import navigation from '@/components/Navigation.vue';
import docs from '@/components/Docs.vue';
export default {
    name: "help",
    components: {
        navigation,
        docs
    }

}
</script>

<style>

</style>