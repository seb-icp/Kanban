<template>
    <div class="global">
        <h4> {{title}} </h4>
        <p> {{ description }}</p>
        <div class="delete" @click="destroy">❌ </div>
    </div>
</template>


<script>
export default {
 props : ['title','description'],
 methods: {
     destroy(e) {
         let elementToDestroy = e.path[1];
         console.log(elementToDestroy); 
         this.$emit("destroy",this.title);
         elementToDestroy.style.display = "none";
        
    }
 }   
}
</script>


<style scoped>
.global {
 background-color: #f1f1f1;
  position: relative;
  display: flex;
  flex-direction: column;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
  padding: 1rem;
  margin: 2rem 10px;
  max-width: 40rem;
}

.delete {
    border-radius: 50px ;
    width: 30px;
    height: 15px;
    position: absolute;
    right: 5px;
    top: 5px;
}


h4 {
    font-size: 20px;
    padding: 0;
    margin: 0;
    

}

p {
    margin: 10px;
    word-wrap: break-word;
    
}

</style>
