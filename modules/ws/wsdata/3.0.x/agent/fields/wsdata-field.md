# wsdata_field — a web-service-backed entity field

Submodule `wsdata_field`. Dependencies: `wsdata`, `token`, `field_ui`. It lets a field's value
be populated from a WSCall at entity-load time instead of from the database, by creating a field
with **custom storage** plus a `wsfield_config` entity that binds it to a call.

## Concept

- `WSFieldAddFieldForm` (a subclass of core `FieldStorageAddForm`) creates a normal field but
  with `custom_storage => TRUE` on its field storage.
- A `wsfield_config` config entity (id = field machine name) records which WSCall to run and how.
- `hook_entity_load()` (`wsdata_field.module`) walks each content entity's custom-storage fields,
  runs the bound WSCall via the `wsdata` service, and `$entity->set()`s the field to the result.
- On entity forms, the field widget is hidden (it is not user-editable — it comes from the
  service). `hook_views_data_alter()` exposes each wsfield as a Views field
  (`wsdata_field_views`).

## `wsfield_config` entity (prefix `wsdata_field.wsfield_config.*`)

Exported keys: `id`, `wscall`, `label`, `replacements`, `returnToken`, `data`,
`languageHandling`.

| Key | Meaning |
|---|---|
| `wscall` | WSCall id to run. |
| `replacements` | Values for the call's `[name]` replacements. |
| `returnToken` | `$key` selector into the decoded result. |
| `data` | Request body/data. |
| `languageHandling` | `entityLanguage` (entity's langcode) or `interfaceLanguage` (current UI language). |

At load, replacements are passed together with a token context of `[<entity_type> => $entity]`,
so a call configured with e.g. `[node:field_x]` in its path resolves against the entity being
viewed. The field-config form (`WSFieldConfigForm`) shows a token tree for `node` tokens.

## Routes / permission

Added by `wsdata_field\Routing\RouteSubscriber` on every entity type that has a
`field_ui_base_route`:

| Route name | Path suffix | Form |
|---|---|---|
| `wsdata_field.field_wsfield_config_add_<entity_type>` | `…/fields/add-wsfield` | `WSFieldAddFieldForm` |
| `entity.field_config.<entity_type>_wsfield_edit_form` | `…/fields/{field_config}/wsfield_config` | `wsfield_config.edit` |

Both require permission `administer <entity_type> wsfields` (e.g. `administer node wsfields`).
Note: the module ships **no** `*.permissions.yml`, so these permission strings are not
registered for the roles UI — plan to grant them programmatically / via a config permission, or
they are reachable only by the superuser. An "Add wsfield" local action
(`wsdata_field.field_wsfield_config_add`, deriver `WSFieldLocalAction`) appears on the Manage
Fields page, and an entity-operation link "Web service configurations" appears on custom-storage
fields.
