<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query & form alters — how core search is scoped to the current language

All logic lives in `search_current_language.module`. There is nothing to configure — install and
enable, and the behavior applies immediately to core node search.

## Install / enable

`drush en search_current_language -y`. Requires core `search`, `language`, and
`content_translation` (declared in `search_current_language.info.yml`). No config object, schema,
settings form, or permissions. `search_current_language_update_8100()` (in `.install`) is a no-op
that only forces a cache clear.

## The query alter — `search_current_language_query_alter()`

Implements `hook_query_TAG_alter` (a single function fires for every tag the query carries). It
acts only when the query has one of these tags:

- `search_node_search` — the main core node-search query.
- `search_search_exclude_node_search` — the core "exclude" companion query.

When matched:

1. Resolves the active language once:
   `$language = \Drupal::languageManager()->getCurrentLanguage()->getId();`
2. Takes a reference to `$query->conditions()` and iterates it. For each entry whose `field` is a
   `Drupal\Core\Database\Query\Condition` (a nested condition group), it inspects that group's
   `->conditions()`; if any subcondition's `field === 'i.langcode'`, the whole group is
   `unset()` from the outer conditions and the loop breaks. This strips core search's own
   language condition so the module's does not merely stack on top of it.
3. Appends `$query->condition('i.langcode', [$language, 'und', 'zxx'], 'IN')`.

Net effect: results are limited to the current interface language plus the language-neutral codes
`und` ("undetermined") and `zxx` ("no linguistic content"). `i` is core search's index alias
(`search_index`); the condition uses the parameterized query builder (bound `IN` placeholders),
not string concatenation.

## The form alter — `search_current_language_form_search_form_alter()`

Implements `hook_form_FORM_ID_alter` for form id `search_form`. If
`$form['advanced']['lang-fieldset']` exists, sets its `#access` to `FALSE`, removing the
user-facing language filter from the advanced search UI (so a user cannot re-widen the language
scope the query alter enforces).

## Scope & limits

- **Core Search only.** It hooks core search query tags and the core `search_form`. It does
  nothing to Search API, Views, or any custom query that lacks those tags.
- **Language source is negotiation-driven.** Whatever language negotiation the site uses (URL,
  session, interface, etc.) determines `getCurrentLanguage()`, which drives the filter.
- **Neutral content always included.** `und` and `zxx` content appears under every language.
- No output, no writes, no external requests — it only narrows an existing read query and hides
  one form element.
