Mermaid Diagram field adds a `mermaid_diagram` field type (title, diagram code, caption, key, show-code, allow-download subfields) plus a widget and formatter that render stored [Mermaid](https://mermaid.js.org/) source into interactive, pan/zoom SVG diagrams client-side. It also exposes a reusable `mermaid_diagram` Twig theme hook for rendering diagrams from custom code.

---

The module registers a field type (`MermaidDiagramItem`) storing `title`/`diagram`/`caption`/`key` text
columns and two tiny int flags `show_code`/`allow_download`. Its widget (`mermaid_diagram_widget`) is a
set of plain textfields/textareas; its formatter (`mermaid_diagram_formatter`) either renders each item
inline through the `mermaid_diagram` theme, or (per formatter setting `display_in_modal`) renders a
`use-ajax` link that opens the diagram in a Drupal modal via the
`/mermaid-diagram/modal/{entity_type}/{entity_id}/{field_name}/{delta}` route. Diagram text is printed in
the Twig template inside a `<div class="mermaid">` with Twig autoescaping on; the front-end library
(`js/diagram.js`) reads each element's `textContent`, calls `mermaid.render()`, injects the resulting SVG
and attaches svg-pan-zoom. The Mermaid (11.11.0) and svg-pan-zoom (3.6.2) libraries load from the
jsDelivr CDN by default (see `mermaid_diagram_field.libraries.yml`). A formatter `extra_settings` textarea
takes raw JSON that is passed straight to `mermaid.initialize()` (e.g. `theme`, `securityLevel`) via
`drupalSettings`; the module forces `startOnLoad = false`. `hook_theme_suggestions_mermaid_diagram()`
adds `mermaid_diagram__<entity_type>__<bundle>__<field>` style template suggestions. An optional
`show_code` details pane and an `allow_download` "Download .mermaid" button can be toggled per item, and a
Feeds target (`mermaid_feeds_target`) maps all subfields for imports. Note: the `configure` route in
`.info.yml` (`entity.cm_document.config_form`) does not exist in this module and does not resolve.

---

- Add a Mermaid diagram field to a content type, media type, or any fieldable entity.
- Let editors author flowcharts, sequence, class, state, ER, gantt, or pie diagrams in a text field.
- Render stored Mermaid source as an interactive SVG with pan and zoom controls.
- Show a diagram inline in the entity display via the field formatter.
- Open a diagram in a modal dialog instead of inline (formatter "Display in modal" option).
- Give each diagram a heading (title) and an accessible caption (`<figcaption>`).
- Attach an optional legend/"key" diagram alongside the main diagram.
- Expose the raw Mermaid code in a collapsible details pane for copy/paste (`show_code`).
- Offer a "Download diagram" button that saves the source as a `.mermaid` file (`allow_download`).
- Theme Mermaid rendering globally by passing JSON config (theme, securityLevel, fontFamily) via `extra_settings`.
- Provide per-bundle/per-field diagram templates using the generated theme suggestions.
- Render a diagram from custom render arrays with `#theme => 'mermaid_diagram'`.
- Document a content model or workflow visually inside a node body region.
- Import diagrams in bulk through Feeds using the `mermaid_feeds_target` mapper.
- Self-host the Mermaid/svg-pan-zoom libraries by overriding the CDN library definitions.
- Display architecture or process diagrams that editors can maintain without a designer.
- Show a Gantt/timeline diagram on a project page driven by editable Mermaid text.
- Add ER diagrams to data-dictionary pages.
- Provide zoomable diagrams for complex flowcharts that don't fit at page width.
- Keep diagram source version-controllable as plain text field content.
- Add multiple diagrams to one entity via a multi-value Mermaid field.
- Give screen-reader users a described diagram through the required caption subfield.
- Reuse the same diagram markup across templates without duplicating Mermaid code.
