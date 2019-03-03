<template>
  <div>
    <h1>A test page</h1>
    <form>
      <input type="text" v-model="searchTerm">
      <input type="submit" value="Search" @click.prevent="submitSearch" />
    </form>
    <div v-html="entriesParsed"></div>
    <ul>
      <li v-for="entry in entriesDefined" :key="entry.id" >
        <div v-html="renderLegibleHTML(entry.description)" />
      </li>
    </ul>
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
