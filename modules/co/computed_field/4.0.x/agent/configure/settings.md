# configure — settings & the computed_field config entity

## Module setting

One config object, `computed_field.settings`:

| Key | Default | Meaning |
|---|---|---|
| `field_prefix` | `computed_` | Prefix prepended to the machine name of fields created via the Field UI. |

```bash
drush config:get computed_field.settings field_prefix
drush config:set computed_field.settings field_prefix computed_ -y
```

There is **no admin settings form** and `configure` in info.yml is unset. The prefix only
affects fields created through the Computed Field UI submodule.

## Permission

`administer computed_field entities` (`restrict access: TRUE`) — gates creating, editing and
deleting computed fields (used by the UI submodule's routes).

## The `computed_field` config entity

A **configured** computed field is stored as a `computed_field` config entity — the analogue
of a `field_config` for stored fields. Config name:
`computed_field.computed_field.{entity_type}.{bundle}.{field_name}`; entity id is
`{entity_type}.{bundle}.{field_name}` (UI-created field names carry the `computed_` prefix).

Exported keys (`config/schema/computed_field.schema.yml`):

| Key | Meaning |
|---|---|
| `id` | `entity_type.bundle.field_name` |
| `field_name` | Machine field name |
| `label` | Human label |
| `entity_type` | Host entity type id (e.g. `node`) |
| `bundle` | Host bundle (e.g. `article`) |
| `plugin_id` | The computed field plugin supplying the value |
| `plugin_config` | Plugin configuration (schema keyed by `plugin_id`) |

The entity implements `FieldConfigInterface`, so it appears on the standard "Manage fields"
list; it is always a **bundle** field, always read-only, and its field **type** comes from
the plugin (`$entity->getType()`), not from stored config.

Example exported YAML for the bundled `reverse_entity_reference` plugin:

```yaml
langcode: en
status: true
id: node.article.computed_backlinks
field_name: computed_backlinks
label: 'Backlinks'
entity_type: node
bundle: article
plugin_id: reverse_entity_reference
plugin_config:
  reference_field: node-field_related   # HOST_ENTITY_TYPE-FIELD_NAME of the referencing field
```

Inspect existing ones:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("computed_field")->loadMultiple() as $id => $e) { print $id . " plugin=" . $e->get("plugin_id") . " type=" . $e->getType() . "\n"; }'
```

To create one in code, see [../api/programmatic.md](../api/programmatic.md).
