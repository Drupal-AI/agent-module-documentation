# Configure ECK entity types & bundles

## The two config entities

| Config entity type id | Config name pattern | `config_export` keys | What it is |
|---|---|---|---|
| `eck_entity_type` | `eck.eck_entity_type.{id}` | `id, uuid, label, created, changed, uid, title, description, status, standalone_url` | One custom content entity type |
| `eck_entity_bundle` (registered per type as `{id}_type`) | `eck.eck_type.{id}.{bundle}` | `type, name, description` | A bundle inside a type |

The bundle class declares config entity id `eck_entity_bundle`, but at runtime
`eck_entity_type_build()` registers a **separate bundle entity type per ECK type**, id
`{id}_type`, with `config_prefix: eck_type.{id}` and `bundle_of: {id}`. So a bundle's real
config name is `eck.eck_type.{id}.{bundle}`, and its storage is `{id}_type`.

## Base fields (per entity type)

An `eck_entity_type` toggles exactly five optional base fields via boolean keys. Enabling a
key adds the column and the matching entity key:

| Key | Base field / entity key added | Notes |
|---|---|---|
| `title` | `title` → also becomes the `label` entity key | Human label of each entity |
| `uid` | `uid` → `uid`/`owner` entity keys | "Author"; also enables `edit own` / `delete own` permissions |
| `created` | `created` entity key | Created timestamp |
| `changed` | `changed` entity key | Changed timestamp |
| `status` | `status`/`published` entity keys | Publish flag; enables `view unpublished` |

`standalone_url` (default TRUE) controls whether entities get a canonical URL
`/{type}/{id}`; when FALSE the canonical falls back to the edit route.

`eck.settings` has one key: `use_admin_theme` (bool, default `true`) — use the admin theme
when creating/editing ECK entities.

## Admin UI routes

- Entity type list / add: `/admin/structure/eck` , `/admin/structure/eck/add`
  (configure route `eck.entity_type.list`, permission `administer eck entity types`).
- Edit/delete type: `/admin/structure/eck/{eck_entity_type}` , `.../delete`.
- Bundle list/add: `/admin/structure/eck/{type}/bundles` , `.../bundles/add`.
- Add fields to a bundle: standard Field UI at
  `/admin/structure/eck/entity/{type}/bundles/{bundle}/fields` (`field_ui_base_route` is
  `entity.{type}_type.edit_form`).
- Manage content: `/admin/content/{type}` , add at `/admin/content/{type}/add/{bundle}`.

## Inspect / drush

```bash
# List all ECK entity types (config entities):
drush config:status | grep eck.eck_entity_type   # or:
drush php:eval 'print_r(array_keys(\Drupal\eck\Entity\EckEntityType::loadMultiple()));'

# Read one type's config (base fields are the boolean keys):
drush config:get eck.eck_entity_type.event

# Read a bundle:
drush config:get eck.eck_type.event.conference

# Change the global setting:
drush config:set eck.settings use_admin_theme false -y
```

Creating types/bundles in code (which is what actually installs the tables): see
[../api/eck.md](../api/eck.md).
