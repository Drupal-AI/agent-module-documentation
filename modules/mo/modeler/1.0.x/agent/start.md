# Workflow Modeler — agent index

React Flow drag-and-drop editor for Drupal workflow models. A **Modeler API plugin**
(`workflow_modeler`), not a standalone tool: it renders the editing UI for a *model owner*
module (usually ECA). No config page (`configure` null), no own permissions, no Drush.
Depends on `modeler_api` (`^1.1`), Drupal `^11.3 || ^12.0`, PHP `>=8.3`.

- **Setup: how it activates, view modes, export, permissions, standalone viewer, library** →
  [configure/setup.md](configure/setup.md)
- **The `workflow_modeler` plugin: JSON model shape, convert/edit/parseData, configForm endpoint,
  query params, backend services** → [plugins/modeler-plugin.md](plugins/modeler-plugin.md)

Key facts:
- Plugin: `src/Plugin/ModelerApiModeler/WorkflowModeler.php` (`#[Modeler(id: "workflow_modeler")]`,
  extends `modeler_api`'s `ModelerBase`). Raw file extension `json`; editable.
- Frontend: compiled React app in `dist/`, asset library `modeler/react-ui`; state injected as
  `drupalSettings.modeler` (`modelId`, `modelData` JSON, `components` palette, `typeMap`).
- Services: `modeler.form_to_json_converter` (`FormToJsonConverter`), `modeler.yaml_schema_lookup`
  (`YamlSchemaLookup`) — both also aliased by FQCN.
- Permissions come from **Modeler API** per model owner (edit metadata / switch context / edit
  templates / create templates / test / replay); this module defines none.
- `src/Hook/LinkHooks.php` adds HTMX attributes to modeler_api add/edit/view links for inline open.
