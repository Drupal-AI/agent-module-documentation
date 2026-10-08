# CSHS field formatters

Set at **Manage display** (`/admin/structure/types/manage/<bundle>/display`) for a taxonomy
entity_reference field. Four formatters (all in `src/Plugin/Field/FieldFormatter/`, sharing
`CshsFormatterBase`):

| Formatter | Plugin id | Renders |
|---|---|---|
| Full hierarchy | `cshs_full_hierarchy` | The selected term with its complete ancestor path (root → … → term). |
| Flexible hierarchy | `cshs_flexible_hierarchy` | The hierarchy path with configurable trimming/depth. |
| Group by root | `cshs_group_by_root` | Groups the rendered terms under their root ancestor. |
| Specific taxonomy level | `cshs_specific_level_taxonomy` | Only the term at a chosen hierarchy level. |

- Each formatter has its own settings form (e.g. separator, which level, link to term) exposed
  under the field's formatter settings.
- These pair with the [widget](widget.md); "Full hierarchy" is the natural display when the
  widget's `save_lineage` is on.
- Markup is themeable via the CSHS templates — see [../theming/templates.md](../theming/templates.md).
