<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Search API AZ Glossary

The module has **no admin settings form**. Configuration is (1) a small config object for the group
labels, and (2) enabling the processor/fields on a Search API index and building a facet.

## Config object: `search_api_glossary.settings`

```yaml
group_prefix:
  alpha: "A-Z"      # label used when the first letter is alphabetic and alpha grouping is on
  numeric: "0-9"    # label used for numeric first characters when numeric grouping is on
  special: "#"      # label used for non-alphanumeric first characters when 'other' grouping is on
```
Schema: `search_api_glossary.settings` (mapping `group_prefix.{alpha,numeric,special}`). These are the
labels the `GlossaryHelper` substitutes when grouping is enabled (see api/helper.md). Change them to
localise the glossary bar:
```bash
drush cget search_api_glossary.settings group_prefix
drush php:eval '\Drupal::configFactory()->getEditable("search_api_glossary.settings")
  ->set("group_prefix", ["alpha" => "A-Z", "numeric" => "0-9", "special" => "#"])->save();'
```

## Enabling glossary on an index (end-to-end)

1. **Enable the processor** on your Search API index: add the `glossary` processor
   (Search API → your index → Processors). Config is stored in the index config entity's
   `processor_settings.glossary`.
2. **Mark source fields as "glossary"** in the processor settings (per indexed field). For each
   enabled field the processor exposes a hidden computed field **`glossaryaz_<field>`** (type string)
   holding the first letter / group. Add that field to the index and reindex.
3. **Build a facet** (Facets module) on the `glossaryaz_<field>` field, using the **Glossary AZ**
   widget (`glossaryaz`) and, if desired, the glossary facet processors (all-items / pad-items /
   widget-order) — see plugins/plugins.md.
4. Place the facet block / add it to your View or Search API Page.

Programmatic index config (config entity `search_api.index.<id>`):
```php
$index = \Drupal::entityTypeManager()->getStorage('search_api_index')->load('my_index');
$index->setProcessorSettings($index->getProcessorSettings() + [
  'glossary' => ['weights' => []],   // enable the glossary processor
]);
$index->save();
```

Backends: works with the DB, Solr and Elasticsearch Search API backends; integrates with Views,
Search API Pages and Facets. No Drush commands are provided.
