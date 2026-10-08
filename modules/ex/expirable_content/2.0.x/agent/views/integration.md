<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration

`hook_views_data()` (`expirable_content.views.inc`) delegates to `ViewsData::getViewsData()`. For every entity
type that `ExpirableContentInformation::isExpirableEntityType()` marks expirable, two virtual columns —
`expiration` and `warning` — are added to **both** the target entity's data/base table and its
revision-data/revision table.

Each column declares:

- `field` → id `expirable_content_field`, `default_formatter: string`, with `field_name` `expiration_date` or
  `warning_date`.
- `filter` → id `expirable_content_filter`, `allow empty: TRUE`.
- `sort` → id `expirable_content_sort`.

## Handlers (`src/Plugin/views/`)

- **`ExpirableContentField`** (`@ViewsField("expirable_content_field")`) extends core `EntityField`.
- **`ExpirableContentFilter`** (`@ViewsFilter("expirable_content_filter")`) extends core `Date`.
- **`ExpirableContentSort`** (`@ViewsSort("expirable_content_sort")`) extends core `SortPluginBase`.

All three share **`ExpirableContentJoinViewsHandlerTrait`** (concept borrowed from Content Moderation's
`ModerationStateJoinViewsHandlerTrait`). Its `ensureMyTable()` builds a standard join from the source entity's
revision key to `expirable_content`'s revision-data table on `content_entity_revision_id`, with extra conditions
`content_entity_type_id = <source type>` and `content_entity_id = <source id>` (plus a `langcode` join when the
source is translatable), aliased as `expirable_content_field_revision`.

## Practical use

- Add the `Expiration date` / `Warning date` **fields** to a view of the target entity to display the dates.
- Add the date **filter** to list content already expired, or whose warning window has opened (relative-date
  filtering; empty allowed).
- Add the **sort** to order content by soonest expiration/warning.
- Because the join targets the revision table, filters/sorts resolve against the revision reached by the view's
  relationship (default vs latest revision).
