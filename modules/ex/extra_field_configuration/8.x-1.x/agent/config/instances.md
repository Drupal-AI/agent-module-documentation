<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra field instances: the config entity, admin CRUD and rendering

## Install & enable

```bash
composer require drupal/extra_field_configuration   # pulls drupal/extra_field ^2||^3
drush en extra_field_configuration -y
drush en extra_field_configuration_examples -y      # optional: sample plugins
```

Depends on core `field` and contrib `extra_field`. No settings form; you manage instances at
`/admin/structure/extra-field`.

## The config entity

`Entity\ExtraFieldConfiguration` (`@ConfigEntityType id = "extra_field_configuration"`,
`config_prefix = "display"`, `admin_permission = "administer extra fields"`). Handlers:
`list_builder` = `Controller\ExtraFieldConfigurationListBuilder`; forms `add`/`edit` =
`Form\ExtraFieldConfigurationForm`, `delete` = `Form\ExtraFieldConfigurationDeleteForm`.

`config_export` / stored keys:

| Key | Meaning |
|---|---|
| `id` | Machine name. Also the basis of the Twig field name (`extra_field_{id}`). |
| `label` | Human-readable administration name. |
| `plugin_id` | The `@ExtraFieldDisplay` plugin this instance configures. |
| `bundles` | Nested map `entity_type => [bundle, …]` of where it appears. |

Config object name: `extra_field_configuration.display.{id}`. Schema is
`config/schema/extra_field_configuration.schema.yml` (type `config_entity`; `bundles` is a
`sequence` of `sequence` of `string`).

Example exported config:

```yaml
# extra_field_configuration.display.promo_badge.yml
id: promo_badge
label: 'Promo badge'
plugin_id: example_configurable_field
bundles:
  node:
    - article
    - page
  block_content:
    - basic
```

Entity accessors (`ExtraFieldConfigurationInterface`): `getPluginId()`, `getBundles()`,
`getEntityBundles($entity_id)`, `getBundlesFormatted()` (flattens to `entity.bundle` strings, the
form extra_field expects), `setBundles()/setBundle()`, and `getRealFieldName()` →
`"extra_field_{plugin_id}:{id}"` (the internal display-component key).

## Routes & permission

All in `extra_field_configuration.routing.yml`, every one gated `_permission: 'administer extra fields'`:

| Route | Path | Purpose |
|---|---|---|
| `entity.extra_field_configuration.collection` | `/admin/structure/extra-field` | List (`_entity_list`). |
| `entity.extra_field_configuration.add_form` | `/admin/structure/extra-field/add` | Add. |
| `entity.extra_field_configuration.edit_form` | `/admin/structure/extra-field/edit/{extra_field_configuration}` | Edit. |
| `entity.extra_field_configuration.delete_form` | `/admin/structure/extra-field/{extra_field_configuration}/delete` | Delete (confirm form). |

Menu link under *Structure* + an "Add extra field instance" action link
(`*.links.menu.yml`, `*.links.action.yml`). Permission defined in `*.permissions.yml`
(`administer extra fields`). Add/edit are Form API entity forms; delete extends
`EntityConfirmFormBase` — all POST, core CSRF-protected; there is no state-changing GET.

## The add/edit form (`ExtraFieldConfigurationForm`)

- `plugin_id` select is built from `manager->getBaseDefinitions()` (only non-derived plugins that
  declare the deriver) via `getExtraFieldsAsOptions()`.
- `getFieldableEntityTypes()` collects every entity type that has an `entity_view_display`, sorts
  alphabetically; `priorityEntities()` (`block_content`, `node`, `paragraph`) render at the top,
  the rest under an "Advanced" details element.
- `addBundles()` renders one `checkboxes` element per entity type from
  `entity_type.bundle.info`; defaults from `getEntityBundles()`.
- `save()` writes each entity type's checked bundles via `array_filter` (empty selections dropped),
  saves the entity, then calls `clearFormCaches()`.
- `exists()` checks machine-name uniqueness.

## The list builder (`ExtraFieldConfigurationListBuilder`)

Columns: *Administration Name* (`label`), *Field Name* (`extra_field_{id}` — copy this for
templates), *Extra Field Provider* (`plugin_id`), *Appears On* (bundles summary). Operations are
relabelled "Edit instance" / "Delete instance". Empty text links to the add form.

## The delete form (`ExtraFieldConfigurationDeleteForm`)

Confirm form; its description lists the active view displays the instance appears on
(`getActiveDisplayNames()` → `getFieldActiveDisplays()`). On submit: deletes the entity, calls
`removeExtraFields()` to remove the component from active `entity_view_display` entities, then
`clearFormCaches()`.

## How instances reach the display (`.module` + trait)

- `hook_entity_extra_field_info()` → `manager->fieldInfo()` advertises each derived instance as a
  display extra field on its configured bundles (so it shows on *Manage display*).
- `hook_entity_view()` → `manager->entityView()` renders it. The manager override renames the build
  key from `extra_field_{plugin}:{id}` to `extra_field_{id}` so Twig prints `content.extra_field_{id}`.
- `ExtraFieldConfigurationTrait::clearFormCaches()` clears both extra-field managers' cached
  definitions and invalidates the `entity_field_info` cache tag so Manage-display forms refresh.
- Caveat documented in the trait: core `EntityDisplayBase::removeComponent()` marks the removed
  field `hidden` in the display config; the module cannot fully clear that artifact, so a leftover
  `hidden` entry may remain and can be ignored or removed manually.
