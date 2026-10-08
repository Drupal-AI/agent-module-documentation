Webform Custom Options turns HTML or SVG markup into an interactive, selectable options input — letting users pick options by clicking regions of a graphic (e.g. a seating chart, floor plan, or map) instead of using a plain select list.

---

Some choices are inherently visual: pick your seat, choose a room, select a country on a map, tap a body part on a diagram. Webform Custom Options provides a **Custom options** webform element (`webform_options_custom`, plus an entity-backed variant) that maps `data-option-value` attributes in your HTML/SVG to option values, so clicking a shape selects that option — as a single or multiple input. Reusable templates are stored as `webform_options_custom` config entities managed at `/admin/structure/webform/options/custom/manage`, each holding the markup, CSS, and option metadata (the module ships example "buttons" and "us_states" templates). It has a config schema so templates are exportable, and a preview screen to check rendering. Element and entity plugins (with derivatives) expose the custom options as normal webform elements, and it supports descriptions per option and multiple-selection behavior. It is ideal for graphical pickers where a standard dropdown would be poor UX.

---

- Build a clickable seating chart for event booking.
- Let users pick a room or booth from a floor-plan SVG.
- Create a US-states map selector (ships as an example).
- Offer styled button groups instead of plain radios (example template).
- Select a country or region from an interactive map.
- Choose a body area on an anatomical diagram (symptom forms).
- Pick a table on a restaurant/venue layout.
- Select a parking space from a lot diagram.
- Build a color/pattern swatch picker from SVG shapes.
- Let users choose a product zone on a warehouse map.
- Create a size/fit selector from a garment graphic.
- Reuse a custom-options template across multiple webforms.
- Store and version graphic pickers as exportable config.
- Preview a custom options template before using it.
- Support single or multiple selection on a graphic.
- Add per-option descriptions shown on hover/selection.
- Map SVG regions to option values via data attributes.
- Provide an accessible visual alternative to long dropdowns.
- Bind custom options to an entity reference source.
- Design bespoke pickers with custom HTML and CSS.
