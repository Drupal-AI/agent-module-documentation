<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Solr NLP (search_api_solr_nlp) — agent index

Adds Apache Solr's **OpenNLP** analysis to **Search API Solr** as a set of ready-made full-text Solr
field types (`nouns`, `edge_nouns`). Indexing a field with one of these types runs the text through
an OpenNLP pipeline **inside Solr** — sentence detection, tokenisation, part-of-speech tagging — and
keeps only the nouns (optionally edge-n-grammed). The resulting noun-only index is a strong source
for autocomplete, spellcheck and entity-flavoured relevance. All NLP happens on the Solr server; the
Drupal module ships the field-type definitions and, at config-set generation time, injects the
trained OpenNLP model files (`*.bin`) into the config set that you upload to Solr.

Mechanism: the module contributes `search_api_solr` **`solr_field_type` config entities** (one per
language per code) whose analyzer chains use `solr.OpenNLPTokenizerFactory` / `solr.OpenNLPPOSFilterFactory`.
A single **event subscriber** listens to `search_api_solr`'s config-set generation events, scrapes the
`*.bin` model names out of the generated `schema_extra_types.xml`, and adds those model files (resolved
from the bundled `mkalkbrenner/solarium-nlp` library) into the downloadable Solr config-set zip. There
is no external NLP API, no HTTP client, no API key, no settings form, and no route in this module.

- Depends on: `search_api_solr:search_api_solr` (info.yml). Composer also pulls
  `mkalkbrenner/solarium-nlp` (`^0.1.4`, the pre-trained OpenNLP models). Suggests
  `drupal/search_api_autocomplete`.
- Core: `^10.1 || ^11.0`. Package: `Search`.
- **No settings page / `configure` route. No permissions. No services other than the event
  subscriber. No drush. No plugin types. No forms/controllers/routes.**
- Ships 16 `solr_field_type` config entities plus reference "jump-start" config sets for Solr 7/8/9.

## What you'd do → where

- **Index a search field so Solr keeps only its nouns / understand `nouns` vs `edge_nouns` and the
  Solr analyzer chain** → [fields/solr-field-types.md](fields/solr-field-types.md)
- **Install it end-to-end: composer deps, Solr OpenNLP libs, regenerate + upload the config set,
  SolrCloud `jute.maxbuffer`** → [configure/setup.md](configure/setup.md)
- **Understand how the model `*.bin` files get into the Solr config set (the event subscriber)** →
  [events/config-set-generation.md](events/config-set-generation.md)

## Key facts (real machine names)

- Service (only one): `search_api_solr_nlp.search_api_solr_subscriber` →
  `Drupal\search_api_solr_nlp\EventSubscriber\SearchApiSolrSubscriber` (tag `event_subscriber`, no
  constructor args).
- Subscribed events (from `search_api_solr`): `SearchApiSolrEvents::POST_CONFIG_FILES_GENERATION`
  (`onPostConfigFilesGeneration`), `SearchApiSolrEvents::POST_CONFIG_SET_GENERATION`
  (`onPostConfigSetGeneration`).
- Field-type custom codes: `nouns`, `edge_nouns`. Config-entity id pattern:
  `text_nouns_<lang>_7_0_0`, `text_edge_nouns_<lang>_7_0_0`; Solr field-type name `text_nouns_<lang>` /
  `text_edge_nouns_<lang>`; `minimum_solr_version: 7.0.0`; class `solr.TextField`.
- Languages shipped: `und` (in `config/install/`), and `en de nl da se pt-pt pt-br`
  (in `config/optional/`) — 16 entities total.
- Solr analyzer classes used: `solr.OpenNLPTokenizerFactory`, `solr.OpenNLPPOSFilterFactory`,
  `solr.TypeTokenFilterFactory` (whitelist `pos_<code>_<lang>.txt`), `solr.LowerCaseFilterFactory`,
  `solr.SynonymGraphFilterFactory` (query side, `synonyms_<code>_<lang>.txt`),
  `solr.RemoveDuplicatesTokenFilterFactory`, `solr.EdgeNGramFilterFactory` (edge variant, index side,
  gram 2–25).
- Library helper: `SolariumNlp\Nlp::getOpenNlpDemoModelPath($model)` resolves each `*.bin` from the
  composer library's `opennlp/models-combined/` directory.
- Update hooks (`search_api_solr_nlp.install`): `update_8001` (German lower-case filter),
  `update_8004` (re-save `nouns`/`edge_nouns` field-type configs, enforce deps); `8002`/`8003` are
  empty forward-references.
- Bundled reference config sets: `jump-start/solr{7,8,9}/{cloud-config-set,config-set}/` (includes the
  `*.bin` models, `accents_*.txt`, `nouns_*.txt`, `pos_*.txt`).
- No routes, controllers, forms, permissions, or external API calls — no request-facing surface.
