<template>
    <div>
     <base-message v-for='todo in todoList' :key="todo.title" :title="todo.title" :description="todo.description" @delete-card="deleteCard(todo.title)"></base-message>
    </div>
</template>


<script>
import BaseMessage from './BaseMessage.vue'
export default {
  props : [
      'todoList'
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