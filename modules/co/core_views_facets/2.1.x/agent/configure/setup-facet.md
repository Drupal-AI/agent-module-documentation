<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up a facet from a core View

No config form of its own — you work through the **Facets** UI plus the View. State is stored in
Facets' `facets_facet_source.*` and `facets_facet.*` config entities.

## Prerequisites (on the View)

1. A View with at least one **page** display.
2. That display has at least one **exposed filter** and/or one **contextual filter (argument)**.

Once such a display exists, `core_views_facets` derives facet source plugins for it:

| Filter kind on the display | Facet source plugin id |
|---|---|
| exposed filter(s) | `core_views_exposed_filter:<view_id>__<display_id>` |
| contextual filter(s) | `core_views_contextual_filter:<view_id>__<display_id>` |

(Deriver: `CoreViewsExposedFilterDeriver` / `CoreViewsContextualFilterDeriver`. Run `drush cr`
after editing the view so the derivatives refresh — the module also clears them on view save.)

## The mandatory URL-processor step

Go to *Configuration → Search and metadata → Facets* (`/admin/config/search/facets`), open the
**facet source** for your view display, and set its **URL processor** to
**"Core views url processor"** (`core_views_url_processor`). This is required — it formats the
query URL the way Views' exposed filters expect. Without it, facet links do not filter the view.

In config this is the `facets_facet_source` entity:

```yaml
# facets.facet_source.core_views_exposed_filter__myview__page_1
id: core_views_exposed_filter__myview__page_1
name: 'core_views_exposed_filter:myview__page_1'
url_processor: core_views_url_processor
filter_key: f
```

## Add the facet

At `/admin/config/search/facets/add-facet`, choose the core-views facet source and pick the
**field** — for an exposed-filter source the field is the exposed filter's identifier; for a
contextual source it is the argument id. Save, configure a widget, then place the facet block
(*Structure → Block layout*, or the `facet_block:<facet_id>` block plugin) in the same region as
the view.

Key `facets_facet` fields:

- `facet_source_id`: the plugin id, e.g. `core_views_exposed_filter:myview__page_1`.
- `field_identifier`: the exposed filter id (e.g. `type`) or the contextual argument id.
- `widget`: `{type: links, config: {...}}` (any Facets widget).

## Programmatic example (what the UI writes)

```php
use Drupal\facets\Entity\Facet;
use Drupal\facets\Entity\FacetSource;

// 1) Facet source with the required core-views URL processor.
FacetSource::create([
  'id' => 'core_views_exposed_filter__myview__page_1',
  'name' => 'core_views_exposed_filter:myview__page_1',
  'filter_key' => 'f',
  'url_processor' => 'core_views_url_processor',
])->save();

// 2) A facet on one of the view's exposed filters (here: the 'type' filter).
Facet::create([
  'id' => 'myview_type',
  'name' => 'Content type',
  'url_alias' => 'type',
  'facet_source_id' => 'core_views_exposed_filter:myview__page_1',
  'field_identifier' => 'type',
  'widget' => ['type' => 'links', 'config' => ['show_numbers' => TRUE]],
])->save();
```

## Behaviour notes

- Deleting a view display auto-deletes its facet sources and their facets
  (`hook_entity_presave` in `core_views_facets.module`).
- On AJAX-enabled view displays the facet block attaches
  `core_views_facets/core_views_facets.views.ajax` so facets refresh in place.
- "Hard limit" on a `search_api_db` backend has a documented tie-breaking edge case (see README).
