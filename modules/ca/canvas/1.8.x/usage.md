Drupal Canvas is a visual, in-browser experience builder: content creators and site builders compose pages and content displays by arranging reusable components (SDCs, blocks, and JavaScript "code components") into a stored "component tree", wiring component props to Drupal data — no code required beyond optional JSX/CSS.

---

Canvas inverts Drupal's traditional data-first workflow: you build a layout (an ordered tree of component instances) first, then selectively wire data into it. Every layout is stored in a new "component tree" field type; each instance records its component type, slot, and prop "inputs". Props get values either as static values stored with the layout or via "prop sources" (e.g. entity-field prop sources that read from the host entity using prop expressions, similar to tokens but shape-aware). Canvas infers a JSON-Schema "shape" for every component prop and every Drupal field so it only offers field mappings that actually fit ("shape matching"). Components come from pluggable ComponentSources: single-directory components (SDC), core blocks, and JavaScript code components authored in the UI and stored as `js_component` config entities. It ships many config entity types — Component, Pattern, Folder, ContentTemplate, PageRegion (page template), AssetLibrary, BrandKit, JavaScriptComponent — plus a `canvas_page` content entity for standalone pages. A React single-page app (booted at `/canvas`, `/canvas/editor/{entity_type}/{entity}`) drives an internal HTTP API, with an auto-save/draft-and-publish workflow. It is extensible through `canvas.component_source`, `canvas.extension`, and `canvas.adapter` plugin types, and hooks for altering prop shapes and import maps. Note: as of 1.x the module explicitly ships NO stable public PHP or HTTP API — everything is `@internal` (public APIs targeted for 1.1.0).

---

- Give non-developers a browser-based drag-and-drop builder for landing pages without Layout Builder's field-block clutter.
- Build standalone Canvas Pages (`canvas_page` entity) at `/admin/content/pages` for marketing/landing content.
- Compose content displays for existing entity types/bundles via ContentTemplate config entities (visual replacement for Manage Display).
- Define reusable page templates / regions (header, footer, sidebar) with the PageRegion "page template" feature.
- Author JavaScript code components (React/JSX + CSS) directly in the UI, stored as `js_component` config entities.
- Expose core blocks as Canvas components so existing block plugins can be dropped into a layout.
- Use single-directory components (SDC) from a theme or module as first-class Canvas building blocks.
- Wire component props to fields on the host entity (dynamic "entity field prop sources") so a card component renders live node data.
- Set static prop values stored with the layout for content that doesn't come from a Drupal field.
- Rely on shape matching so editors only see field mappings whose data shape fits a prop (e.g. only image fields for an image prop).
- Save reusable Patterns (pre-arranged component groups) and organize components into Folders.
- Manage brand tokens (colors, fonts, logo) centrally with a BrandKit and shared AssetLibrary CSS/JS.
- Edit rich-text (HTML) props inline with CKEditor 5 via the bundled `canvas_html_block`/`canvas_html_inline` text formats.
- Preview and edit any content entity's layout live at `/canvas/editor/{entity_type}/{entity}`.
- Work with an auto-save draft workflow, then publish auto-saved changes to entities (gated by the "publish auto-saves" permission).
- Restrict who can build vs. who can author code (separate "administer components" and restricted "administer code components" permissions).
- Extend the builder UI with custom panels/pages via `canvas.extension` plugins (canvas-type or code-editor-type extensions).
- Add new component sources (beyond SDC/block/code) by implementing a `canvas.component_source` plugin.
- Alter which storable prop shape (field type + widget) is used for a given JSON-Schema prop via `hook_canvas_storable_prop_shape_alter()`.
- Customize the JavaScript import map used by code components with `hook_canvas_importmap_alter()`.
- Integrate AI assistance for building/editing components by enabling the `canvas_ai` submodule.
- Secure an external HTTP API surface with OAuth2 by enabling `canvas_oauth`.
- Enable Vite hot-module-reload for fast code-component development with `canvas_vite`.
- Serve audience-personalized layouts by enabling `canvas_personalization`.
- Start from an existing component system (e.g. Mercury theme or the Nebula code-component scaffold) rather than authoring components from scratch.
- Audit where a component is used across the site via the per-component audit page (`/admin/appearance/component/{component}/audit`).
- Review enabled vs. disabled/incompatible components at `/admin/appearance/component/status`.
