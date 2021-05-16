<template>
    <div>
     <base-message v-for='todo in todoList' :key="todo.title" :title="todo.title" :description="todo.description"></base-message>
    </div>
</template>


<script>
import BaseMessage from './BaseMessage.vue'
export default {
  props : [
      'todoList'
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