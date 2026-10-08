Entity Reference with Layout (ERL) is a "paragraphs + layout" field: an entity-reference-revisions field type whose widget lets content authors visually arrange referenced paragraphs into layout sections and regions (drag-and-drop), rendering them through core Layout Discovery layouts.

---

The module defines the `entity_reference_layout_revisioned` field type (extending Paragraphs'
entity-reference-revisions item with extra `region`, `layout`, `section_id`, `options` and
`config` properties), a matching drag-and-drop widget (`entity_reference_layout_widget`, using
the bundled `dragula` JS and jQuery UI dialog), and a formatter that rebuilds the section →
region → paragraph tree and renders each section with its core layout plugin. Authors add
"Section" paragraphs (each mapped to a Layout Discovery layout), then drop content paragraphs
into the layout's regions; per-section layout *options* (container CSS classes, background
color) are merged onto the rendered wrapper via `entity_reference_layout_merge_attributes`,
which also dispatches an `ErlMergeAttributesEvent` so other modules can add attributes. A
global settings form (`entity_reference_layout.settings`) toggles showing paragraph-type and
layout labels in the widget. One permission, `manage entity reference layout sections`, gates
adding/editing sections in the widget. The project is an **experimental dev release** (2.x,
`minimum-stability: dev`) — the maintainers advise heavy testing before production, and it is
closely related to (and largely superseded by) the Layout Paragraphs module. Two submodules
ship default layouts (`erl_layouts`) and a ready-made "Section" paragraph type
(`erl_paragraphs`).

---

- Let content authors build multi-column page layouts out of paragraphs, visually.
- Add a "Paragraph with Layout" field to a content type for structured page building.
- Drag and drop paragraphs between layout regions in the edit form.
- Assign a core Layout Discovery layout (one/two/three-column, etc.) to each section.
- Nest content paragraphs inside named regions (header/primary/secondary/footer).
- Keep unused paragraphs in a "Disabled items" area without deleting them.
- Apply per-section container CSS classes for theming.
- Set a per-section background color from the author UI.
- Extend rendered layout attributes from another module via `ErlMergeAttributesEvent`.
- Alter the section options form via `ErlPropertiesFormEvent`.
- Show or hide paragraph-type and layout labels in the widget for author clarity.
- Gate section creation/editing behind the `manage entity reference layout sections` permission.
- Render referenced paragraphs recursively through their view modes within the layout.
- Provide ready-made column layouts by enabling the `erl_layouts` submodule.
- Get a pre-built "Section" paragraph type by enabling the `erl_paragraphs` submodule.
- Migrate from ad-hoc paragraph stacks to structured, layout-aware content.
- Prototype landing pages without Layout Builder on the entity.
- Normalize/serialize ERL field values (a JSON normalizer is provided for the field item).
- Replicate ERL fields correctly when cloning entities (Replicate integration).
- Evaluate a Bricks/Layout-Paragraphs-style authoring model on an existing paragraphs site.
