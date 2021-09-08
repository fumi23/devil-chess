<template>
  <Board
    class="board"
    :state="state"
    :diffToAnswer="diffToAnswer"
    @toggle="toggle"
  />
  <Score class="score" :score="score" />
  <div class="answer">
    <label for="answer">伝えたい数字</label>
    <input id="answer" type="number" min="1" max="64" v-model.number="answer" />
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, reactive, ref } from 'vue'
import Board from './components/Board.vue'
import Score from './components/Score.vue'

export default defineComponent({
  components: {
    Board,
    Score
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

    const toggle = (index: number) => {
      state[index] = !state[index]
    }

    return {
      state,
      answer,
      score,
      diffToAnswer,
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
  }
  .score {
    grid-area: score;
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
