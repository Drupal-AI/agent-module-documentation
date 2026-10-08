# Using the VERF filter in a View

VERF has **no admin settings page** (`configure` is `null`; there is no `verf.routing.yml`,
no permissions, no Drush). You configure it entirely inside the Views UI. Just enable the
module (`drush en verf -y`) and the filter becomes available.

## Where the filter comes from

`verf_views_data_alter()` (in `verf.module`) registers a companion filter for every entity
reference field, keyed by the field's `_target_id` column name with a `_verf` suffix:

- **Configurable fields**: for each `field_config` of type `entity_reference`, on table
  `{target_entity_type}__{field_name}`, column `{field_name}_target_id`, it adds
  `{field_name}_target_id_verf`.
- **Base fields**: for each SQL-stored base field of type `entity_reference` (e.g. a node's
  author `uid`), it adds a `{column}_verf` entry on that field's table.

Each generated entry has title `"{Field label} (VERF selector)"`, group `verf` (base
fields) or the field's own group (configurable fields), and `filter.id = verf`. The filter
definition carries `verf_target_entity_type_id` (the reference target's entity type), which
the plugin uses to load the correct storage.

## Adding it (Views UI)

1. Edit a View whose base entity has an entity reference field (or add an entity-reference
   relationship first if you want to filter a referenced entity's own fields).
2. **Add filter criteria** → search for the field label followed by **"(VERF selector)"**.
3. Configure the exposed filter as usual (expose to visitors, label, operator).
   The value control is a select/checkbox list of **entity labels**, not IDs.

## Filter handler options

The plugin is `Drupal\verf\Plugin\views\filter\EntityReference` (`@ViewsFilter("verf")`),
extending core `InOperator`. Its settings form adds:

| Option | Key | Behavior |
|---|---|---|
| Target entity bundles to filter by | `verf_target_bundles` | Only shown when the target entity type is bundleable. Checkboxes of bundles; when any are checked, the option list is limited to entities in those bundles (query with `accessCheck(TRUE)`). Empty = all bundles. |
| Ignore access control | `show_unpublished` | Checkbox (default off). When off, only entities the current user can `view` are listed. When on, all entities (including unpublished / access-restricted) appear. |

### How options are built (`getValueOptions()`)

- Loads referenceable target entities (optionally bundle-filtered).
- For each, switches to the current **content-language** translation if one exists.
- If the user lacks `view label` access, the option renders as **"- Restricted access -"**
  (the entity's existence stays hidden but the row is kept).
- Otherwise the option value is the entity ID and the display is `$entity->label()`.
- The full list is `natcasesort()`-ed (case-insensitive natural order).

## Config schema

`config/schema/verf.schema.yml` defines `views.filter.verf` (type `views_filter`) with:

- `verf_target_bundles`: sequence of strings (selected bundle IDs).
- `value`: sequence of strings (selected target entity IDs — the exposed filter value).

Note: `show_unpublished` is a plugin option (defaults to `FALSE` via `defineOptions()`) but
is **not** listed in the schema mapping.

## Example (exported View filter)

```yaml
filters:
  field_refs_target_id_verf:
    id: field_refs_target_id_verf
    table: node__field_refs
    field: field_refs_target_id_verf
    operator: in
    value: {  }
    exposed: true
    expose:
      label: 'Refs (VERF selector)'
      identifier: field_refs_target_id_verf
    verf_target_bundles:
      article: '0'
      page: '0'
    plugin_id: verf
```

## Caching

The plugin merges cacheability from the view and the target entity type's list cache
metadata: `getCacheTags()`, `getCacheContexts()`, and `getCacheMaxAge()` combine parent +
`$view->storage` + `$targetEntityType` list cache tags/contexts. `valueForm()` also applies
the handler's own cacheability metadata to the exposed form.
