<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views plugins provided

This module provides **Views handler plugins** (it does not define any new plugin *type*).
Two plugins ship:

## 1. Argument (contextual filter) — `taxonomy_index_name_depth`

- **Class:** `Drupal\views_taxonomy_term_name_depth\Plugin\views\argument\IndexNameDepth`
  (extends `ArgumentPluginBase`).
- **Annotation:** `@ViewsArgument("taxonomy_index_name_depth")`.
- **Exposed as:** `node_field_data.term_node_taxonomy_name_depth`, title
  *"Has taxonomy term NAME (with depth)"*, registered via
  `hook_views_data_alter()` in `views_taxonomy_term_name_depth.views.inc`
  (`'real field' => 'nid'`, `'accept depth modifier' => TRUE`).
- **Argument input:** a taxonomy **term name** (matched through Pathauto's alias cleaner),
  not a term id.
- **Options** (`defineOptions()`): `depth` (default `0`), `vocabularies` (default `[]`),
  `break_phrase` (default `FALSE`), `use_taxonomy_term_path` (default `FALSE`).
- Removes the summary default actions (`summary asc/desc`, `... by count`).

This is the plugin an agent almost always wants. See [../configure/argument.md](../configure/argument.md)
for how to place and configure it, and [../api/query.md](../api/query.md) for how it matches.

## 2. Default argument — `taxonomy_tpid`

- **Class:** `Drupal\views_taxonomy_term_name_depth\Plugin\views\argument_default\Tpid`
  (extends `ArgumentDefaultPluginBase`, implements `CacheableDependencyInterface`).
- **Annotation:** `@ViewsArgumentDefault(id = "taxonomy_tpid", title = "Taxonomy term parent ID from URL")`.
- **Purpose:** supplies a default value for a contextual filter when none is in the URL,
  derived from the current route: the **parent** term id of the current `taxonomy_term`
  (falls back to the term's own id if it has no parent), or the terms referenced by the
  current `node`.
- **Options:** `term_page` (default `TRUE`), `node` (default `FALSE`), `anyall` (default `,`),
  `limit` (default `FALSE`), `vids` (default `[]`).
- Cache: `getCacheContexts()` = `['url']`, max-age permanent.

Use it on any argument's **"Provide default value"** setting when you want the current
term's parent id supplied automatically (e.g. a child-term page showing the parent section).

## Confirm discovery

```bash
drush php:eval 'print_r(array_filter(array_keys(
  \Drupal::service("plugin.manager.views.argument")->getDefinitions()),
  fn($k) => str_contains($k, "name_depth")));'
# => taxonomy_index_name_depth
```
