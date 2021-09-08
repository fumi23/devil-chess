<template>
  <Board
    class="board"
    :state="state"
    :diffToAnswer="diffToAnswer"
    @toggle="toggle"
  />
  <Score class="score" :score="score" />
  <Answer class="answer" v-model="answer" />
  <Control class="control"
    @random="random"
    @clear="clear"
  />
</template>

<script lang="ts">
import { computed, defineComponent, reactive, ref } from 'vue'
import Board from './components/Board.vue'
import Score from './components/Score.vue'
import Answer from './components/Answer.vue'
import Control from './components/Control.vue'

export default defineComponent({
  components: {
    Board,
    Score,
    Answer,
    Control
  },
  setup () {
    const state = reactive(Array(64).fill(false))

    const score = computed(() => {
      return state.reduce((acc: number, hasPiece: boolean, index: number) => {
        if (hasPiece) acc ^= index
        return acc
      }, 0)
    })

    const answer = ref(NaN)

    const diffToAnswer = computed(() => {
      return isNaN(answer.value) ? NaN : score.value ^ answer.value
    })

    return {
      state,
      score,
      answer,
      diffToAnswer,
      toggle (index: number) {
        state[index] = !state[index]
      },
      random () {
        Object.assign(state, state.map(() => Math.random() < 0.2))
      },
      clear () {
        Object.assign(state, state.map(() => false))
        answer.value = NaN
      }
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
    "board control"
  ;
  grid-template-rows: 400px 200px 200px;
  grid-template-columns: 800px 1fr;
  .board {
    grid-area: board;
  }
  .score {
    grid-area: score;
  }
  .answer {
    grid-area: answer;
  }
  .control {
    grid-area: control;
  }
}
</style>
