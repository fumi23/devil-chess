<template>
  <div class="answer">
    <label for="answer">伝えたい数字</label>
    <input id="answer" type="number" min="1" max="64" v-model="answer" />
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, SetupContext } from 'vue'

type Props = {
  modelValue: number
}

export default defineComponent({
  props: {
    modelValue: {
      type: Number,
      required: true,
      validator (val: number) {
        return isNaN(val) || (val >= 0 && val <= 63)
      }
    }
  },
  setup (props: Props, context: SetupContext) {
    const answer = computed({
      get () {
        return isNaN(props.modelValue) ? '' : (props.modelValue + 1).toString()
      },
      set (val: string) {
        context.emit('update:modelValue', parseInt(val) - 1)
      }
    })

    return {
      answer
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
