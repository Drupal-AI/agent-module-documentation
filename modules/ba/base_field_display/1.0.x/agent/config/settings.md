<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — base_field_display.settings

## Install / enable
`drush en base_field_display -y` (pulls in core `path`). Then choose which base fields to activate.

## Settings form
- Route `base_field_display.settings_form`, path `/admin/config/content/base-field-display`
  (`base_field_display.routing.yml`), menu link under Configuration > Content authoring
  (`base_field_display.links.menu.yml`).
- Requirement `_permission: 'administer base_field_display configuration'`.
  NOTE: the module ships **no `*.permissions.yml`**, so this permission string is not declared by
  base_field_display itself — grant/declare it elsewhere or the form is reachable only by user 1
  (core denies access to undefined permissions for everyone else).
- Form class `Drupal\base_field_display\Form\BaseFieldDisplaySettingsForm` (extends `ConfigFormBase`),
  form id `base_field_display_settings`.

`buildForm()` lists every entity type where `hasViewBuilderClass()` and
`entityClassImplements(FieldableEntityInterface::class)`, sorted by label, as vertical tabs. For each,
a `checkboxes` element lists the entity type's base fields (`entityFieldManager->getBaseFieldDefinitions()`),
labelled "@label (%name)". `submitForm()` stores only the checked machine names per entity type, clears
the key when none are selected, saves config, then calls
`entityFieldManager->clearCachedFieldDefinitions()` so the `setDisplayConfigurable` alter re-runs.

## Config object `base_field_display.settings`
Schema `config/schema/base_field_display.schema.yml`: a `sequence` keyed by entity-type id, each value a
`sequence` of base-field machine-name strings. Example:

```yaml
node:
  - title
  - created
  - uid
taxonomy_term:
  - name
```

Only base fields listed here are made `setDisplayConfigurable('view', TRUE)`; everything else is untouched.
After changing config, the field-definition cache is cleared automatically on form submit; via API changes,
run `drush cr` / clear cached field definitions.

## Formatter settings schema
- `field.formatter.settings.base_field_display_string` extends `field.formatter.settings.string`.
- `field.formatter.settings.base_field_display_path_string` is an empty `mapping` (no settings).
