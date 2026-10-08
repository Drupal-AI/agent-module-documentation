<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fences tag registry & extension points

Fences is **not** a Drupal plugin-manager module — it defines no annotated/attribute plugin
type. Its extensibility is a YAML discovery registry of wrapper tags plus one alter hook.

## The tag registry (`*.fences.yml`)

The dropdowns on the per-field settings form are populated by the
`fences.tag_manager` service (`Drupal\fences\TagManager`, interface `TagManagerInterface`),
which discovers a `MODULE.fences.yml` (and `THEME.fences.yml`) file in every enabled module
and theme and merges them (cached in `cache.discovery`). Fences ships its own
`fences.fences.yml` listing the standard HTML tags. Each entry:

```yaml
section:
  label: Section
  group: Sectioning
  description: Generic Document Or Application Section
```

- **key** = the literal tag emitted (e.g. `section`, `h3`, `ul`, `pre code`, `span`).
- `label` = shown in the select; `group` = optgroup (`Sectioning`, `Phrasing`, `List`,
  `Block-level`, `Forms`); `description` = help text.

To add a custom tag, drop a `mymodule.fences.yml` in your module with the same shape — it then
appears in every Fences field/label/item/items-wrapper dropdown. No PHP required.

`fences.tag_manager` exposes `getTagOptions()` → an array of `group => [tag => label]` used to
build the `#options` of each select.

## The `none` value

`TagManagerInterface::NO_MARKUP_VALUE` is the string `'none'`. It is the sentinel meaning
"emit no wrapper element". `fences_preprocess_field()` compares each stored tag against it to
decide the `display_*_tag` booleans (see [../theming/fences.md](../theming/fences.md)). `none`
is a valid value for any of the four tag settings.

## Altering the settings form (`hook_..._alter`)

Fences invokes `hook_fences_field_formatter_third_party_settings_form_alter(array &$settingsForm)`
after building the per-field **Fences** settings form, so other modules can add elements to it.
Documented in `fences.api.php`:

```php
function mymodule_fences_field_formatter_third_party_settings_form_alter(array &$settingsForm) {
  $settingsForm['fences']['my_checkbox'] = [
    '#type' => 'checkbox',
    '#title' => t('Enable custom feature'),
    '#default_value' => FALSE,
  ];
}
```

If you add elements whose values must persist, you must also extend the config schema via
`hook_config_schema_info_alter()` (a value-only visual element needs no schema — that is exactly
how **fences_presets** injects its preset selector without saving anything). The core settings
form itself is built in `fences_field_formatter_third_party_settings_form()` (a
`hook_field_formatter_third_party_settings_form()` implementation), and the Manage-display
summary line is added by `fences_field_formatter_settings_summary_alter()`.
