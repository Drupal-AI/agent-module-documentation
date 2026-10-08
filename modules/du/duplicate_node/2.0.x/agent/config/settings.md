<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings forms & configuration

## Config object `duplicate_node.settings`

Shipped defaults (`config/install/duplicate_node.settings.yml`):

```yaml
prefix_for_node_title: "duplicate of"
exclude:
  node: {}
  paragraph: {}
duplicate_status: false
```

Keys (no config **schema** file is shipped — `provides_config_schema: false`):
- `prefix_for_node_title` (string) — prepended (with a trailing space) to the duplicate's title
  and to duplicated Layout Builder block labels; also used as the page title.
- `duplicate_status` (bool) — if TRUE the copy keeps the source's published status; if FALSE the
  copy's published key is reset to the **content type default**.
- `duplicate_layout_block_status` (bool) — if TRUE, custom/inline blocks in the node's
  `layout_builder__layout` are duplicated and re-linked into the copy (read in
  `DuplicateNodeForm::save()`). Not present in the install defaults; written by the settings form.
- `exclude.node.<bundle>` (array of field machine names) — node fields **not** copied.
- `exclude.paragraph.<bundle>` (array of field machine names) — paragraph fields **not** copied.

## Node settings form

Route `duplicate_node.settingsform` → `/admin/config/duplicate-node-settings`
(`DuplicateNodeSettingsForm`, `entityTypeId = 'node'`, form id
`duplicate_node_node_setting_form`; menu link under `system.admin_config_content`). Permission:
`Administer Duplicate Node Settings`. Adds three top fields — `prefix_for_node_title` (textfield),
`duplicate_status` (checkbox), `duplicate_layout_block_status` (checkbox) — then the shared
exclusion UI from the parent class, and saves those three keys in `submitForm()`.

## Paragraph settings form

Route `duplicate_node.paragraph_settings_form` → `/admin/config/duplicate-node-settings-paragraph`
(`DuplicateNodeParagraphSettingsForm`, `entityTypeId = 'paragraph'`, form id
`duplicate_node_paragraph_setting_form`). Adds no extra fields of its own — only the shared
exclusion UI for paragraph bundles. Both forms appear as local-task tabs ("Node" / "Paragraph")
under the settings route.

## Shared exclusion UI (`src/Form/DuplicateNodeEntitySettingsForm.php`)

Abstract `DuplicateNodeEntitySettingsForm` extends `ConfigFormBase`, implements
`DuplicateNodeEntitySettingsFormInterface`, edits `duplicate_node.settings`. `buildForm()`:
- An "Exclusion list" fieldset with a `bundle_names` checkboxes element (bundles of
  `$entityTypeId` from `entity_type.bundle.info`); selecting a bundle triggers an **AJAX**
  callback (`fieldsCallback`) that rebuilds a `fields` `<div id="fields-wrapper">` details area.
- For each selected bundle, a checkboxes element of that bundle's **`FieldConfig`** fields
  (configurable fields only), defaulted from `getDefaultFields()` (`exclude.<entityType>.<bundle>`).

`submitForm()` writes `exclude.<entityTypeId>` as `{bundle: [field, ...]}` for every selected
bundle with checked fields, then a status message. Helpers: `getEntityBundles()`,
`getSelectedBundles()`, `getDefaultFields()`, `getSettings()`, `getEditableConfigNames()`
(returns `['duplicate_node.settings']`). Exclusions are consumed by the duplication engine (see
[api/internals.md](../api/internals.md)).
