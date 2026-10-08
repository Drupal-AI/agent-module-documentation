# Paragraph Bundle Content — agent index

Submodule of **Paragraphs Bundles**. Adds the `pb_content (node type)`, `pb_block (block_content type)` Paragraph type(s). No config UI (`configure` null), no permissions, no Drush. Bundle fields/type ship as `config/optional` and install with the module.

Shared behavior (fields, Display-tab styling, CSS-variable rendering, how to add/override) is documented once in the parent:
- Parent index → [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)
- Display-tab fields + custom field types → [../../../../1.0.x/agent/plugins/fields.md](../../../../1.0.x/agent/plugins/fields.md)
- CSS-variable template pattern + theming → [../../../../1.0.x/agent/theming/rendering.md](../../../../1.0.x/agent/theming/rendering.md)
- Provisioning + cloning a bundle → [../../../../1.0.x/agent/extend/bundles.md](../../../../1.0.x/agent/extend/bundles.md)

This bundle:
- Bundle `pb_content (node type)` — configure via *Manage fields / form display* on the paragraph type; style via the Display tab.
- Bundle `pb_block (block_content type)` — configure via *Manage fields / form display* on the paragraph type; style via the Display tab.

Key facts:
- Bundle id(s): `pb_content`, `pb_block`.
- Depends on: `paragraphs_bundles`, `node`, `block`, `block_content`, `paragraph_bundle_image`.
- Template(s): `templates/paragraph--<bundle>.html.twig` (override in your theme). Styling contract = the `--pb-*` CSS variables.
