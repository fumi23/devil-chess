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
</template>

<script lang="ts">
import { defineComponent, PropType, SetupContext } from 'vue'
// import Cell from './components/Cell.vue'

type Props = {
  state: boolean[]
  diffToAnswer: number
}

export default defineComponent({
  components: {
    // Cell
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
      validator (val: number) {
        return isNaN(val) || (val >= 0 && val <= 63)
      }
    }
  },
  setup (props: Props, context: SetupContext) {
    const cellClass = (index: number) => {
      const rankParity = Math.floor(index / 8) % 2
      const fileParity = (index % 8) % 2
      const background = rankParity ^ fileParity ? 'black' : 'white'
      return [background, { diff: index === props.diffToAnswer }]
    }

    const toggle = (index: number) => {
      context.emit('toggle', index)
    }

    return {
      cellClass,
      toggle
    }
  }
})
</script>

<style scoped lang="scss">
.board {
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
</style>
