<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM integrations: Group compatibility, Timeline, Views field

## Group module compatibility (1.x – 4.x)

YASM supports every Group major without a hard dependency, via two pieces:

- **`GroupVersionHelper`** (static, `src/GroupVersionHelper.php`). `isGroupV3()` checks
  `class_exists('\Drupal\group\Entity\GroupRelationship')` to detect Group 3.x/4.x, and picks the
  right **table** (`group_relationship_field_data` vs `group_content_field_data`), roles table
  (`group_relationship__group_roles` vs `group_content__group_roles`) and membership service
  (`group.membership_manager` vs `group.membership_loader`). It also normalizes membership objects to
  `GroupInterface` (`resolveGroup()`), resolves related entity IDs per group (`getRelatedEntityIds()`
  — uses the `entity_type` column on v3+, a `LIKE` pattern on v1/2), and builds hierarchy-aware group
  option labels (`buildGroupHierarchyLabels`, `getDirectParentGroupIdsMap`).
- **`Services\GroupVersionManager`** (`yasm.group_version_manager`) — the DI wrapper injected into
  controllers/forms. It receives the optional `@?group.membership_manager` / `@?group.membership_loader`
  services (null when Group is absent) and delegates to the helper. `GroupsStatistics` uses the same
  helper to pick table names for its parameterized queries. All group table names come from these
  hardcoded constants, never from request input.

`Controller\Groups` and the `_custom_access` checks 403 when Group is disabled even if the `yasm
groups`/`yasm my groups` permission is granted.

## Timeline — `Controller\Timeline`

- `page()` renders the `yasm_timeline` theme with the first chunk of months plus a JSON endpoint URL
  and attaches `yasm/timeline` JS (infinite scroll).
- `data(Request $request)` is the AJAX endpoint (`yasm.statistics.timeline.data`, permission `yasm
  timeline`). It reads `offset`/`limit` from the query, **casts both to int and clamps** (`limit` 1–36,
  default 12), builds per-month created/updated totals for node/file/group/comment/user/taxonomy_term
  (nodes-updated uses distinct `node_revision` rows where `revision_timestamp > created`), and returns
  a `CacheableJsonResponse` (only integers + hardcoded labels + `Y-m` month keys — no user-supplied
  strings). Group filters go through `getSelectedGroupIds()`, intersected against the user's own group
  options, so a user cannot pull data for groups they are not a member of.

## Views field — `Plugin\views\field\NodeTypeNodeCount` (`yasm_entity_count`)

`hook_views_data_alter` (`yasm.module` → `yasm_views_data_alter`) adds a `yasm_{entity}_count` field
to every `{bundle}_field_data` table for content entity types that have a bundle entity type (content
types, vocabularies, media types, group types, …). The field is computed in PHP (`query()` is a
no-op): `render()` reads the current row's bundle entity and calls
`EntitiesStatistics::count($count_entity_type, [bundle => id])`, memoized per bundle, emitting
`#plain_text` with a `{entity}_list` cache tag. Intended for REST/JSON:API exports of "how many items
use this bundle".

## Help hook

`YasmHooks::help()` renders the module's own `README.md` (via `file_get_contents` on the module path)
through the Markdown filter when the `markdown` module is present, else wraps it in `<pre>`. The file
is the packaged, trusted README — not user input.
