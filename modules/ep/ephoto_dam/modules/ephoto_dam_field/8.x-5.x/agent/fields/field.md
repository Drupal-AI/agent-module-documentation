<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ephoto DAM Field — field type, widget, formatter, constraint

## Install / enable

`drush en ephoto_dam_field -y`. Dependencies: core `field`, core `system`, and parent `ephoto_dam`
(`ephoto_dam_field.info.yml`). The parent module's Server URL (`ephoto_dam.settings.server_url`)
must be set — `ephoto_dam_field_form_alter()` adds `ephoto_dam_field_settings_validate()` to the
field-config form, which errors if `server_url` is empty. `configure` points at the parent's
`ephoto_dam.admin_settings` route.

## Field type — `EphotoDamField`

`@FieldType(id = "ephoto_dam_field", label = "Ephoto Dam Field", category = "Media",
default_widget = "ephoto_dam_field_widget", default_formatter = "ephoto_dam_field_formatter",
constraints = {"EphotoDamFieldValidation" = {}})`.

- `schema()` columns: `identifier` (int unsigned), `url` (varchar 256), `image_size` (varchar 9),
  `version` (varchar 20), `caption` (varchar 256), `thumbnail` (varchar 256).
- `propertyDefinitions()` mirrors those as typed data (`identifier` integer; rest string).
- `isEmpty()` — empty when `url`, `image_size` and `version` are all empty.
- `defaultFieldSettings()` / `fieldSettingsForm()` — settings `version_support` (checkbox; when on,
  a URL is associated per Ephoto version sharing the same label) and `captions_format` (textarea).
- `getHtmlPreview($first)` — builds the display markup: a container with the thumbnail `<img>` (only
  for the first delta), an optional caption line, a link to the asset URL, and metadata "bubbles"
  for size, version name and file identifier.

## Widget — `EphotoDamFieldWidget`

`@FieldWidget(id = "ephoto_dam_field_widget", field_types = {"ephoto_dam_field"})`, extends
`WidgetBase`. `formElement()` renders:

- A **"Select"** button (`file-select` or `versions-select` depending on `version_support`) whose
  `onclick` calls `EphotoDamField['<field_name>'].selectFile(delta)` / `.selectVersions()` — the JS
  (`js/ephoto_dam_field.js`, library `ephoto_dam_field/edit`) opens the Ephoto chooser and writes
  the picked asset's data back into the element fields.
- Fields `url`, `image_size`, `version`, `caption`, `thumbnail` (hidden) and `identifier`. Most are
  marked `readonly`/`onclick=select` in the browser and populated by the chooser JS.
- `ephoto_dam_field_field_widget_single_element_form_alter()` (in the `.module`) attaches library
  `ephoto_dam_field/edit` and passes the field settings plus the parent `server_url` to
  `drupalSettings.ephotoDamField[<field_name>]` for delta 0.

## Formatter — `EphotoDamFieldFormatter`

`@FieldFormatter(id = "ephoto_dam_field_formatter", field_types = {"ephoto_dam_field"})`, extends
`FormatterBase`. `viewElements()` returns, per item, an `inline_template` render element whose
content is `$item->getHtmlPreview($delta === 0)` (thumbnail, caption, asset link, and metadata
bubbles for size/version/identifier).

## Constraint — `EphotoDamFieldValidation`

`Plugin\Validation\Constraint\EphotoDamFieldConstraint` (id `EphotoDamFieldValidation`) +
`EphotoDamFieldConstraintValidator::validate()`: adds a violation only when `image_size` is set and
does **not** match `^[0-9x]+$` (accepts `500`, `500x`, `x500`, `500x500`). No other column is
validated by the constraint.

## Install / update

`ephoto_dam_field.install` → `ephoto_dam_field_update_9370()` adds the `identifier` column to all
existing `ephoto_dam_field` field tables via `entityDefinitionUpdateManager` + schema
`addField()`.

## Libraries

`ephoto_dam_field.libraries.yml`: `preview` (CSS, attached site-wide via
`hook_page_attachments`), `edit` (JS `js/ephoto_dam_field.js` + CSS; deps core/ckeditor5,
core/drupalSettings, core/drupal).
