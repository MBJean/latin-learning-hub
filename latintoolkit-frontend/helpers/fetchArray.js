// description: takes an array of lemmata (strings),
// replaces each with the JSON result of a fetch to /dictionary
export default function(array) {
  return array.map(entry => this.$axios.$get(`/api/v1/dictionary/${entry}/`));
};
