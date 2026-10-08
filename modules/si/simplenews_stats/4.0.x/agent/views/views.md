# Views: shipped views and custom plugins

## Shipped views (`config/optional/`)
Installed on module install (and by `simplenews_stats_update_8102` if added later),
only when Views is enabled. Both are access-gated by `access simplenews stats overview`.

| View id | Overrides | Base table |
|---|---|---|
| `simplenews_stats` | the `/admin/content/simplenews-stats` collection | `simplenews_stats` |
| `simplenews_stats_items` | the `/admin/content/simplenews-stats-items` collection | `simplenews_stats_item` |

## Custom Views plugins (`src/Plugin/views/…`)
These are Views handler plugins the module provides; it does **not** define a new
plugin *type*.

| Plugin id | Type | Class | Behaviour |
|---|---|---|---|
| `simplenews_stats_entity_associated` | field | `Plugin/views/field/SimplenewsStatsEntityAssociated` | Renders the associated entity as a link (`getAssociatedEntity()->toLink()`), else "Deleted". |
| `simplenews_stats_entity_associated` | filter | `Plugin/views/filter/SimplenewsStatsEntityAssociated` | Textfield with autocomplete route `simplenews_stats.entity_associated_autocomplete`; `massageValue()` parses `(entity_type|id)` out of the label and filters on `entity_id` + `entity_type`. |
| `simplenews_stats_action` | filter | `Plugin/views/filter/SimplenewsStatsAction` | Select of `click` / `view` on the item `title` field. |
| `simplenews_stats_user` | filter | `Plugin/views/filter/SimplenewsStatsUser` | Textfield with autocomplete route `simplenews_stats.user_autocomplete`; parses `(uid)` from the label and filters on the item `uid`. |

Wiring is in `simplenews_stats_views_data_alter()` (`simplenews_stats.views.inc`) —
see [../hooks/hooks.md](../hooks/hooks.md).

## Autocomplete routes (feed the filters above)
Both require `view simplenews stats` and return JSON.

| Route | Path | Returns |
|---|---|---|
| `simplenews_stats.entity_associated_autocomplete` | `/admin/content/simplenews-stats-item/autocomplete/entity-associated` | Simplenews content-type nodes matching `?q=` (`title LIKE q%`, access-checked) |
| `simplenews_stats.user_autocomplete` | `/admin/content/simplenews-stats-item/autocomplete/user` | Users that appear in `simplenews_stats_item.uid`, matched on `user.name LIKE q%` |

Both labels are built by `SimplenewsStatsTools::getEntityLabel()`, which appends
`(type|id)` (or `(id)`) so the filter's `massageValue()` can recover the ids.
