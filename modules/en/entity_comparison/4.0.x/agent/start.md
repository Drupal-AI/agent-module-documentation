<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Comparison (entity_comparison) — agent index

Per-session "compare these entities" lists for any content entity bundle, rendered as a table at
`/compare/{id}`. No module dependencies. Admin UI at `/admin/structure/entity_comparison`
(`configure` → `entity.entity_comparison.collection`).

- **Creating a comparison, the config entity, what it auto-generates, view mode + links** →
  [configure/comparisons.md](configure/comparisons.md)
- **Permissions (one generated per comparison) and the access gaps to know about** →
  [permissions/permissions.md](permissions/permissions.md)
- **Blocks, field/formatter, Views field, the toggle route and the rows alter hook** →
  [api/integration.md](api/integration.md)

Key facts:
- Config entity **`entity_comparison`**, `config_export`: `id`, `label`, `uuid`,
  `add_link_text`, `remove_link_text`, `limit`, `entity_type`, `bundle_type`.
  `limit = 0` means unlimited. Canonical link is `/compare/{entity_comparison}`.
- **`postSave()` on create does a lot**: creates the entity view mode
  `{entity_type}.{bundle}_{id}`, rebuilds routes, and calls `drupal_flush_all_caches()`.
  Deleting/renaming is not symmetrical — the generated view mode is left behind.
- Comparison pages are **dynamic routes** built by `EntityComparisonRoutes::routes()`:
  path `/compare/` + the id with underscores replaced by dashes, requirement
  `_permission: "use {id} entity comparison"`. Adding a comparison therefore requires a router
  rebuild before its page exists.
- The toggle route `entity_comparison.action` —
  `/entity-comparison/{entity_comparison_id}/{entity_id}` — requires `access content`.
- State lives in the **session**: `$session->get('entity_comparison_' . $uid)`, structured as
  `[entity_type][bundle][comparison_id][] = entity_id`. Nothing is persisted per user, and the
  anonymous key is `entity_comparison_0` for every anonymous visitor's own session.
- Link render arrays are `#cache: ['max-age' => 0]` and `#access` checks
  `use {id} entity comparison`, so pages showing the link are effectively uncacheable.
- Extension point: `hook_entity_comparison_rows_alter(&$header, &$rows, $comparison_context)`
  where the context carries `entity_comparison`, `entities`, `comparison_fields`.
