<template>
  <the-header></the-header>
  <the-nav @change-tab="changeTab" ></the-nav>
  <div class="container-board" v-if="selectedTab ==0" >
        <h1> {{ numberCard }} </h1>
        <h2 class="todo"> To Do 💡 </h2>
        <h2 class="progress"> In Progress 👩‍💻 </h2>
        <h2 class="done" @click="updateBoard"> Done ✅  </h2>
        <to-do class="todo-content" :todoList="todoList"></to-do>
        <in-progress class="inprogress-content" :inProgressList="inProgressList" ></in-progress>
        <done class="done-content" :doneList="doneList" ></done>
  </div>
  <about-us  v-if="selectedTab ==1"></about-us>
  <write-card v-if="selectedTab==2" ></write-card>
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
import { ref, onMounted } from "vue"

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
    selectedTab: 1
  } 
  },
  methods: {
    changeTab(value) {
      this.selectedTab = value;
      this.updateBoard();
    },
    updateBoard() {
            console.log("Start...")

            const numberCard = ref (0);

            const howManyCards = async () => {
            numberCard.value = await kanban.howManyCards();
            return( numberCard.value);
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
                    console.log("Do we go here?")
                    console.log(cardList);
                }

                for (let i=0 ; i< x ; i++) {
                    let column = cardList[i].ok.columnId; // .ok because the result was of type Result 
                    console.log(column);
                    if (column == 0 ) {
                        todoList.push(cardList[i].ok);
                    }
                    else if (column == 1 ) {
                        inProgressList.push(cardList[i].ok);
                    }
                    else {
                        doneList.push(cardList[i].ok);
                    }
                    
                }

                this.cardList = cardList;
                this.todoList = todoList;
                this.inProgressList = inProgressList;
                this.doneList = doneList;
            

                console.log(this.cardList);
                return;
            }

        refreshBoard();

    },
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
