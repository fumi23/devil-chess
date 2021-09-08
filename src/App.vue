<template>
  <div class="board">
    <div
      class="cell"
      v-for="(hasPiece, index) in state"
      :key="index"
      :class="cellClass(index)"
      @click="toggle(index)"
    >
      <span v-if="hasPiece" class="piece">♟</span>
    </div>
  </div>
  <div class="score">
    <label for="output">チェス盤の状況を数値化したもの</label>
    <output id="output">{{ score + 1 }}</output>
  </div>
  <div class="answer">
    <label for="answer">伝えたい数字</label>
    <input id="answer" type="number" min="1" max="64" v-model.number="answer" />
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, reactive, ref } from 'vue'

export default defineComponent({
  components: {
  },
  setup () {
    const state = reactive(Array(64).fill(false))
    const answer = ref(NaN)

    const score = computed(() => {
      return state.reduce((acc: number, hasPiece: boolean, index: number) => {
        if (hasPiece) acc ^= index
        return acc
      }, 0)
    })

    const diffToAnswer = computed(() => {
      return isNaN(answer.value) ? NaN : score.value ^ (answer.value - 1)
    })

    const cellClass = (index: number) => {
      const rankParity = Math.floor(index / 8) % 2
      const fileParity = (index % 8) % 2
      const background = rankParity ^ fileParity ? 'black' : 'white'
      return [background, { diff: index === diffToAnswer.value }]
    }

    const toggle = (index: number) => {
      state[index] = !state[index]
    }

    return {
      state,
      answer,
      score,
      cellClass,
      toggle
    }
  }
})
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;

  display: grid;
  grid-template-areas:
    "board score"
    "board answer"
  ;
  grid-template-rows: 400px 400px;
  grid-template-columns: 800px 1fr;
  .board {
    grid-area: board;
    display: flex;
    flex-wrap: wrap;
    .cell {
      width: 100px;
      height: 100px;
      &.white {
        background-color: #EEEEEE;
      }
      &.black {
        background-color: #666666;
      }
      &.diff {
        border: 8px solid gold;
        box-sizing: border-box;
      }
      .piece {
        font-size: 80px;
      }
    }
  }
  .score {
    grid-area: score;
    padding: 24px;
    label {
      font-size: 24px;
    }
    output {
      display: block;
      font-size: 240px;
    }
  }
  .answer {
    grid-area: answer;
    padding: 24px;
    label {
      font-size: 24px;
    }
    input[type=number] {
      margin: 16px;
      padding: 8px;
      font-size: 48px;
      text-align: right;
    }
  }
}
</style>
