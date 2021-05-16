<template>
    <div class="container">
        <div>
            <h1> Motoko School </h1>
            <img src="../assets/Motoko.png" alt="logo" id="motoko">
        </div>
        
        <span class="separator"></span>
        <h2> Kanban board </h2>
    </div>

</template>



<style scoped>

.container {
	text-align: center;
	background: #434345;
	color: white;
	padding-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
    padding: 0.8rem;
    margin: 1rem auto;
    max-width: 90%;
    border-radius: 50px;
}

.separator {
	width: 150px;
	height: 1px;
	margin: 0px auto;
	display: block;
	background: #999999;
}


.img2 {
    width: 150px;
    background-image: url('../assets/Motoko.png');
    background-size:contain;
    background-repeat: no-repeat;
    
    }




#motoko {
    width: 60px;
    position: relative;
    top: -10px;
}

h1 {
 font-size: 50px;
}

h2 {
    font-size: 40px;
}

</style>