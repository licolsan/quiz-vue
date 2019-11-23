<template>
  <b-jumbotron>
    <template v-slot:lead>
      {{ currentQuestion.question }}
    </template>

    <hr class="my-4">
    <b-list-group>
      <b-list-group-item
        v-for="(answer, index) in answers"
        :key="answer"
        @click.prevent="selectAnswer(index)"
        :class="answerClass(index)"
      >
        {{answer}}
      </b-list-group-item>
    </b-list-group>

    <b-button
      variant="primary"
      @click="submitAnswer"
      :disabled="selectedIndex === null || answered"
    >
      Submit
    </b-button>
    <b-button variant="success" href="#" @click="next">Next</b-button>
  </b-jumbotron>
</template>

<script>
import _ from 'lodash'

export default {
  computed: {
    answers: function() {
      return [
        ...this.currentQuestion.incorrect_answers,
        this.currentQuestion.correct_answer
      ]
    }
  },
  data: function() {
    return {
      correctIndex: null,
      selectedIndex: null,
      shuffledAnswers: [],
      answered: false
    }
  },
  methods: {
    answerClass: function(index) {
      return [
        !this.answered && this.selectedIndex === index ? 'selected' :
        this.answered && this.correctIndex === index ? 'correct' :
        this.answered && this.selectedIndex === index ? 'incorrect' :  ''
      ]
    },
    selectAnswer: function(index) {
      this.selectedIndex = !this.answered ? index : this.selectedIndex
    },
    shuffleAnswers: function() {
      this.shuffledAnswers = _.shuffle([
        ...this.currentQuestion.incorrect_answers,
        this.currentQuestion.correct_answer
      ])
      this.correctIndex = this.shuffledAnswers.indexOf(this.currentQuestion.correct_answer)
    },
    submitAnswer: function() {
      // const isCorrect = (this.selectedIndex === this.correctIndex) ? true : false
      this.increase(this.selectedIndex === this.correctIndex)
      this.answered = true
    }
  },
  mounted: function() {
    this.shuffleAnswers()
  },
  props: {
    currentQuestion: Object,
    next: Function,
    increase: Function
  },
  watch: {
    currentQuestion: function() {
      this.selectedIndex = null
      this.shuffleAnswers()
      this.answered = false
    }
  }
}
</script>

<style scoped>
  .list-group {
    margin-bottom: 15px
  }
  .list-group-item:hover {
    background-color: rgb(67, 163, 218);
    cursor: pointer;
    color: black;
  }
  .selected {
    background-color: lightblue;
  }
  .correct {
    color: white;
    background-color: green;
  }
  .incorrect {
    color: white;
    background-color: red;
  }
  .btn {
    margin: 0 5px
  }
</style>
