<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration (two levels)

Configuration is split between one global config object and per-bundle third-party
settings. Both must be set for a "Usage" tab to appear and show anything.

## 1. Global settings form

- Route `entity_usage_light.settings`, path `/admin/config/content/entity_usage_light`,
  requirement `_permission: administer entity_usage_light settings`. Menu link under
  *Configuration → Content authoring* (`entity_usage_light.links.menu.yml`).
- `Form\SettingsForm` (`src/Form/SettingsForm.php`, `ConfigFormBase`, editable config
  `entity_usage_light.settings`): a single `checkboxes` element `active_on` listing every
  **content** entity type. Checking a type enables the "Usage" tab for it.
- `submitForm()` writes each `active_on.<id>` as a bool, then rebuilds routes/menu:
  `plugin.cache_clearer->clearCachedDefinitions()` + `router.builder->rebuild()` (needed so
  the alter-hook link templates and derived routes/tasks appear).

### Config object `entity_usage_light.settings`

- `config/install/entity_usage_light.settings.yml`: `active_on: {}` (empty by default;
  `hook_install` sets `active_on.node = TRUE` on standard-profile sites).
- Schema `config/schema/entity_usage_light.schema.yml`: `active_on` is a `sequence` of
  `boolean`, `FullyValidatable`.

Example export:

```yaml
# entity_usage_light.settings.yml
active_on:
  node: true
  media: false
```

## 2. Per-bundle third-party settings

Set on each bundle's own edit form (e.g. *Structure → Content types → Article → Edit*),
injected by `EntityTypeInfo::formAlter()` (`hook_form_alter`) as a details group
`entity_usage_light` under *Additional settings*:

- `entity_type_ids` — `checkboxes` of all content entity types; which referenced types the
  Usage tab detects on this bundle.
- `entity_type_views` — per selected type, a `select` (`<id>_usage_light_view`) choosing a
  View (base entity = that type) to render results, or "Default table".
- If `active_on` for the bundle's entity type is off, the form shows only a link to the
  settings form instead of the controls.
- Saved by the `setThirdPartySettings()` validate handler onto the bundle config entity as
  third-party settings under provider `entity_usage_light`.

### Schema for third-party settings

`entity_usage_light.schema.yml` aliases `node.type.*.third_party.entity_usage_light` (and
`media.type.*`, `taxonomy.vocabulary.*`) to a mapping of:
`entity_type_ids` (sequence of string) and `entity_type_views` (sequence of string).

## Permissions (`entity_usage_light.permissions.yml`)

- `administer entity_usage_light settings` — access the settings form.
- `access entity_usage_light information` — access every entity's "Usage" tab/operation.

## Uninstall

`hook_uninstall` removes the `entity_usage_light` third-party settings from all bundles and
deletes the module's config objects, then clears caches.
