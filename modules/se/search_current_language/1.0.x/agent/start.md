<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search by current language (search_current_language) — agent index

Forces core node search to return only current-language results (plus the `und`/`zxx` neutral
codes) and hides the advanced-search language filter. Package `Search`. Depends on core `search`,
`language`, `content_translation`. Core requirement `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.2.

Affects **core Search only**, not Search API. The entire module is three hooks in
`search_current_language.module` plus a no-op update hook. No config page, no routes, no
permissions, no services, no config schema, no plugin types.

- **The query alter, the form alter, and how it operates** →
  [api/query-alter.md](api/query-alter.md)

## What it actually is (from source)

- `search_current_language_query_alter(AlterableInterface $query)` — `hook_query_TAG_alter`. For
  queries carrying tag `search_node_search` or `search_search_exclude_node_search`: walks
  `$query->conditions()`, removes any nested `Condition` group whose subconditions target field
  `i.langcode` (core search's own language condition), then appends
  `$query->condition('i.langcode', [<current language>, 'und', 'zxx'], 'IN')`. Current language =
  `\Drupal::languageManager()->getCurrentLanguage()->getId()`.
- `search_current_language_form_search_form_alter(&$form, FormStateInterface $form_state)` —
  `hook_form_FORM_ID_alter`. Sets `$form['advanced']['lang-fieldset']['#access'] = FALSE` to hide
  the advanced-search language filter.
- `search_current_language_help($route_name, RouteMatchInterface $route_match)` — static,
  `t()`-wrapped help text on `help.page.search_current_language`.
- `search_current_language_update_8100()` in `.install` — empty; exists only to force a cache
  clear on update.
