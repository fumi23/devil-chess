<template>
  <div class="score">
    <label for="output">チェス盤の状況を数値化したもの</label>
    <output id="output">{{ score + 1 }}</output>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: {
    score: {
      type: Number,
      required: true,
      validator (val: number) {
        return val >= 0 && val <= 63
      }
    }
  }
})
</script>

<style scoped lang="scss">
.score {
  padding: 24px;
  label {
    font-size: 24px;
  }
  output {
    display: block;
    font-size: 240px;
  }
}
</style>
