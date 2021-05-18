<template>
  <the-header></the-header>
  <the-nav @change-tab="changeTab" ></the-nav>
  <div class="container-board" v-if="selectedTab ==0" >
        <h1> {{ numberCard }} </h1>
        <h2 class="todo"> To Do 💡 </h2>
        <h2 class="progress"> In Progress 👩‍💻 </h2>
        <h2 class="done" @click="updateBoard"> Done ✅  </h2>
        <to-do class="todo-content" :todoList="todoList" @delete-card="deleteCard1"></to-do>
        <in-progress class="inprogress-content" :inprogressList="inProgressList" @delete-card="deleteCard2" ></in-progress>
        <done class="done-content" :doneList="doneList" @delete-card="deleteCard3"></done>
  </div>
  <about-us  v-if="selectedTab ==1"></about-us>
  <write-card v-if="selectedTab==2" @add-message="addMessage"></write-card>
</template>

<script>
import { defineComponent } from 'vue'
import TheHeader from "./components/TheHeader.vue"
import TheNav from "./components/TheNav.vue"
import AboutUs from "./components/AboutUs.vue"
import WriteCard from "./components/WriteCard.vue"
import Done from "./components/Done.vue";
import InProgress from "./components/InProgress.vue";
import ToDo from "./components/ToDo.vue";
import BaseMessage from "./components/BaseMessage.vue";

import { kanban } from "./agent"
import { ref } from "vue"

export default defineComponent({
  name: 'App',
  components: {
    TheHeader,
    TheNav,
    AboutUs,
    WriteCard,
    Done,
    InProgress,
    ToDo,
    BaseMessage, //Too much component 
  },
  data() {
  return {
    selectedTab: 1,
    cardList : [],
    todoList : [],
    inProgressList : [],
    doneList : [],
  } 
  },
  created() {
    this.updateBoard();
  },
  methods: {
    changeTab(value) {
      this.selectedTab = value;
      // this.updateBoard(); //Pire méthode du monde 
    },
    updateBoard() {
            console.log("Start...")

            const numberCard = ref (0);

            const howManyCards = async () => {
            numberCard.value = await kanban.howManyCards();
            return (numberCard.value)
            }

            const refreshBoard = async () => {
                let x = await howManyCards();
                let cardList = [];
                let todoList = [];
                let inProgressList = [];
                let doneList = [];

                console.log(x);
                for (let i=0 ; i< x ; i++)  {
                    let card = await kanban.readCard(i); //Not optimized at all
                    cardList.push(card);
                }

                for (let i=0 ; i< x ; i++) {
                    try {         //We need a try catch because some card can be deleted and of type #err
                       let column = cardList[i].ok.columnId; 
                          if (column == 0 ) {
                          todoList.push(cardList[i].ok);
                        }
                          else if (column == 1 ) {
                          inProgressList.push(cardList[i].ok);
                        }
                          else if (column == 2) {
                          doneList.push(cardList[i].ok);
                        }
                    }
                    catch {
                      console.log("C'est une carte supprimée")
                    }
                    
                }

                this.cardList = cardList; //cardList contains ALL cards deleted or not to keep track of the index 
                this.todoList = todoList; //Other list contains only cards not deleted 
                this.inProgressList = inProgressList;
                this.doneList = doneList;
                console.log(this.todoList);
                console.log(this.cardList);
            
                return;
            }

        refreshBoard();

    },
    deleteCard(titleCard) {
      let index; 
      for (let i=0 ; i<this.cardList.length ; i++) {
        try {
            if (this.cardList[i].ok.title == titleCard ) {
            index =i;
            }
        }
        catch { 
            
        }
      }

        kanban.deleteCard(index);

    },
    deleteCard1(titleCard) {
     
      this.todoList = this.todoList.filter ( todo => todo.title != titleCard);
      this.deleteCard(titleCard);
    },
    deleteCard2(titleCard) {
      
      this.inProgressList = this.inProgressList.filter ( inprogress => inprogress.title != titleCard);
      this.deleteCard(titleCard);
    },
    deleteCard3(titleCard) {
      
      this.doneList = this.doneList.filter ( done => done.title != titleCard);
      this.deleteCard(titleCard);
    },
    addMessage(enteredName , enteredContent , enteredColumn) {
      
       if (enteredColumn == "todo") {
               
                this.todoList.push({title : enteredName, description : enteredContent , columnId : 0});
                this.cardList.push({ok:{title:enteredName , description : enteredContent , columnId : 0}})
          }
      else if (enteredColumn =="inprogress") {
                
                this.inProgressList.push({title : enteredName, description : enteredContent , columnId : 1});
                this.cardList.push({ok:{title:enteredName , description : enteredContent , columnId : 1}})
          }
      
      else if (enteredColumn =="done") {
              
               this.doneList.push({title : enteredName, description : enteredContent , columnId : 2});
               this.cardList.push({ok:{title:enteredName , description : enteredContent , columnId : 2}})
          }
      else {
                return; 
      } 
    }

  }})
</script>


<style >


#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;

}


</style>

<style scoped>


.container-board {
    min-width: 700px;
    background-color: rgb(163, 163, 168);
    height: 1000px;   
    width: 90%;
    margin: 0px auto;
    display: grid;
    grid-template-columns: 33.3% 33.4% 33.3% ;
    grid-template-rows: 15% 80%;
    border: 1px solid black

}


.todo {
    grid-area: 1 / 1 / 2 / 2  ;
    display: flex;
    justify-content: center;
    align-items: center;
    border-right: 1px solid white;
    border-bottom: 1px solid white;

    padding: 0;
}


.progress {
    grid-area: 1 / 2 / 2 / 3 ;
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: 1px solid white;
    border-right: 1px solid white;
}

.done {
    grid-area: 1 / 3 / 2 / 4 ;
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: 1px solid white;
}


.todo-content {
    grid-area: 2 / 1 / 3 / 2 ;
    border-right: 1px solid white;
}



.inprogress-content {
    grid-area: 2 / 2 / 3 / 3 ;
    border-right: 1px solid white;
}

.done-content {
    grid-area: 2 / 3 / 3 / 4 ;
}


</style>
