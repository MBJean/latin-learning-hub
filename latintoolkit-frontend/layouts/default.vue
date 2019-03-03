<template>
  <div>
    <nav class="nav">
      <div class="nav__inner">
        <nuxt-link to="/" class="nav__header">The Latin Learning Hub</nuxt-link>
      </div>
    </nav>
    <div class="nav__spacer"></div>
    <nuxt/>
  </div>
</template>

<script>
export default {
  data () {
    return {
      examples: []
    }
  },
  methods: {
  },
  mounted () {
  }
}
</script>

<style>
html {
  font-family: "Source Sans Pro", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  font-size: 16px;
  word-spacing: 1px;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%;
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  box-sizing: border-box;
}

*, *:before, *:after {
  box-sizing: border-box;
  margin: 0;
}

.nav {
  background-color: #fff;
  border-bottom: 0.1rem solid #000;
  height: 4rem;
  left: 0;
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 10;
}

.nav__spacer {
  height: 0;
  margin-bottom: 8rem;
}

.nav__inner {
  align-items: center;
  display: flex;
  height: 100%;
  max-width: 1000px;
  margin: auto;
}

.nav__header {
  color: #000 !important;
  font-size: 1rem;
  text-decoration: none !important;
}
</style>
