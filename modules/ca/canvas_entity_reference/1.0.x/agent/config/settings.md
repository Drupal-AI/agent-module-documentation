<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable

`composer require drupal/canvas_entity_reference` then `drush en canvas_entity_reference`. Requires
the `canvas` (Experience Builder) module. `lifecycle: experimental`.

## Settings form

`SettingsForm` (`src/Form/SettingsForm.php`), a `ConfigFormBase`, form id
`canvas_entity_reference_settings`.

- Route `canvas_entity_reference.settings` → `/admin/config/content/canvas-entity-reference`,
  permission **`administer site configuration`**.
- Menu link `canvas_entity_reference.settings` under `system.admin_config_content` (weight 20).

Fields:

- **Default single-value widget** (`widget`) — select of `entity_reference_autocomplete`
  ("Autocomplete") or `entity_reference_autocomplete_tags` ("Autocomplete (tags)"). Applies to
  single-value props; overridable per-prop with `x-entity-widget`.
- **Target vocabularies** (`target_bundles`) — checkboxes of taxonomy vocabularies; empty = allow
  all. Taxonomy-only; overridable per-prop with `x-entity-type-bundles`. `submitForm()` stores
  `array_values(array_filter(...))` of the checked machine names.
- **Allow auto-creation of new terms** (`auto_create`) — checkbox, default TRUE. Gates the
  auto-create JS behaviour and the create-term endpoint.

## Config object & schema

Config object **`canvas_entity_reference.settings`** (constant
`EntityReferenceConstants::CONFIG_NAME`).

`config/install/canvas_entity_reference.settings.yml` defaults:

```yaml
widget: entity_reference_autocomplete
target_bundles: []
auto_create: true
```

`config/schema/canvas_entity_reference.schema.yml`:

```yaml
canvas_entity_reference.settings:
  type: config_object
  mapping:
    widget:          { type: string }
    target_bundles:  { type: sequence, sequence: { type: string } }
    auto_create:     { type: boolean }
```

Keys are exposed as constants: `CONFIG_KEY_WIDGET` = `widget`, `CONFIG_KEY_TARGET_BUNDLES` =
`target_bundles`, `CONFIG_KEY_AUTO_CREATE` = `auto_create`.

## How the settings are consumed

- `widget` — read in `EntityReferenceShapeMatcher::apply()` as the fallback single-value widget
  (falls back to `entity_reference_autocomplete` if unset). Per-prop `x-entity-widget` wins.
- `target_bundles` — read in `EntityReferenceShapeMatcher::resolveTargetBundles()` and
  `AutoCreateTermController::resolveVocabulary()`; each configured vocabulary is validated against
  the actually-registered taxonomy bundles, invalid ones dropped, empty/all-invalid → unrestricted.
- `auto_create` — read in `EntityReferenceHooks::attachAutoCreateBehavior()` (attach JS + data
  attribute), in `EntityReferenceShapeMatcher::buildInstanceSettings()` (sets
  `handler_settings['auto_create']` / `auto_create_bundle`), and in
  `AutoCreateTermController::resolveTerm()` (endpoint returns 403 when disabled).
