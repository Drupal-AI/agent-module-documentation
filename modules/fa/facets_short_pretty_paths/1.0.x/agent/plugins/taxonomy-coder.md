<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `taxonomy_term_machine_name_coder` coder

File: `src/Plugin/facets_pretty_paths/coder/TaxonomyTermCoder.php`
Class: `Drupal\facets_short_pretty_paths\Plugin\facets_pretty_paths\coder\TaxonomyTermCoder`
extends `Drupal\facets_pretty_paths\Coder\CoderPluginBase`.

## Plugin definition

Annotation `@FacetsPrettyPathsCoder(id = "taxonomy_term_machine_name_coder", label = "Taxonomy term machine
name")`. It is discovered by Facets Pretty Paths' coder plugin manager
(`plugin.manager.facets_pretty_paths.coder`); this module defines **no plugin type of its own**. Select it
on a taxonomy-term facet via the "Pretty paths coder" radios added to the facet edit form (see
[url-processor.md](url-processor.md)). It maps a taxonomy term id ↔ a URL slug so paths read as
`/color/blue` instead of `/color/1`.

## Settings read from `settings.php` (in the constructor)

- `facets_short_pretty_paths_field_name` (default `'machine_name'`) → `$this->fieldName`: the taxonomy-term
  field whose value is used as the slug. The default matches the base field from the Taxonomy Machine Name
  module. `hook_requirements()` in `.install` blocks install if no such field exists on `taxonomy_term`.
- `facets_short_pretty_paths_use_dashes` (default `FALSE`) → `$this->shouldUseDashes`: when TRUE, machine
  names are shown with dashes instead of underscores (better for SEO).

## `encode($id)` — term id → slug

- `Term::load($id)`; if it has the configured field and it is not empty, the slug is that field value,
  passed through `convertMachineName($value, TRUE)` (underscores → dashes when `shouldUseDashes`).
- **Fallback** (field empty): the term's `name` is cleaned via
  `\Drupal::service('pathauto.alias_cleaner')->cleanString()` and joined to the term id with
  `getFallbackSeparator()`, e.g. `blue-1` (or `blue:1` when dashes are enabled), preserving uniqueness.

Encoding is applied by the URL processor to facet **result** values (ids already surfaced by the
access-checked search index) when building links.

## `decode($alias)` — slug → term id

- If the alias contains the fallback separator (`explode()` yields >1 part), the term id is
  `array_pop()`ed off the end (the numeric id from the `name-id` fallback form).
- Otherwise the alias is treated as a machine name: `convertMachineName($alias, FALSE)` (dashes →
  underscores when enabled), then an entity query on `taxonomy_term` storage —
  `->getQuery()->accessCheck()->condition($this->fieldName, $alias)->execute()` — resolves the matching
  term id (`reset()` of the results). The condition value is bound by the entity query (parameterized, not
  string-concatenated), and the query runs with the access check enabled.

## Helpers

- `getFallbackSeparator()` — returns `':'` when `shouldUseDashes` (so dashes stay free for machine names),
  otherwise `'-'`.
- `convertMachineName($name, $encode)` — no-op unless `shouldUseDashes`; swaps `_`↔`-` for encode/decode.
