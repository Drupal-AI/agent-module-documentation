# Block Attributes — agent index

Attach arbitrary HTML attributes to blocks: define an attribute list globally, fill values per
block. Depends on core `block`. `configure` route `block_attributes.config`. No own permissions,
no config schema, no plugins.

- **The YAML config, the settings form, per-block fields, render/escaping** →
  [configure/attributes.md](configure/attributes.md)

Key facts:
- Global definition config object `block_attributes.config` → `attributes` map:
  `name: {label, description, options?}`. Ships one entry: `class`. Edited as raw YAML at
  `/admin/structure/block/attributes` (`ConfigForm`, permission `access administration pages`).
- `hook_form_block_form_alter` adds one input per defined attribute to every block form; values
  saved in the block's `settings.attributes`. `administer blocks` is required to edit a block.
- `block_attributes_preprocess_block` merges values into the block `attributes` render array.
- `BlockAttributesChecker::isAttributeAllowed($name)` blocks names matching `^on[a-z]+$`
  (JS event handlers), checked at save and at render.
- Attribute names + values are `Html::escape()`'d by core's `Attribute` renderer.
