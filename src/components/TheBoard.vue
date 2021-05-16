<template>
    <div class="container">
        <h2 class="todo"> To Do 💡 </h2>
        <h2 class="progress"> In Progress 👩‍💻 </h2>
        <h2 class="done"> Done ✅  </h2>
        <to-do class="todo-content" :todoList="todoList" @remove-from-data="removeData1"></to-do>
        <in-progress class="inprogress-content" :inProgressList="inProgressList" @remove-from-data="removeData2"></in-progress>
        <done class="done-content" :doneList="doneList" @remove-from-data="removeData3" ></done>
    </div>
</template>




<script>
import Done from "./Done.vue";
import InProgress from "./InProgress.vue";
import ToDo from "./ToDo.vue";
import BaseMessage from "./BaseMessage.vue";

import { kanban } from "../agent"
import { ref, onMounted } from "vue"

export default {
    components: {
        Done,
        InProgress,
        ToDo,
        BaseMessage,
    },
    data() {
        return {
            todoList : [
                {
                    id:0,
                    title: "Build the Kanban Board",
                    description: "That would be a huge step forward..."
                },
                {
                    id:1,
                    title : "Improve the design of the Motoko School logo",
                    description : "That's awesome"
                }
            ],
            inProgressList : [ {
                id:0,
                title: "Learn Vue",
                description : " That's why I'm building the frond end"
            }
                
            ],
            doneList : [
                {
                    id:0,
                    title : "Create a Tic Tac Toe ",
                    description : "Just waiting to deploy it!"
                }
            ]
        }
    },
    methods: {
        removeData1(title) {
            this.todoList = this.todoList.filter (todo => todo.title !== title);
            kanban.deleteCard("Todo", title);
        },
        removeData2(title) {
            console.log("Je suis bien là");
            console.log(this.inProgressList);
            this.inProgressList = this.inProgressList.filter (inprogress => inprogress.title !== title);
            console.log(this.inProgressList);
            kanban.deleteCard("In Progress", title);
        
            
        },
        removeData3(title) {
            this.doneList = this.doneList.filter (todo => todo.title !== title);
            kanban.deleteCard("Done", title);
            
        },
        show(){
            console.log(this.inProgressList);
        }
    },
    setup: () => {
    let board;
    const todoList = ref([]);
    const inProgressList = ref([]);
    const doneList= ref([]);


    const refreshBoard = async () => {
        board = await kanban.getBoard();
    //  const todoList = board.
    //  const inProgressList = await kanban
        console.log(board.columns);
        const todoList = board.columns[0];
        const inProgressList = board.columns[1];
        const doneList = board.columns[2];
        console.log(todoList);
        console.log(inProgressList);
        console.log(doneList);
    }

    onMounted(refreshBoard)

    return { board }
  },
}
</script>




<style scoped>


.container {
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