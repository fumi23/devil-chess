<template>
  <div class="board">
    <Cell
      v-for="(hasPiece, index) in state"
      :key="index"
      :background="background(index)"
      :highlighted="highlighted(index)"
      :hasPiece="hasPiece"
      @click="toggle(index)"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, SetupContext } from 'vue'
import Cell from './Cell.vue'
import { validate64 } from '../utils/validator'

type Props = {
  state: boolean[]
  diffToAnswer: number
}

export default defineComponent({
  components: {
    Cell
  },
  props: {
    state: {
      type: Array as PropType<boolean[]>,
      required: true,
      validator (val: boolean[]) {
        return val.length === 64
      }
    },
    diffToAnswer: {
      type: Number,
      required: true,
      validator: validate64({ allowNaN: true })
    }
  },
  emits: ['toggle'],
  setup (props: Props, context: SetupContext) {
    const background = (index: number) => {
      const rankParity = Math.floor(index / 8) % 2
      const fileParity = (index % 8) % 2
      return rankParity ^ fileParity ? 'black' : 'white'
    }

    const highlighted = (index: number) => {
      return index === props.diffToAnswer
    }

    return {
      background,
      highlighted,
      toggle (index: number) {
        context.emit('toggle', index)
      }
    }
  }
})
</script>

<style scoped lang="scss">
.board {
  display: flex;
  flex-wrap: wrap;
}
</style>
