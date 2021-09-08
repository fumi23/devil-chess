<template>
  <div class="score">
    <label for="output">チェス盤の状況を数値化したもの</label>
    <output id="output">{{ score + 1 }}</output>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { validate64 } from '../utils/validator'

export default defineComponent({
  props: {
    score: {
      type: Number,
      required: true,
      validator: validate64()
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
