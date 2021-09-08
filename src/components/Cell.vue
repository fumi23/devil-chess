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
    border: 8px solid gold;
    box-sizing: border-box;
  }
  .piece {
    font-size: 80px;
  }
}
</style>
