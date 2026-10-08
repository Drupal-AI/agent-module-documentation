<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Solr NLP adds Apache Solr's OpenNLP natural-language processing to Search API Solr as ready-made full-text field types (`nouns`, `edge_nouns`) that let Solr keep only the nouns of your content.

---

Plain full-text indexing treats a document as a bag of tokens, which is fine for keyword search but noisy for features that want the *subjects* of a text rather than every word. Apache Solr can do better through **OpenNLP**: sentence detection, tokenisation and part-of-speech tagging driven by trained language models. This module wires that capability into Search API Solr as extra Solr field types — index a field as `text_nouns_<lang>` and the OpenNLP pipeline discards everything except the nouns; index it as `text_edge_nouns_<lang>` and the nouns are additionally edge-n-grammed for prefix matching. The noun-only tokens that reach the index are an excellent feed for **autocomplete** and **spellcheck** and for relevance that leans on what a document is about. Two things to plan for. It must be installed **via composer** (`composer require drupal/search_api_solr_nlp`), which pulls the `mkalkbrenner/solarium-nlp` library containing the pre-trained models from apache.org — the first download is slow but then cached. And it is a **coordinated Drupal-and-Solr setup**: once enabled, the config set that Search API Solr generates automatically includes the new field types and the model `*.bin` files (a background event subscriber injects them), but you must be able to upload that config set to a Solr server that has the OpenNLP libraries — the default Solr distribution does. For SolrCloud you may need to raise a ZooKeeper buffer (`-Djute.maxbuffer=50000000`) because the models are large. Ships types for `und`, `en`, `de`, `nl`, `da`, `se`, `pt-pt` and `pt-br`, plus reference "jump-start" config sets for Solr 7, 8 and 9. There is no settings page, no permission and no external NLP API — all processing happens inside Solr.

---

- Keep only the nouns of an indexed field.
- Add OpenNLP analysis to a Search API Solr index.
- Index a field as `text_nouns_<lang>`.
- Index a field as `text_edge_nouns_<lang>` for prefix matching.
- Feed better data into search autocomplete.
- Feed better data into spellcheck / query suggestions.
- Do part-of-speech-aware analysis inside Solr.
- Extract subject nouns from prose content.
- Improve relevance on natural-language text.
- Build a noun-based facet or tag source.
- Provision trained OpenNLP models onto Solr.
- Bundle model `*.bin` files into the Solr config set automatically.
- Regenerate and upload a Solr config set with NLP field types.
- Support English, German, Dutch, Danish, Swedish, Portuguese and language-undefined content.
- Use the bundled jump-start config sets for Solr 7, 8 or 9.
- Coordinate a Drupal-and-Solr NLP deployment.
- Raise the ZooKeeper `jute.maxbuffer` for large model config sets.
- Extend a `search_api_solr` server without touching core.
- Pair with `search_api_autocomplete` for NLP-backed suggestions.
- Move beyond bag-of-words indexing.
- Reduce index noise to meaningful terms.
- Edge-n-gram nouns for typeahead search.
