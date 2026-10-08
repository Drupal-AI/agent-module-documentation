# Twig Field — agent index

Adds a `twig` field type whose stored value is a Twig template compiled and rendered (via core
`inline_template`) at display time, edited with a CodeMirror editor. Requires `codemirror_editor`.
No global config page (`configure` null); configured per field / display.

- **Field type, widget (CodeMirror), formatter, the `display_mode` context setting, and every context
  variable** → [configure/field.md](configure/field.md)
- **The two alter hooks for widget/formatter context** → [hooks/twig_field.md](hooks/twig_field.md)
- **`access twig fields` permission and why editing is (and must stay) admin-gated** →
  [permissions/twig_field.md](permissions/twig_field.md)

Key facts:
- `TwigItem` (id `twig`), `TwigWidget` ("Template editor"), `TwigFormatter` ("Rendered Twig template").
- Formatter runs `#type => 'inline_template'`, `#template => $item->value` → the stored string is
  executed as Twig (effectively code).
- Editing a `twig` field is forbidden without `access twig fields` (`restrict access: true`) via
  `twig_field_entity_field_access()`.
- Context = `twig_field_default_context()` globals + per-field vars from the field's `display_mode`
  view display + the host entity (keyed by entity type id).
