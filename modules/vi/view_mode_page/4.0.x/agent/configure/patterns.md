<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure View mode page patterns

**Admin UI:** `/admin/config/search/view-mode-page` (list),
`/admin/config/search/view-mode-page/add` (add form). Permission: `administer view_mode_page`.

## The `view_mode_page_pattern` config entity

Config name: `view_mode_page.pattern.<id>`. Exported fields:

| Field | Meaning |
|---|---|
| `id` | Machine name of the pattern. |
| `label` | Human label. |
| `type` | AliasType plugin id, e.g. `canonical_entities:node` (the `canonical_entities` plugin is derived per entity type). |
| `pattern` | Path pattern. **Must include `%`** — the placeholder for the entity's regular URL/alias. E.g. `/%/summary` maps `/my/great/page/summary` → the entity at `/my/great/page`. |
| `view_mode` | The view mode used to render, e.g. `teaser`, `full`, `printable`. |
| `selection_criteria` | CTools condition plugin configs (bundle / language restrictions). Empty = any. |
| `selection_logic` | `and` (default) or `or` across the criteria. |
| `weight` | Ordering when multiple patterns could match (lower first). |
| `relationships` | Context relationships (usually empty). |

## How a request resolves

The `view_mode_page.path_processor` (inbound, priority 250) matches the incoming path against each
pattern's `%`-based pattern. On a match it rewrites to the internal route
`view_mode_page.display_entity` = `/view_mode_page/{view_mode}/{entity_type}/{entity_id}`
(permission `access content`), whose controller renders the entity via a **sub-request** in the given
view mode. It is not an HTTP redirect — the extra path is its own URL.

## Create a pattern with drush (config entity storage)

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern")->create([
    "id" => "article_summary",
    "label" => "Article summary",
    "type" => "canonical_entities:node",
    "pattern" => "/%/summary",
    "view_mode" => "teaser",
    "selection_criteria" => [],
    "selection_logic" => "and",
    "weight" => 0,
  ])->save();
'
```

Read them back:
```bash
drush config:get view_mode_page.pattern.article_summary
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("view_mode_page_pattern")->loadMultiple() as $p) { print $p->id()." => pattern=".$p->get("pattern")." view_mode=".$p->get("view_mode")."\n"; }'
```

List available view modes for an entity type:
```bash
drush php:eval 'print implode(",", array_keys(\Drupal::service("entity_display.repository")->getViewModes("node")));'
```

Config schema: `config/schema/view_mode_page.schema.yml` (`view_mode_page.pattern`). No Drush
commands are provided by the module.
