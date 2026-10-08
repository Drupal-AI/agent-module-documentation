<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search Api Site Studio processor (search_api_sitestudio_processor) — agent index

**Search API processor that decodes Acquia Site Studio (Cohesion) components and indexes their text.**

- **Version:** 1.0.x (info.yml: 1.0.0)
- **Core:** `^9.5 || ^10 || ^11`
- **Depends on:** `search_api` (and, at runtime, Acquia Site Studio: `cohesion`, `cohesion_elements`)
- **Processor plugin:** `sitestudio_component_item` (attribute `#[SearchApiProcessor]`, `locked: TRUE`, `hidden: TRUE`, stage `add_properties`)
- **Property:** `sitestudio_components_value` (type `search_api_html`) — add it as an index field labelled "Sitestudio Components"
- **How it works:** loads `cohesion_layout` from `cohesion_entity_reference_revisions` fields, decodes via `LayoutCanvas`, walks canvas/model, strips tags from richtext, adds concatenated text; per-field config selects all / by category / by single component.
- **Security:** No routes, permissions, forms, or external calls. Indexing is server-side only and gated by Search API's own admin config; all component-tree parsing is wrapped in try/catch with logging. No security-relevant surface.

See [plugins/processor.md](plugins/processor.md)
