<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use natural sort + settings

## Turn on natural sort in a view

The module upgrades eligible string-property sorts from Views' `standard` handler to its `natural`
handler (`hook_views_data_alter()` sets `sort.id = 'natural'` wherever it was `standard`). So on a
view whose base exposes e.g. the node **Title** sort:

1. Add/edit the **Title** sort criterion (Views UI → *Sort criteria*).
2. Choose **"Sort ascending naturally"** or **"Sort descending naturally"** in the order options.
3. Save. The sort now joins the `views_natural_sort` index and orders by the transformed value.

In config the sort criterion looks like:

```yaml
display:
  default:
    display_options:
      sorts:
        title:
          id: title
          table: node_field_data
          field: title
          plugin_id: natural      # the VNS sort handler
          order: NASC             # NASC | NDESC (natural); ASC/DESC = plain
```

`order` is what selects natural vs plain: the handler treats an order beginning with **`N`**
(`NASC`/`NDESC`) as natural; `ASC`/`DESC` fall back to the standard behavior.

### drush

```bash
drush cget views.view.MYVIEW display.default.display_options.sorts
# set a title sort to natural:
drush php:eval '
  $v = \Drupal\views\Entity\View::load("MYVIEW"); $d = $v->get("display");
  $d["default"]["display_options"]["sorts"]["title"] = [
    "id" => "title", "table" => "node_field_data", "field" => "title",
    "entity_type" => "node", "entity_field" => "title",
    "plugin_id" => "natural", "order" => "NASC",
  ];
  $v->set("display", $d)->save();
'
```

## The index table

Sorting reads a precomputed column, not the live title. Table `views_natural_sort`:

| col | meaning |
|---|---|
| `eid` | entity id |
| `entity_type` | e.g. `node` |
| `field` | property name, e.g. `title` |
| `delta` | value delta |
| `content` | the **transformed** sortable string (max 255 chars) |

Rows are written on `hook_entity_insert`/`update` and removed on delete (see `api/service.md`). If
content predates enabling the module (or you change transformation settings), **rebuild the index**
so the `content` values reflect the current pipeline.

## Settings form + config

Route `views_natural_sort.settings` → `/admin/structure/views/settings/views_natural_sort`
(tab under Views settings, permission `administer views`). Config object `views_natural_sort.settings`:

```yaml
rebuild_items_per_batch: 100
transformation_settings:
  remove_beginning_words:
    enabled: true
    settings: [The, A, An, La, Le, Il]     # form: "Words to filter from the beginning"
  remove_words:
    enabled: true
    settings: [and, or, of]                # form: "Words to filter from anywhere"
  remove_symbols:
    enabled: true
    settings: "#\"'\\()[]"                 # form: "Symbols to filter" (no separators)
  numbers:
    enabled: true
    settings: []
  days_of_the_week:
    enabled: false                          # form: "Sort days of the week"
```

- The form fields map to those keys (beginning words / words are comma-separated in the UI, stored as
  arrays; symbols are one unseparated string).
- `rebuild_items_per_batch` controls the reindex batch size.
- Saving the form also **triggers a reindex** (`submitFormReindexOnly`).

```bash
drush cget views_natural_sort.settings
drush cset views_natural_sort.settings rebuild_items_per_batch 250 -y
drush cset views_natural_sort.settings transformation_settings.days_of_the_week.enabled true -y
```

## Rebuild the index

- UI: settings form → **"Incase of Emergency"** details → **Rebuild Index** button.
- Programmatic: `views_natural_sort_queue_data_for_rebuild()` (sets a batch), or the service's
  `queueDataForRebuild()`. There is **no Drush command**. Rebuild after bulk imports or after
  changing transformation settings so stored `content` matches.
