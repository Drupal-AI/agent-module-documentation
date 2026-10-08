BPMN.iO integrates the JavaScript BPMN.io (bpmn-js) diagram editor into Drupal's admin UI, giving a graphical, drag-and-drop modeler for building process models such as ECA models and AI agents. It is a Modeler plugin for the modeler_api framework rather than a standalone tool.

---

BPMN.iO ships a `bpmn_io` plugin implementing modeler_api's `Modeler` plugin type, so any module that acts as a modeler_api "model owner" (notably ECA and AI Agents) can render and edit its config entities as a visual BPMN diagram. The plugin's `edit()` method builds a Drupal render array containing the canvas, a toolbar of widget buttons (info, auto-layout, download SVG, copy/paste, zoom in/out/fit, search, minimap) and a property panel, then attaches the bundled bpmn-js library (v13.2.2, MIT) plus every owner component turned into a bpmn-js element template. Users click elements on the canvas to open an off-canvas properties panel (`configForm()`), which reuses the owner's own plugin configuration forms (ECA events/conditions/actions, AI agent tools, etc.). Diagram data is stored as BPMN 2.0 XML; the `Parser` service converts that XML into modeler_api `Component` objects (start events → tasks → gateways → sequence flows → subprocesses → annotations/participants) and back, using `mtownsend/xml-to-array` and PHP's DOM extension. A `convert()` path migrates an existing owner config entity that has no diagram yet into a laid-out BPMN model client-side. The modeler only works under the Claro or Gin admin themes (or a subtheme of them); `hook_bpmn_io_supported_themes_alter()` lets you whitelist additional themes. The module has no admin settings form, permissions, or config schema of its own — it is enabled and then selected as the modeler by a model-owner module. It also registers a `bpmn_io` icon pack (via the Icon API) for its toolbar glyphs.

---

- Give ECA models a graphical drag-and-drop editor instead of the fallback table-based UI.
- Visually build and edit AI agent definitions (from the ai_agents module) as a BPMN diagram.
- Add start events, tasks, gateways and sequence flows to a process by dragging them onto a canvas.
- Configure an element (e.g. an ECA action or condition) through the off-canvas properties panel.
- Wire conditional branches between steps using BPMN exclusive gateways and sequence-flow conditions.
- Group related steps inside a BPMN subprocess for a cleaner model layout.
- Annotate a model with free-text notes (BPMN text annotations) for documentation.
- Auto-layout an imported or messy diagram with one toolbar click.
- Zoom, fit-to-canvas, and use the minimap to navigate large process models.
- Search the canvas to jump to a specific element in a big model.
- Copy and paste selected elements within or between models.
- Download the current model as an SVG image for docs or review.
- Convert an existing ECA/agent config entity that was built without a diagram into a laid-out BPMN model.
- Select `bpmn_io` as the active modeler for a model-owner module that supports multiple modelers via modeler_api.
- Serve a read-only diagram view of a model to users who should not edit it.
- Clone a model to a new ID/label while preserving its diagram (via the modeler's clone support).
- Enable or disable a model's executable status from the modeler (toggles the BPMN `isExecutable` attribute).
- Store a model's tags, version, changelog and documentation as BPMN extension properties.
- Provide plugin templates in the palette derived from the owner's available components (events/conditions/actions).
- Link an element's configuration form to its upstream documentation via the properties-panel help widget.
- Whitelist a custom admin subtheme for the modeler with `hook_bpmn_io_supported_themes_alter()`.
- Round-trip a model: parse BPMN XML into modeler_api Components server-side and re-serialize edits back to XML.
- Apply element templates (Camunda-style property/field bindings) so plugin config maps onto BPMN elements.
- Use it as the default editor behind ECA and AI Agents so both share one consistent visual modeling experience.
