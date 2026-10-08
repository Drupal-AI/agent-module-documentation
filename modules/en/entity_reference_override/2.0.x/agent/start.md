# Entity Reference Override (entity_reference_override) — agent index

Adds the field type **`entity_reference_override`** ("Entity reference w/custom text"): a core
entity reference plus one extra per-reference text field used to **override** the referenced
entity's title (or add a class / note / replace a text field). **No admin UI**
(`configure` = null), no permissions, no Drush, no new plugin *types* — it only adds field
plugins (type, widgets, formatters).

- **Adding & configuring the field: storage columns, field settings (`override_label`,
  `override_format`), widgets, and the formatter `override_action` modes** →
  [configure/field.md](configure/field.md)
- **The field plugin ids and the core classes they extend (for subclassing / theming /
  integrations: Diff, Feeds, Entity Usage)** → [plugins/plugins.md](plugins/plugins.md)

Key facts:
- Field type id `entity_reference_override` extends `EntityReferenceItem`; adds columns
  **`override`** (varchar 4094) and **`override_format`**.
- Field settings: **`override_label`** (label/placeholder for the custom-text box),
  **`override_format`** (`NULL` = single plain line → can override title/class; a filter format
  = text area → override a text field).
- Widgets: `entity_reference_override_autocomplete` (default), `entity_reference_override_select`.
- Formatters: `entity_reference_override_label` (default) with setting **`override_action`** ∈
  {`title`, `title-append`, `suffix`, `class`, `hide`}; and `entity_reference_override_entity`
  (renders the full entity, override splices into a chosen `string`/`text_long`/`email` field).
- Only **one** override text field per instance, so only one aspect is overridable at a time.
- Submodules: `entity_reference_override_entity_browser` (Entity Browser widget),
  `entity_reference_override_revisions` (Entity Reference Revisions integration, experimental) —
  see this project's `modules/` subtree.
