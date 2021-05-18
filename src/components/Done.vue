<template>
    <div>
     <base-message v-for='done in doneList' :key="done.title" :title="done.title" :description="done.description" @delete-card="deleteCard(done.title)"></base-message>
    </div>
</template>


<script>
import BaseMessage from './BaseMessage.vue'
export default {
  props : [
      'doneList'
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