Entity Browser provides a generic, configurable UI for browsing, selecting, and creating entities (files, media, nodes, taxonomy terms, any entity type) and returning them to a reference field or other consumer.

---

Entity Browser is a framework for building reusable "browsers" — pickers that let editors search, browse, upload, or create entities and hand the selection back to a field or embed. Each browser is a config entity assembled from pluggable parts: one or more **widgets** (e.g. a View listing, a file upload, an inline entity form), a **widget selector** (tabs, dropdown, or single) to switch between them, a **selection display** to show and reorder chosen items, and a **display** plugin that decides how the browser opens (inline, modal, iframe, or standalone page). Browsers are wired into content via the provided `entity_reference_browser` and `file_browser` field widgets, or via the `entity_browser` render/form element in custom code. It ships six plugin managers so every part is extensible, plus widget-validation plugins that enforce cardinality, entity type, and file constraints. Configuration lives in `entity_browser.browser.*` config entities and is fully exportable. Two submodules extend it: an example module with ready-made browsers and an Inline Entity Form integration. It is a foundational building block behind many media and reference-heavy editorial workflows.

---

- Build a reusable image/file picker that opens in a modal from a reference field.
- Let editors select existing media from a Views-powered grid before uploading new files.
- Provide a multi-step browser: browse, add to selection, reorder, then submit.
- Replace the default autocomplete on an entity reference field with a visual browser.
- Attach a bulk file upload widget to a document reference field.
- Create nodes inline inside a browser via the Entity form widget and reference them immediately.
- Open a browser as a modal, an iframe, a standalone page, or inline depending on context.
- Offer tabbed access to multiple widgets (upload, view, search) in one browser.
- Enforce field cardinality so editors can't pick more items than the field allows.
- Restrict a browser to a specific entity type or bundle via widget validation.
- Restrict a file browser to certain extensions or max file size.
- Reuse the same browser across many fields and content types.
- Show chosen entities as rendered teasers, image thumbnails, or plain labels.
- Embed browsed entities into CKEditor content (with Entity Embed).
- Power a media library-style experience on older or customized sites.
- Let editors reorder a multi-value selection with drag-and-drop before saving.
- Filter selectable entities through a contextual Views argument (e.g. current node).
- Add a custom widget plugin for a bespoke selection source (e.g. an external DAM).
- Add a custom display plugin to change how the browser is presented.
- Export browser configuration and deploy it between environments as config.
- Gate access to a browser's pages with the auto-generated per-browser permission.
- Integrate entity selection into Inline Entity Form complex widgets.
- Provide a "select existing or create new" workflow in one interface.
- Alter widget/display plugin definitions site-wide via the provided alter hooks.
- Build a taxonomy term picker backed by a curated View.
- Attach selection validation that blocks invalid entity types at submit time.
- Provide a consistent picker UX across Paragraphs, entityqueue, and reference fields.
