Workflow Modeler is a React Flow based, drag-and-drop visual editor for Drupal workflow models. It is a plugin implementation of the [Modeler API](https://www.drupal.org/project/modeler_api) and provides the editing UI for any module (most commonly [ECA](https://www.drupal.org/project/eca)) that registers as a Modeler API model owner.

---

The module ships a single Modeler API plugin, `workflow_modeler` (`src/Plugin/ModelerApiModeler/WorkflowModeler.php`, extending `modeler_api`'s `ModelerBase`), plus a compiled React app in `dist/` exposed as the `modeler/react-ui` asset library. It has **no configuration page** (`configure` is null), defines **no permissions of its own** (the six modeler actions — edit metadata, switch context, edit templates, create templates, test, replay — are provided and enforced by Modeler API for each model owner), and adds no Drush commands. The plugin's job is to translate between the model owner's stored components and a JSON document the React canvas understands: `convert()`/`edit()` build a `nodes`/`edges` JSON payload plus a component palette and attach it as `drupalSettings.modeler`; `parseData()` reads the JSON posted back from the browser and rebuilds `modeler_api` `Component`/`ComponentSuccessor` objects (nodes become elements, edges with a `condition` become link components, per-node/edge `annotation` strings become annotation components). Two small backend services support the editor: `modeler.form_to_json_converter` (`FormToJsonConverter`) serialises a component's Drupal config form to JSON for rendering in the property panel, and `modeler.yaml_schema_lookup` (`YamlSchemaLookup`) resolves config-schema keys so YAML textarea fields get schema-aware editing. A `configForm` JSON endpoint returns the serialised form for a given plugin/configuration. `LinkHooks` (attribute hooks) transparently upgrades links to modeler_api add/edit/view routes with HTMX attributes so models open inline. Beyond editing, the React app supports execution replay (step through past run data via a `hash` query param), live testing, search, flow filtering, dark mode, undo/redo, and export to Recipe, Archive, JSON, or SVG, plus a standalone read-only viewer built separately from `ui/`.

---

- Give ECA workflows a modern drag-and-drop visual editor instead of the classic form UI.
- Provide a React Flow canvas for any module that implements the Modeler API model-owner interface.
- Author event-condition-action models by dropping event, action, condition, and gateway nodes and connecting them.
- Attach a condition to an edge (or a condition-first placeholder node) using the quick-add "+" popup.
- Configure each node/edge through a dynamic property-panel form generated from the plugin's Drupal config form.
- Edit YAML configuration fields with config-schema-aware assistance via the schema lookup service.
- Replay a past workflow execution visually, stepping through token values available at each step.
- Trigger a live test run from the modeler and see results highlighted on the canvas.
- Export a model as a distributable Drupal **Recipe**.
- Export a model as a compressed **Archive** of configuration files.
- Export a model as portable **JSON** for loading into the standalone viewer.
- Export a **SVG** snapshot of the canvas for documentation or slides.
- Embed a read-only workflow diagram on a non-Drupal web page with the standalone viewer.
- Search nodes and edges by label, plugin, type, or ID with live canvas highlighting.
- Show or hide individual event flows in a multi-flow model to focus the view.
- Add documentation annotations to any node or edge.
- Undo/redo canvas changes with Ctrl+Z / Ctrl+Shift+Z.
- Switch between fullscreen and a draggable, resizable floating editor window.
- Toggle light/dark theme with the preference persisted in browser local storage.
- Open a model inline (HTMX) from a model-owner list without a full page reload.
- Preselect a component on open via the `select` query parameter (deep-linking to a node).
- Seed a new model's context from `context` / `contextConfig` query parameters.
- Track frequently used components as per-user favorites in the quick-add palette.
- Build custom AI-agent or automation authoring UIs on top of Modeler API using this modeler.
