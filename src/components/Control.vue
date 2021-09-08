<template>
  <div class="control">
    <button @click="random">ランダム</button>
    <button @click="clear">クリア</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, SetupContext } from 'vue'

export default defineComponent({
  setup (_, context: SetupContext) {
    const random = () => {
      context.emit('random')
    }

    const clear = () => {
      context.emit('clear')
    }

    return {
      random,
      clear
    }
  }
})
</script>

<style scoped lang="scss">
.control {
  padding: 24px;
  button {
    margin: 24px;
    width: 240px;
    height: 80px;
    font-size: 24px;
  }
}
</style>
