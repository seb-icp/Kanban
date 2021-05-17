<template>
    <div>
     <base-message v-for='progress in progressList' :key="progress.title" :title="progress.title" :description="progress.description"></base-message>
    </div>
</template>


<script>
import BaseMessage from './BaseMessage.vue'
export default {
  props : [
      'inprogressList'
  ],
  components: { BaseMessage },

    
}
</script>


<style scoped>




base-message {
    margin: 10px 10pxs;
}


</style>