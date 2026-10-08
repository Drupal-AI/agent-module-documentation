# Entity Form Field Label — agent index

Overrides a field's displayed label per form mode and per display mode, via third-party settings on the
field widget / formatter. Depends only on core `field`. No config page (`configure` null), no routes, no
permissions, no Drush.

- **How to set the label override (UI + third-party settings keys, the `||` separator, empty-label
  behavior, and the hooks that apply it)** → [configure/labels.md](configure/labels.md)

Key facts:
- Adds "Rewrite label" + "New label" to widget settings (*Manage form display*) and formatter settings
  (*Manage display*).
- Stored as third-party settings under `entity_form_field_label`: `rewrite_label` (int/bool),
  `new_label` (string). Schema: `field.widget.third_party.*` / `field.formatter.third_party.*`.
- Applied on forms by `hook_field_widget_complete_form_alter`, on display by `hook_preprocess_field`.
- Empty `new_label` → label hidden. Composite fields use `Label A||Label B` per sub-element.
