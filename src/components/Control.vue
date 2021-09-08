<template>
  <div class="control">
    <button @click="random">ランダム</button>
    <button @click="clear">クリア</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, SetupContext } from 'vue'

export default defineComponent({
  emits: ['random', 'clear'],
  setup (_, context: SetupContext) {
    return {
      random () { context.emit('random') },
      clear () { context.emit('clear') }
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
