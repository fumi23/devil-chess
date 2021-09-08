<template>
  <div class="cell" :class="[background, { highlighted }]" >
    <span v-if="hasPiece" class="piece">♟</span>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: {
    background: {
      type: String,
      required: true,
      validator (val: string) {
        return ['black', 'white'].includes(val)
      }
    },
    highlighted: {
      type: Boolean,
      default: false
    },
    hasPiece: {
      type: Boolean,
      default: false
    }
  }
})
</script>

<style scoped lang="scss">
.cell {
  width: 100px;
  height: 100px;
  &.black {
    background-color: #666666;
  }
  &.white {
    background-color: #EEEEEE;
  }
  &.highlighted {
    box-sizing: border-box;
    border: 8px solid;
    animation: blink 1.2s infinite;
    @keyframes blink {
      0% { border-color: gold }
      100% { border-color: transparent }
    }
  }
  .piece {
    font-size: 80px;
  }
}
</style>
