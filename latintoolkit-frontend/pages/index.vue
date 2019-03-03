<template>
  <div class="dictionary">

    <header class="dictionary__header">
      <h1 class="dictionary__title">The Latin Learning Hub</h1>
      <p class="dictionary__description">
        Welcome! This website is a playground for trying out new web
        application tooling and is under development.
      </p>

      <h2 class="dictionary__subtitle">Vocabulary Parsing and Lexicon Lookup</h2>
      <form class="dictionary__form">
        <input class="dictionary__search" type="text" v-model="searchTerm">
        <input class="dictionary__submit" type="submit" value="Search" @click.prevent="submitSearch" />
      </form>
    </header>

    <div class="dictionary__body">
      <section class="dictionary__container--parsed">
        <h3 class="dictionary__subtitle">Possible Formations</h3>
        <div class="dictionary__placeholder" v-if="!entriesParsed">
          Search above
        </div>
        <div
          class="dictionary__entries--parsed"
          v-if="entriesParsed"
          v-html="entriesParsed" />
      </section>
      <section class="dictionary__container--defined">
        <h3 class="dictionary__subtitle">Lexicon Entries</h3>
        <div class="dictionary__placeholder" v-if="!entriesDefined">
          Search above
        </div>
        <ul class="dictionary__entries--defined">
          <li class="dictionary__entry" v-for="entry in entriesDefined" :key="entry.id" >
            <div class="dictionary__content" v-html="renderLegibleHTML(entry.description)" />
          </li>
        </ul>
      </section>
    </div>
  </div>
</template>

<script>
import convertEntities from '../helpers/convertEntities';
import createPostBody from '../helpers/createPostBody';
import parseXML from '../helpers/parseXML';
const PERSEUS = 'http://www.perseus.tufts.edu/hopper/xmlmorph?lang=la&lookup=';
export default {
  data() {
    return {
      entriesDefined: null,
      entriesParsed: null,
      searchTerm: null
    };
  },
  methods: {
    renderLegibleHTML(html) {
      return convertEntities(html);
    },
    submitSearch() {
      this.fetchParsed(this.searchTerm);
    },
    async fetchDefined(xml) {
      const dom_lemmata = parseXML(xml, "lemma");
      const arr_lemmata = Array.from(dom_lemmata)
        .map( entry => entry.textContent )
        .filter( (value, index, self) => self.indexOf(value) === index );
      const definedJSON = await Promise.all(
        arr_lemmata.map(entry => this.$axios.$get(`/dictionary/${entry}/`))
      );
      const refinedJSON = definedJSON.filter(result => result.id !== null );
      this.entriesDefined = refinedJSON;
    },
    async fetchParsed(search_value) {
      const xml = await this.$axios.$get(`${PERSEUS}${search_value}`);
      this.entriesParsed = xml;
      this.fetchDefined(xml);
    }
  }
}
</script>

<style>
  analyses {
    box-sizing: border-box;
    display: block;
  }
  analyses analysis {
    box-sizing: border-box;
    display: flex;
    justify-content: flex-start;
    margin-bottom: 0.25em;
  }
  analyses analysis:last-child {
    margin-bottom: 0;
  }
  analyses analysis expandedForm,
  analyses analysis form {
    display: none;
  }
  analyses analysis > * {
    flex-basis: 1;
    flex-grow: 0;
    flex-shrink: 0;
    margin-right: 0.5rem;
  }
  sense {
    display: block;
    margin: 0.5rem 0;
  }
  sense[level="2"] {
    margin-left: 0.5em;
  }
  sense[level="3"] {
    margin-left: 1em;
  }
  sense[level="4"] {
    margin-left: 1.5em;
  }
  sense[level="5"] {
    margin-left: 2em;
  }
  sense[level="6"] {
    margin-left: 2.5em;
  }
  hi[rend="ital"], bibl, quote, author {
    font-weight: normal;
  }
  hi[rend="ital"] {
    font-weight: bold;
  }
  quote {
    color: #181818;
  }
  author {
    color: #303030;
  }
  bibl {
    color: #606060;
  }
  cit {
    font-family: 'Times New Roman', serif;
    font-style: italic;
  }
  entryFree {
    display: block;
    font-family: Georgia, serif;
    letter-spacing: 0.1px;
    width: 100%;
  }
  entryFree:last-child {
    border-bottom: none;
  }
</style>

<style scoped>
.dictionary {
  margin: auto;
  max-width: 900px;
  padding: 0 1rem;
}
.dictionary__entries--defined,
.dictionary__entries--parsed,
.dictionary__entry,
.dictionary__form,
.dictionary__title {
  margin-bottom: 2rem;
}
.dictionary__description {
  margin-bottom: 4rem;
}
.dictionary__body {
  display: flex;
  flex-direction: column;
}
.dictionary__container--parsed,
.dictionary__container--defined {
  width: 100%;
}
.dictionary__container--parsed {
  margin-bottom: 2rem;
}
.dictionary__subtitle {
  margin-bottom: 1rem;
}
.dictionary__entries--defined {
  list-style: none;
  padding: 0;
}
.dictionary__placeholder {
  border: 0.1rem dashed #000;
  color: #BBB;
  text-align: center;
}
.dictionary__placeholder,
.dictionary__entries--parsed {
  padding: 1rem 2rem;
}
.dictionary__entries--parsed,
.dictionary__entry {
  border: 0.1rem solid #000;
}
.dictionary__entry {
  height: 40vh;
  position: relative;
}
.dictionary__entry::after {
  background-image: linear-gradient(to bottom, transparent, #fff);
  bottom: 0;
  content: '';
  height: 3rem;
  left: 0;
  position: absolute;
  width: 100%;
}
.dictionary__content {
  height: 100%;
  overflow-y: scroll;
  padding: 1rem 2rem 2rem;
}

.dictionary__form {
  position: relative;
  width: 100%;
}

.dictionary__search,
.dictionary__submit {
  border: 0.1rem solid #000;
  font-size: 1rem;
  padding: 0.5rem;
}

.dictionary__search {
  width: 100%;
}

.dictionary__submit {
  cursor: pointer;
  position: absolute;
  right: 0;
  top: 0;
}

@media only screen and (min-width: 768px) {
  .dictionary__body {
    flex-direction: row;
  }
  .dictionary__container--parsed {
    width: 40%;
    margin: 0 1rem 0 0;
  }
  .dictionary__container--defined {
    width: 60%;
  }
}
</style>
