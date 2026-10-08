<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NLP Solr field types (`nouns`, `edge_nouns`)

The module's usable surface is a set of `search_api_solr` **`solr_field_type` config entities**. They
are NOT Drupal field widgets/formatters — they are Solr-side full-text field types that `search_api_solr`
writes into the generated Solr config set. Index a search field as one of these types and Solr runs the
text through an OpenNLP pipeline that discards everything except the nouns. The noun-only tokens that
land in the index are a strong feed for autocomplete, spellcheck and "what is this about" relevance.

## The two custom codes

| `custom_code` | Config-entity id | Solr field-type name | Extra vs `nouns` |
|---|---|---|---|
| `nouns` | `text_nouns_<lang>_7_0_0` | `text_nouns_<lang>` | — (nouns only) |
| `edge_nouns` | `text_edge_nouns_<lang>_7_0_0` | `text_edge_nouns_<lang>` | adds `solr.EdgeNGramFilterFactory` (index side, gram 2–25) for prefix/autocomplete matching |

`class: solr.TextField`, `minimum_solr_version: 7.0.0`, `positionIncrementGap: 100` for all of them.

## Languages shipped (16 entities)

- **Installed on enable** (`config/install/`): `und` — `text_nouns_und_7_0_0`,
  `text_edge_nouns_und_7_0_0` (label "Language Undefined Nouns Field" / "… Edge NGram Nouns Field").
- **Optional** (`config/optional/`, installed if the language exists): `en de nl da se pt-pt pt-br`,
  each for both `nouns` and `edge_nouns` → 14 more entities.

Each entity carries `dependencies.enforced.module: [search_api_solr_nlp, language]` and
`field_type_language_code: <lang>`.

## The Solr analyzer chain (from the `und` entities)

Index analyzer (`analyzers` → `type: index`):

1. `tokenizer: solr.OpenNLPTokenizerFactory` — `sentenceModel: <lang>-sent.bin`,
   `tokenizerModel: <lang>-token.bin`.
2. `solr.OpenNLPPOSFilterFactory` — `posTaggerModel: <lang>-pos-maxent.bin` (tags each token's
   part of speech).
3. `solr.TypeTokenFilterFactory` — `types: pos_<code>_<lang>.txt`, `useWhitelist: true` (keeps only
   tokens whose POS tag is in the whitelist file — i.e. nouns).
4. `solr.LowerCaseFilterFactory`.
5. `edge_nouns` only: `solr.EdgeNGramFilterFactory` (`minGramSize: 2`, `maxGramSize: 25`).
6. `solr.RemoveDuplicatesTokenFilterFactory`.

Query analyzer (`type: query`) is the same OpenNLP + POS-whitelist + lower-case head, then
`solr.SynonymGraphFilterFactory` (`synonyms: synonyms_<code>_<lang>.txt`) instead of the edge-n-gram
step, then `solr.RemoveDuplicatesTokenFilterFactory`. The `pos_*` and `synonyms_*` text files are
per-entity (`text_files.pos` / `text_files.synonyms`, empty by default) and also shipped in the
jump-start config sets.

The `<lang>-sent.bin`, `<lang>-token.bin`, `<lang>-pos-maxent.bin` referenced above are the trained
OpenNLP models; they must reach the Solr server. That is what the config-set event subscriber does —
see [../events/config-set-generation.md](../events/config-set-generation.md).

## Using a type

1. Install the module and (re)generate + upload the Search API Solr config set so these field types
   and their `*.bin` models are present on Solr — see [../configure/setup.md](../configure/setup.md).
2. In Search API, index the target field with the NLP field type. In `search_api_solr` a
   `solr_field_type` entity becomes selectable for search fields by its `custom_code`/language, so the
   field is analysed as `text_nouns_<lang>` / `text_edge_nouns_<lang>` rather than the default
   full-text type.
3. Point autocomplete/spellcheck features at that field (the module suggests
   `drupal/search_api_autocomplete`, which pairs well with the noun/edge-noun types).
