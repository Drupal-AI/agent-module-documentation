<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the "Entity usage count" field to a view

There is no settings form. You use the module by adding its Views field to a view whose base
entity type is tracked.

## Prerequisites

1. Entity Usage (`entity_usage`) is enabled and has recorded usage into the `entity_usage` table.
2. The view's **base table** is the entity type you want counts for (e.g. a Content view for
   nodes, a Media view for media).
3. If `entity_usage.settings:track_enabled_target_entity_types` is **empty/null**, the field is
   offered on *all* entity types with Views data. If it lists specific types, the field is only
   offered for those. Check with:
   ```bash
   drush cget entity_usage.settings track_enabled_target_entity_types
   ```

## Via the Views UI

1. Edit the view, click **Add** next to *Fields*.
2. Search for **Entity usage count** (machine id `entity_usage_views_field`) and add it.
3. Save. Each row now shows the number of other entities whose current revision references it.

## In view config (YAML / drush)

A field handler entry in `views.view.<id>` looks like:

```yaml
display:
  default:
    display_options:
      fields:
        entity_usage_views_field:
          id: entity_usage_views_field
          table: node_field_data          # base table of the entity type
          field: entity_usage_views_field
          plugin_id: entity_usage_views_field
          entity_type: node               # set by the handler's configuration
          label: 'Usage'
```

## Optional: render the count as a modal link

To make the number open the entity's Entity Usage report in a modal (requires the target
type's *Enable local tasks* option in Entity Usage settings):

1. Add a field that outputs the usage URL for the entity, e.g. `/node/{{ id }}/usage`, placed
   **before** the usage-count field.
2. Edit the *Entity usage count* field → **Rewrite results** → tick *Output this field as a
   custom link* and put the usage-URL token in *Link path*.

The handler's `renderAsLink()` automatically adds `class="use-ajax"`,
`data-dialog-type="modal"` and `data-dialog-options` (width 700) to that link.

## Limitations

- **Not sortable, not filterable** — the value is computed in PHP per row (revision-aware), not
  via the SQL query, so Views cannot sort or filter on it.
- Only counts usages recorded against each source entity's **default/current revision**.
