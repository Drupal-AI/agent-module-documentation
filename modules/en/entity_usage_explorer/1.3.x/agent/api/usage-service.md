<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overview page, `UsageService`, and reference discovery

## Install & enable

```bash
composer require drupal/entity_usage_explorer
drush en entity_usage_explorer -y
drush cr
```

Core-only. No dependencies, no config to set. Grant the permission
**`access entity usage dashboard`** (`/admin/people/permissions`) to the roles that should see
usage data.

## The overview page

- Route `entity_usage_explorer.usage_page` (`entity_usage_explorer.routing.yml`):
  `GET /admin/usage/{entity_type}/{entity_id}`, guarded by
  `_permission: 'access entity usage dashboard'`.
- `UsageOverviewController::getUsagePage($entity_type, $entity_id)`
  (`src/Controller/UsageOverviewController.php`) calls
  `UsageService::getEntityUsage()` and returns
  `#theme => 'entity_usage_overview'` with `#target_entity_type`, `#target_entity_id`, `#data`.
- `getTitle()` renders the page title "Usage statistics for: *entity_type(entity_id)*" via `t()`.
- `hook_theme()` (`entity_usage_explorer.module`) declares the `entity_usage_overview` theme hook →
  `templates/entity-usage-overview-page.html.twig`.

## Service: `UsageService` (`entity_usage_explorer.usage`)

Constructed with `@database`, `@entity_type.manager`, `@plugin.manager.field.field_type`
(`entity_usage_explorer.services.yml`). Key methods in `src/UsageService.php`:

- `loadContentEntityTypes($include_definition_data = FALSE)` — every entity type implementing
  `ContentEntityInterface`. With `TRUE` it returns each type's `label` key and `canonical`
  link template (used by the Twig helper).
- `getEntityReferences($entity_type, $bundle_to_query)` — finds entity-reference-like fields.
  It filters `field_type` plugin definitions to classes that are subclasses of
  `EntityReferenceItemBase`, queries `field_storage_config` for fields of `$entity_type` whose
  type is in that set (`->accessCheck(FALSE)` — this is a **config-entity** query), and keeps
  those whose `target_type` equals `$bundle_to_query`. Returns, per match, the data table
  `{entity_type}__{field_name}`, column `{field_name}_target_id`, `field_name`, `target_type`.
- `getEntityUsage(string $target_entity, int $entity_id): array` — the main call. For every
  content entity type: `menu_link_content` is handled by `getEntityUsageInMenu()`; every other
  type has its matching reference field tables selected with
  `db->select($table)->fields()->condition($column, $entity_id)`. Results are grouped by
  referring entity type. If `$target_entity == 'paragraph'` it also adds
  `paragraphs_library_item` rows via `getParagraphUsageInLibraryItems()`.
- `getEntityUsageCount(string $target_entity, int $entity_id): int` — same discovery but
  `countQuery()` per table, plus the menu count and (for paragraphs) the library-item count.
  This is what the Views field renders.
- `getEntityUsageInMenu($target_entity, $entity_id, $only_count = FALSE)` — selects
  `menu_link_content_data` where `link__uri` LIKE `entity:{type}/{id}` **or**
  `internal:/{type}/{id}`.
- `getParagraphUsageInLibraryItems($paragraph_id, $only_count = FALSE)` — selects
  `paragraphs_library_item_field_data` on `paragraphs__target_id`. Only meaningful when the
  Paragraphs (Library) module is present.

All DB conditions use the query builder with bound values; entity ids are typed `int`. Table and
column names are derived from **system** entity/field definitions (not from request input).

## Twig helper: `UsageHelper` (twig extension)

`src/UsageHelper.php` registers six Twig functions used only by the overview template:
`loadParagraphParent`, `getEntityLabel`, `getEntity`, `getCanonicalPath`, `getLanguageName`,
`getEntityUrl`. They load a referring entity, resolve its label key, its canonical URL/path, its
language name, and (for paragraphs) walk `getParentEntity()` up to the entity that embeds it.

## What the template shows

For each discovered reference the template
(`templates/entity-usage-overview-page.html.twig`) prints a table row: entity type, bundle, id,
language, last-updated (`changed`), published status, and a link to the referring entity (or, for
a paragraph with no canonical route, a link to its parent entity or that parent's own usage page).
A "Total usage" line sums the rows. All dynamic values pass through Twig autoescaping.

## Notes / caveats

- Discovery is limited to **entity-reference-type fields, menu-link URIs, and Paragraphs Library
  items** on the *current* revision. A URL typed into body text, a path hard-coded in a template,
  or an id passed through custom code is **not** detected — "no usages" means "no *tracked*
  usages".
- `getEntityUsage()` iterates every content entity type and, for each, runs a
  `field_storage_config` query plus one select per matching field table. On sites with many
  content types/reference fields this is a number of queries proportional to the schema — a
  capacity consideration for large sites, mitigated by page cache.
