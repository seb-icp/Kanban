<template>
    <div>
     <base-message v-for='done in doneList' :key="done.title" :title="done.title" :description="done.description"></base-message>
    </div>
</template>


<script>
import BaseMessage from './BaseMessage.vue'
export default {
  props : [
      'doneList'
  ],
  components: { BaseMessage },
  data() {
      return {
    
        title: "Build the Kanban Board",
        description: "That would be a huge step forward..."
                
      }
  }
    
}
</script>


<style scoped>




base-message {
    margin: 10px 10pxs;
}


</style>