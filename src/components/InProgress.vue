<template>
    <div>
     <base-message v-for='progress in inprogressList' :key="progress.title" :title="progress.title" :description="progress.description" @delete-card="deleteCard(progress.title)"></base-message>
    </div>
</template>


<script>
import BaseMessage from './BaseMessage.vue'
export default {
  props : [
      'inprogressList'
  ],
  components: { BaseMessage },
  methods: {
    deleteCard(title) {
      console.log(title);
      this.$emit('delete-card', title);
    }
  }
    
}
</script>


<style scoped>




base-message {
    margin: 10px 10pxs;
}


</style>