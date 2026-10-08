# Configuring Field View Mode

## Settings form

- Route `fvm.settings_form` → `/admin/structure/display-modes/view/fvm` (action link on the
  view-mode collection page). Permission: `administer display modes` (core).
- Form (`Drupal\fvm\Form\FvmSettingsForm`) lists every **content** entity bundle that:
  entity implements `ContentEntityInterface`, has a `field_ui_base_route`, has a view builder, and has
  **more than the `default` view mode** (bundles with only `default` are hidden).
- Per bundle:
  - A checkbox `<entityType>__<bundle>` — enable/disable FVM for that bundle.
  - A checkboxes group `<entityType>__<bundle>__view_modes` — limit which view modes appear in the
    dropdown. **If none are checked, all enabled view modes are offered.**
- Extra checkbox `hide_layout_builder_field` appears only when `layout_builder` is enabled and only
  under the `block_content` entity type.

## Config object

Stored in `fvm.settings` (read via `getRawData()`), e.g.:

```yaml
node__article: 1
node__article__view_modes:
  teaser: teaser
  full: 0
hide_layout_builder_field: 1
```

## What submit does (`submitForm`)

For each bundle key (ignoring `__view_modes` keys and `hide_layout_builder_field`):
- **Enabled** → ensures a `FieldStorageConfig` `view_mode_selection` (type `entity_reference`, target
  `entity_view_mode`, **locked**) exists, creates a `FieldConfig` on the bundle with handler
  `field_view_mode` and label "View Mode", and adds the component to the `default` form display using
  widget `fvm_options_select` if the `options` module is on, else `entity_reference_autocomplete`.
- **Disabled** → only if the field's data table has no rows for that bundle: deletes the `FieldConfig`,
  runs `field_purge_batch(10)`, and removes the component from the default form display. If rows exist,
  nothing is deleted (data preserved). README advises hiding the field via form display instead of
  unchecking, to avoid data loss.

## Rendering behavior

`fvm_entity_view_mode_alter()` (in `fvm.module`): when a bundle is enabled in `fvm.settings` and the
entity's `view_mode_selection` reference is set, the effective view mode becomes the second segment of
the referenced `entity_view_mode` id (`explode('.', $id)[1]`). For `block_content`, the switch is
skipped unless `hide_layout_builder_field` is set (so Layout Builder and FVM don't both drive it).

## Layout Builder interaction

`fvm_form_alter()` targets `layout_builder_add_block` / `layout_builder_update_block`:
- If `hide_layout_builder_field` is TRUE → hides core's `settings.view_mode` field (`#access = FALSE`).
- Else → adds `FvmSettingsForm::processBlockForm` which hides **FVM's** `view_mode_selection` on the
  block form (FVM defers to Layout Builder). Default (unset) hides FVM's field.

## Selection & widget internals

- `field_view_mode` (`Plugin/EntityReferenceSelection/FieldViewMode`, extends `DefaultSelection`)
  overrides `buildEntityQuery()` to constrain referenceable `entity_view_mode` ids to
  `<entityType>.<selectedViewMode>` for the current entity's bundle (all enabled modes if none chosen).
- `fvm_options_select` (`Plugin/Field/FieldWidget/FvmOptionsSelectWidget`, extends
  `OptionsSelectWidget`) adds two settings: `default_option` (relabel the empty "Default" option) and
  `remove_default_option` (drop the empty option entirely).
