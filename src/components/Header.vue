<template>
  <b-nav>
    <b-nav-item active><b>Fancy Quiz App</b></b-nav-item>
    <b-nav-item disabled>Counter: {{ numCorrect }}/{{ numTotal }}</b-nav-item>
  </b-nav>
</template>k

<script>
export default {
  props: {
    numCorrect: Number,
    numTotal: Number
  }
}
</script>
