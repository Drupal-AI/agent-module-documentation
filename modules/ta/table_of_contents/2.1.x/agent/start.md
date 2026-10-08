# Table of Contents — agent index

Auto-generates an in-page TOC **block** from the headings in a long-text field. No global config
page (`configure` null), no permissions. Depends on core `text` + `block`; needs `ext-dom` and
`symfony/css-selector`. Configured per field via third-party settings; placed via Block layout.

- **How to enable per field, the block/deriver, CSS selector, id generation, access** →
  [configure/toc.md](configure/toc.md)

Key facts:
- Supported field types: `text_long`, `text_with_summary`
  (`TocTextFieldHelper::TABLE_OF_CONTENTS_FIELD_TYPES`).
- Per-field settings stored as `third_party_settings.table_of_contents` on the field config:
  `toc_block` (bool), `toc_selector` (string, default `h2`). Schema
  `field.field.*.*.*.third_party.table_of_contents`.
- Block plugin `text_long_field_toc_block` (deriver `TextLongFieldTocBlockDeriver`), one derivative
  per entity-type/bundle/field where `toc_block` is enabled; category "Table of Contents".
- Render: `check_markup` the field → `Html::load` → `CssSelectorConverter` → `DOMXpath` to find
  headings → `item_list` of `#type => link` anchors; JS `table_of_contents.js` fixes up missing ids.
- Block access = host entity `view` AND field `view` access; hidden when the field is empty.
