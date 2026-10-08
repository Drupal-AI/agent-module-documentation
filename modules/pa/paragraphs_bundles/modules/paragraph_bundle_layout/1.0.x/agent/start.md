# Paragraph Bundle Layout — agent index

Submodule of **Paragraphs Bundles**. Adds the `one_column_bundle`, `two_columns_bundle`, `three_columns_bundle` Paragraph type(s). No config UI (`configure` null), no permissions, no Drush. Bundle fields/type ship as `config/optional` and install with the module.

Shared behavior (fields, Display-tab styling, CSS-variable rendering, how to add/override) is documented once in the parent:
- Parent index → [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)
- Display-tab fields + custom field types → [../../../../1.0.x/agent/plugins/fields.md](../../../../1.0.x/agent/plugins/fields.md)
- CSS-variable template pattern + theming → [../../../../1.0.x/agent/theming/rendering.md](../../../../1.0.x/agent/theming/rendering.md)
- Provisioning + cloning a bundle → [../../../../1.0.x/agent/extend/bundles.md](../../../../1.0.x/agent/extend/bundles.md)

This bundle:
- Bundle `one_column_bundle` — configure via *Manage fields / form display* on the paragraph type; style via the Display tab.
- Bundle `two_columns_bundle` — configure via *Manage fields / form display* on the paragraph type; style via the Display tab.
- Bundle `three_columns_bundle` — configure via *Manage fields / form display* on the paragraph type; style via the Display tab.

Key facts:
- Bundle id(s): `one_column_bundle`, `two_columns_bundle`, `three_columns_bundle`.
- Depends on: `paragraphs_bundles`.
- Template(s): `templates/paragraph--<bundle>.html.twig` (override in your theme). Styling contract = the `--pb-*` CSS variables.
