<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Draggable Mapper provides a custom "draggable_mapper" content entity: upload a background image and place resizable, interactive markers on it with a drag-and-drop editor.

---

Draggable Mapper defines a fieldable content entity type (`draggable_mapper`) whose bundle carries a required background image (`field_dme_image`) and an unlimited multi-value Paragraphs reference (`field_dme_marker`) to a `dme_marker` paragraph type. Each marker paragraph holds a title, optional rich-text description, optional icon image, and four decimal coordinate fields (x, y, width, height) stored as fractions of the container (0–1). On the entity add/edit form, marker paragraphs are edited inline (Inline Entity Form + Paragraphs); JavaScript (jQuery UI draggable/droppable/resizable) lets an editor drag each marker onto a live preview of the image and resize it, writing the resulting position/size into hidden coordinate fields on the paragraph subform. On display, a preprocess hook (`DraggableMapperPreprocessHook`) turns each mapped marker into absolute-positioned percentages and the `draggable-mapper.html.twig` template renders markers over the image, with descriptions shown in click-to-open modals via `draggable_mapper.view.js`. CRUD is exposed at admin-structure routes and gated by five module permissions. The module ships no configuration form; management is via the entity collection at Structure and standard Field UI. It requires Paragraphs, Inline Entity Form, Entity Reference Revisions, and the three jQuery UI component modules.

---

- Build an interactive floor plan of a building, mall, or campus with clickable points of interest.
- Create an evacuation or safety plan where each exit/assembly point is a marker with instructions.
- Annotate a facility or site map with room labels and descriptions.
- Diagram a boat rigging system, labeling each component with a marker and explanation.
- Produce an automotive parts diagram where each part opens a description modal.
- Lay out an HVAC or plumbing system schematic with interactive component callouts.
- Map an electrical circuit or network-infrastructure diagram with labeled nodes.
- Document industrial machinery with markers pointing at each subassembly.
- Add interactive hotspots to a product photo to explain features.
- Create an image-based "choose your area" navigation graphic.
- Mark important locations on a custom (non-geographic) map image with descriptive popups.
- Build educational diagrams (anatomy, geography, science) with explanatory marker modals.
- Show a seating chart or venue layout with clickable seats/zones.
- Annotate an architectural rendering or blueprint for client review.
- Provide a "how it works" exploded-view diagram with per-part descriptions.
- Use custom icon images per marker (e.g. category pins) instead of text labels.
- Display markers as text-only labels when no icon is uploaded.
- Embed a map in a node or other entity via an entity reference field to the draggable_mapper entity.
- Link directly to a map's canonical page (`/draggable-mapper/{id}`) to share it standalone.
- Delegate marker authoring to editors using the drag-and-drop preview instead of typing coordinates.
- Resize markers visually so hotspots scale responsively with the image.
- Give each marker a rich-text description rendered in an accessible modal dialog on the front end.
- Grant separate view/create/edit/delete permissions to different roles for map content.
- Manage marker fields (add/remove/reorder) through standard Paragraphs + Field UI.
- Add SVG support for marker icons by installing the SVG Image module and allowing the `svg` extension.
