<template>
  <the-header></the-header>
  <the-nav @change-tab="changeTab"></the-nav>
  <the-board v-if="selectedTab ==0" ></the-board> 
  <about-us  v-if="selectedTab ==1"></about-us>
  <write-card v-if="selectedTab==2"></write-card>
</template>

<script>
import { defineComponent } from 'vue'
import TheHeader from "./components/TheHeader.vue"
import TheNav from "./components/TheNav.vue"
import TheBoard from "./components/TheBoard.vue"
import AboutUs from "./components/AboutUs.vue"
import WriteCard from "./components/WriteCard.vue"


export default defineComponent({
  name: 'App',
  components: {
    TheHeader,
    TheNav,
    TheBoard,
    AboutUs,
    WriteCard
  },
  data() {
  return {
    selectedTab: 0
  } 
  },
  methods: {
    changeTab(value) {
      this.selectedTab = value;
    }
  }
})
</script>

<style>

#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;

}
</style>
