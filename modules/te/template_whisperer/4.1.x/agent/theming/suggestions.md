<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme-suggestion injection, Tokens, Twig, block Condition

## The core: `hook_theme_suggestions_alter()`
`template_whisperer.module` implements `hook_theme_suggestions_alter()` and delegates to two helpers.
For an entity that carries a chosen suggestion (machine name `S`), the module reads the suggestion
via `TemplateWhispererManager::suggestionsFromEntity()` and appends theme suggestions **always
prefixed** — the machine name is never used bare. Suggestions use `__` (Drupal maps `__` → `--` and
`.html.twig` on disk).

### Page-level (`inc/suggestions/page.inc`, `$hook === 'page'`)
The entity is taken from the current route's parameters (first `ContentEntityInterface` found). Adds:
- `page__<entity_type>__<id>__S`  → `page--node--1--news_list.html.twig`
- `page__<entity_type>__S`        → `page--node--news_list.html.twig`

### Entity-level (`inc/suggestions/entity.inc`, when `$variables['elements']['#entity_type'] === $hook`)
Works for any content entity render. Adds, using entity type / bundle / id (and view mode when set):
- `<entity_type>__<bundle>__S`                       → `node--article--news_list.html.twig`
- `<entity_type>__<id>__<bundle>__S`                 → `node--1--article--news_list.html.twig`
- `<entity_type>__<bundle>__<view_mode>__S`          → `node--article--teaser--news_list.html.twig`
- `<entity_type>__<id>__<bundle>__<view_mode>__S`    → `node--1--article--teaser--news_list.html.twig`

A theme provides whichever files it wants. **If no matching template file exists, rendering falls
back to the default template silently** — the choice appears to do nothing. Keep the declared
suggestion set and the theme's Twig files in step; re-check after theme changes.

Multiple TW fields on one entity produce one suggestion string per field (empty fields contribute
an empty string).

## Tokens (`inc/tokens.inc`)
Two token types:
- `suggestion` — `[suggestion:sid]` (machine name; the default/fallback) and `[suggestion:name]`
  (display name). Needs a suggestion entity as data.
- `suggestion-lookup` — chained/dynamic. `[suggestion:lookup:<machine_name>:...]` resolves the
  suggestion by machine name, finds the **first entity that uses it** (from the usage table), and
  chains into that entity's tokens, e.g. `[suggestion:lookup:articles_collection:entity:url:path]`.
  This is the headline Pathauto use: build a content-driven URL pattern that points at whatever node
  holds a given suggestion, without hardcoding a node id. Returns nothing if the suggestion is unused.

## Twig function (`src/TwigExtension/TwigExtension.php`)
`tw_suggestion_entities('<machine_name>')` → the usage records (module/type/id/count rows) for that
suggestion, or `[]`. Registered via the `template_whisperer.twig.extension` service.

## Block visibility Condition (`src/Plugin/Condition/TemplateWhisperer.php`)
Condition plugin id `template_whisperer`, context = a `node`. Config UI (attaches the
`template_whisperer/block` JS library) offers checkboxes of suggestions ("When the node has the
following Suggestion(s)"). Option labels are escaped with `Html::escape()`. `evaluate()` returns
TRUE when the node's suggestions intersect the selected ones; with none selected it returns TRUE
(all allowed). Negation is handled by the condition context system.
