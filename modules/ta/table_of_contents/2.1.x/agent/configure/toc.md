# Configure a table of contents

No admin settings page — configuration is per field plus a block placement.

## 1. Enable on a field

Edit a `text_long` or `text_with_summary` field
(`/admin/structure/types/manage/<bundle>/fields/...`). `table_of_contents_form_field_config_edit_form_alter`
injects a "Flexible Table of Contents" details group under
`third_party_settings[table_of_contents]`:

- `toc_block` (checkbox) — "Enable the TOC block for this field".
- `toc_selector` (textfield, default `h2`) — CSS selector for the heading elements.

Saved as third-party settings on the `field_config` entity (schema
`field.field.*.*.*.third_party.table_of_contents`). Toggling `toc_block` triggers a block rebuild
(`TocTextFieldHelper::onFieldConfigPreSave` → `block` module `rebuild`) so the derived block
appears/disappears.

## 2. Place the block

With `toc_block` enabled, the deriver `TextLongFieldTocBlockDeriver` exposes a block
`text_long_field_toc_block:<entity_type>.<bundle>.<field_name>` (admin label
"TOC for: <entity> > <bundle> > <field>", category "Table of Contents"). Place it via
*Structure → Block layout*. It requires the `entity` (bundle-constrained) and `language` contexts,
so place it where those are available (e.g. the node view).

## Rendering details (`TextLongFieldTocBlock`)

- Concatenates all field values, running each through `check_markup($value, $format)`.
- Parses with `Html::load`, converts the `toc_selector` via `symfony/css-selector`
  (`CssSelectorConverter`) to XPath, queries with `DOMXpath`.
- Emits `#theme => item_list__table_of_contents` of `#type => link` anchors
  (`Url::fromRoute('<none>', ['fragment' => $id])`).
- Existing heading `id`s are used as-is; missing ones get a generated id
  (`toc-<slug>-<hash>`) and class `toc-link-invalid-id`; `table_of_contents.js` then assigns the
  id to the matching heading in the DOM client-side.
- `blockAccess`: host entity `view` access AND field `view` access; returns forbidden if the
  field is empty or absent.

## Notes

- Supported field types are hardcoded (`text_long`, `text_with_summary`) — `@todo` to make
  configurable.
- No permissions and no Drush; the only config is the per-field third-party settings plus the
  block placement config.
