<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# display_name field type, widget & storage

Source: `src/Plugin/Field/FieldType/DisplayNameItem.php`, `src/Plugin/Field/FieldWidget/DisplayNameWidget.php`,
`src/Element/DisplayName.php`, and the FAPI helpers in `displayname.module`. Traits under `src/Traits/` supply the
shared settings forms.

## Install & attach

1. `drush en displayname` (pulls in `field`, `user`, `token`).
2. Add a field of type **Display name** to any fieldable entity (Field UI, or a `FieldStorageConfig` with
   `type: display_name`). Attaching it to `user`/`user` is the common case for a real-name field.

## Storage (`DisplayNameItem::schema()`)

Six nullable `varchar(255)` columns, one per component:
`title`, `first`, `middle`, `last`, `full`, `alias`. Indexes exist on `first`, `last`, `alias`, `full`.
`propertyDefinitions()` exposes each as a string property; `mainPropertyDisplayName()` returns NULL (no single main
value). `isEmpty()` ignores a lone `title` (it has no meaning by itself).

`preSave()` builds a fallback **full** name when the `full` column is empty: it concatenates the active components in
order, prefixing a title only when it is not the placeholder `-- --`, and wrapping a bare alias in parentheses.

## Field settings

Defaults come from the traits (`getDefaultDisplayNameFieldSettings()` etc.) merged in `defaultFieldSettings()`, plus
`override_format => 'default'`. Config schema key `field.field_settings.display_name`
(`config/schema/displayname.schema.yml`). Notable keys:

- `components` / `minimum_components` — booleans per component: which parts are enabled, and which are required.
  `allow_last_or_first` relaxes the requirement so either first OR last satisfies it.
- `max_length`, `size`, `labels`, `title_display`, `field_type` (textfield / select / autocomplete per component).
- `autocomplete_source` + `autocomplete_separator` — per-component sources feeding the autocomplete route.
- `title_options` / `sort_options` — option lists for select components; an option of the form
  `[vocabulary:machine_name]` is expanded to that vocabulary's term names by `DisplayNameOptionsProvider::getOptions()`
  (respecting `max_length`), and an option prefixed `--` becomes the empty/default label.
- `widget_layout` (`stacked` | `inline`), `field_title_display`, `show_component_required_marker`.
- `preferred_field_reference` / `alternative_field_reference` (+ `_separator`) — pull extra name parts from another
  field on the same entity (see formatter doc).

`fieldSettingsForm()` adds an `#element_validate` of `DisplayNameItem::validateUserDisplayName()` — a **field-settings
only** admin control that, when the "override user login name" checkbox is set, writes the chosen field machine name
into `displayname.settings:user_display_name` and invalidates every `user:<uid>` cache tag so the new name renders.

## Widget (`display_name_default`)

`formElement()` builds a `#type => 'display_name'` element. When the widget's `override_field_settings` is on (and it
is not the default-value widget) the widget settings are merged over the field settings; otherwise field settings win.
For each enabled component it sets type `textfield`, or `select` (options via `DisplayNameOptionsProvider`), or
`autocomplete` (route `displayname.autocomplete` with field_name/entity_type/bundle/component parameters). Component
labels are passed through `Html::escape()`. `massageFormValues()` drops rows where every translatable component is
empty.

The FAPI element is expanded by `displayname_element_expand()` / `displayname_element_render_component()` in
`displayname.module`: each component is wrapped in a `<div class="display-name-*-wrapper">`, gets standard classes,
and honours a `title_display` of title / placeholder / none / attribute / description. `DisplayName::preRender()`
(`src/Element/DisplayName.php`) applies the stacked/inline wrapper and layout library. `displayname_element_validate()`
enforces the minimum-components rule and required state.

## Views, Feeds, autocomplete

- Views fulltext filter `display_name_fulltext` searches a `LOWER(CONCAT(...))` of all six columns with bound
  placeholders — see `config/settings.md`.
- Feeds target `display_name` maps import columns to the components — see `config/settings.md`.
- Autocomplete matching lives in `DisplayNameAutocomplete::getMatches()`; results come only from the configured
  option sources, not from arbitrary stored rows.
