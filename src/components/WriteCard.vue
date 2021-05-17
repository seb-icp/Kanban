<template>
    <div id="global">
          <form id="limited">
            <div class="form-control">
                <label for="title"> Title </label>
                <input id="title" name="title" type="text" ref="titleInput"/>
            </div>
            <div class="form-control">
                <label for="description"> Describe your task </label>
                <textarea id="description" name="description"  rows="3" ref="descriptionInput"/>
            </div>
            <div class="form-control" id="radiobuttons">

                <input type="radio" id="todo" name="column" value="todo" class="radio"> 
                <label for="todo" class="radio" checked>ToDo</label >
                
                <input type="radio" id="inprogress" name="column" value="inprogress" class="radio">
                <label for="in progress" class="radio"> Progress </label>

                <input type="radio" id="done" name="column" value="done" class="radio">
                <label for="done" class="radio">Done</label>

            </div>
        </form>
            <button @click="submitMessage"> Submit </button>
    </div>        
</template>



<script>
import { kanban } from "../agent"

export default {
    
    inject:['addMessage'],
    methods: {
        submitMessage() {
            const enteredName = this.$refs.titleInput.value;
            const enteredContent = this.$refs.descriptionInput.value;
            const enteredColumn = document.querySelector('input[name=column]:checked').value;
            console.log(enteredColumn);
            const sendData = async (number) => {
                await kanban.addCard(enteredName, enteredContent, number);
            }
            if (enteredColumn == "todo") {
                sendData(0); //Column todo has id 0 in our canister
            }
            else if (enteredColumn =="inprogress") {
                sendData(1); //Column todo has id 0 in our canister
            }
            else if (enteredColumn =="done") {
                sendData(2); //Column todo has id 0 in our canister
            }
            else {
                return; 
            }
            
            return;
        }
    }
}
</script>





<style  scoped>





#global {
    max-width: 300px;
    width: 70%;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
    padding: 1rem;
    margin: 2rem auto;
    max-width: 40rem;
}

label {
  font-weight: bold;
  display: block;
  margin-bottom: 0.5rem;
  margin: 0 auto;
}

input,
textarea {
  display: block;
  width: 100%;
  font: inherit;
  padding: 0.15rem;
  border: 1px solid #ccc;
}

input:focus,
textarea:focus {
  outline: none;
  border-color: #3a0061;
  background-color: #f7ebff;
}

.form-control {
  margin: 1rem 0;
  max-width: 400px;
}

#radiobuttons {
    display: flex;
    justify-content: space-between;
}


.radio {
    display: inline;
    justify-content: space-around;
    
}
</style>