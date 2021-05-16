<template>
    <div class="container">
        <button @click="changeTab(0)"> Board 📋  </button>
        <button @click="changeTab(2)"> Write 📝 </button>
        <button @click="changeTab(1)"> About ❓</button>
    </div>
</template>

<script>
export default {
    methods: {
        changeTab(number) {
            this.$emit("change-tab", number);
        },
    
}}
</script>


<style scoped>


.container {
    display: flex;
    justify-content: space-between;
}

button {
	color: #fff !important;
	text-transform: uppercase;
    font-size: 15px;
	text-decoration: none;
	background: #434345;
	padding: 20px 40px;
	border-radius: 50px;
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;
    margin: 50px;
}

button:hover {
    text-shadow: 0px 0px 6px rgba(255, 255, 255, 1);
	-webkit-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
	-moz-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
    box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
	transition: all 0.4s ease 0s;
}

button:active {
 
  box-shadow: 0 5px #666;
  transform: translateY(4px);

}

</style>