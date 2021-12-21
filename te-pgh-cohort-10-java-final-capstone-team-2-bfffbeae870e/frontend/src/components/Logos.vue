<template>
    <div>
        <div class="logo">
            <div>
                <div id="bot-ball">-</div>
                <div id="bot-antenna">.</div>
                <div id="bot-head">
                    <h2 id="bot-face">{{face}}</h2>
                </div>
            </div>
            <h1 class="logo-text">AskHowie</h1>
        </div>
        <div class="spacer"></div>
        <div class="logo">
            <h1 class="logo-text-2">AskH</h1>
            <div>
                <div id="bot-ball">-</div>
                <div id="bot-antenna">.</div>
                <div id="bot-head">
                    <h2 id="bot-face">{{face}}</h2>
                </div>
            </div>
            <h1 class="logo-text-2">wie</h1>
        </div>
        <div class="spacer"></div>
        <div class="logo-3">
            <div>
                <div id="bot-ball">-</div>
                <div id="bot-antenna">.</div>
                <div id="bot-head">
                    <h2 id="bot-face">{{face}}</h2>
                </div>
            </div>
            <h1 class="logo-text-3">AskHowie</h1>
        </div>      
    </div>


</template>

<script>
export default {
    data() {
        return {
            face: "+_+",
            mainFace: "+_+",
            altFace: "+.+",
            faces: [
                "+o+",
                "^_^",
                "d^_^b",
                "+_+",
                "^o^"
            ],
            intId: null,
            count: 0
        }
    },
    methods: {
        talk() {
            this.count = 8;
            if (!this.intId) {
                this.intId = setInterval(this.change, 100);
            }
        },
        change() {
            if (this.count === 0) {
                clearInterval(this.intId);
                this.intId = null;
            }
            else {
                this.face = this.face === this.mainFace ? this.altFace : this.mainFace;
                this.count--;
            }
        }
    }
}
</script>

<style>
.logo, .logo-3 {
    display: flex;
    flex-direction: row;
    align-items: flex-end;
    background-color: rgb(20, 14, 34);
    background-color: white;
    width: auto;
    padding: 50px;
}
.logo-3 {
    flex-direction: column;
    align-items: flex-start;
    align-items: center;
    background-color: rgb(0, 178, 248);
    width: 400px;
    height: 400px;
}
.logo-3 #bot-ball {
    height: 50px;
    width: 50px;
}
.logo-3 #bot-antenna {
    height: 70px;
    width: 20px;
}
.logo-3 #bot-face {
    font-size: 180px;
    line-height: 160px;
}
.logo-3 #bot-head {
    padding: 0 10px 30px 10px;
    border-radius: 60px;
}
.logo-text, .logo-text-2, .logo-text-3 {
    font-size: 150px;
    font-family: "Bakbak One", sans-serif;
    margin: 0;
    line-height: 150px;
    color: rgb(0, 238, 255);
    color: rgb(0, 149, 248);
}
.logo-text-2 {
    margin-left: 10px;
    font-size: 200px;
    line-height: 180px;
}
h1.logo-text-3 {
    font-size: 78px;
    margin: 0 0 20px 10px;
    line-height: 20px;
    color: white;
}
.spacer {
    height: 50px;
}
</style>