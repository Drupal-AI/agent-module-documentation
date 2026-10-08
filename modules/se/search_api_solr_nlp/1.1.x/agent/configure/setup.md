<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup (coordinated Drupal + Solr)

There is no settings form and no `configure` route. "Configuring" this module means getting the NLP
field types and their trained models onto a Solr server that has OpenNLP support. This is a
Drupal-and-Solr operation, not a Drupal-only enable.

## Steps

1. **Install via composer** (required — pulls the models):
   `composer require drupal/search_api_solr_nlp`. This drags in `mkalkbrenner/solarium-nlp`
   (`^0.1.4`), which contains the pre-trained OpenNLP models fetched from apache.org. The first fetch
   is slow — not an error. In this project use `ddev composer require …`.
2. **Enable it:** `ddev drush en search_api_solr_nlp -y`. Enabling installs the `und` field types
   (`config/install/`) and any optional-language types (`config/optional/`) whose language exists.
3. **Solr must have OpenNLP libraries.** The default Apache Solr distribution already bundles them
   (`solr.OpenNLPTokenizerFactory` etc.). A stripped-down/hosted Solr may need the analysis-extras
   OpenNLP jars enabled.
4. **Regenerate and upload the Search API Solr config set.** Once this module is enabled, the config
   set that `search_api_solr` generates automatically contains the NLP field types **and** the model
   `*.bin` files (injected by the event subscriber —
   [../events/config-set-generation.md](../events/config-set-generation.md)). Download it from the
   Solr server's config page in Search API Solr, or use the bundled reference sets under
   `jump-start/solr{7,8,9}/{cloud-config-set,config-set}/`, and upload it to your Solr core/collection.
   **Your Solr host must allow you to provide/upload your own config set.**
5. **SolrCloud only — raise the ZooKeeper buffer.** The model files are large, so ZooKeeper may reject
   the config set. Set, e.g.: `SOLR_OPTS="$SOLR_OPTS -Djute.maxbuffer=50000000"`.
6. **Index fields with an NLP type.** Assign `text_nouns_<lang>` / `text_edge_nouns_<lang>` to the
   search fields you want noun-extracted — see [../fields/solr-field-types.md](../fields/solr-field-types.md).
   Consider `drupal/search_api_autocomplete` (suggested), which pairs well with these types.

## Update hooks (`search_api_solr_nlp.install`)

- `search_api_solr_nlp_update_8001()` — adds a lower-case filter to the German (`de`) field types.
- `search_api_solr_nlp_update_8004()` — re-saves the `nouns`/`edge_nouns` field-type configs from the
  shipped YAML (from `config/optional/` or `config/install/`) and enforces module dependencies.
- `…_update_8002()` / `…_update_8003()` are empty forward-references (logic moved to 8003/8004).

After enabling or updating, run `ddev drush updatedb -y` and re-generate/upload the Solr config set so
Solr picks up any field-type changes.
