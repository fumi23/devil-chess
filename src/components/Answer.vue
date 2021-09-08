<template>
  <div class="answer">
    <label for="answer">伝えたい数字</label>
    <input id="answer" type="number" min="1" max="64" v-model="forInput" />
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, SetupContext } from 'vue'
import { validate64 } from '../utils/validator'

type Props = {
  answer: number
}

export default defineComponent({
  props: {
    answer: {
      type: Number,
      required: true,
      validator: validate64({ allowNaN: true })
    }
  },
  emits: ['update:answer'],
  setup (props: Props, context: SetupContext) {
    return {
      forInput: computed<string>({
        get () {
          return isNaN(props.answer) ? '' : (props.answer + 1).toString()
        },
        set (val) {
          context.emit('update:answer', parseInt(val) - 1)
        }
      })
    }
  }
})
</script>

<style scoped lang="scss">
.answer {
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
</style>
