<template>
  <Board
    class="board"
    :state="state"
    :diffToAnswer="diffToAnswer"
    @toggle="toggle"
  />
  <Score class="score" :score="score" />
  <Answer class="answer" v-model="answer" />
</template>

<script lang="ts">
import { computed, defineComponent, reactive, ref } from 'vue'
import Board from './components/Board.vue'
import Score from './components/Score.vue'
import Answer from './components/Answer.vue'

export default defineComponent({
  components: {
    Board,
    Score,
    Answer
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

    const toggle = (index: number) => {
      state[index] = !state[index]
    }

    return {
      state,
      score,
      answer,
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
  }
}
</style>
