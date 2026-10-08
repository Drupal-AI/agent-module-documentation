Paragraphs Library (a submodule of Paragraphs) lets you author a paragraph once as a reusable "library item" and reference that same item from many host entities, so shared content stays in sync everywhere it appears.

---

The module adds a `paragraphs_library_item` content entity — a revisionable wrapper around a single paragraph — managed on a "Paragraphs" overview at `admin/content/paragraphs` (a Views-based listing). Editors promote a paragraph into the library, then reference the library item from any paragraphs field using the bundled **From library** paragraph type, which renders the referenced paragraph inline. Because every host points at the same library item, editing the item updates all placements at once. The module depends on the Entity Usage module to track where each library item is referenced, and integrates with Entity Browser for a nicer picking experience (recommended, not required). Library items are fully revisionable with revision history, revert, and delete routes. Access is delegated: a library item has no notion of a parent, so its access check forwards to the referenced paragraph's enabled state — treat library items as broadly viewable. A settings form at `/admin/config/content/paragraphs_library_item` and per-paragraph-type third-party setting `allow_library_conversion` control which types may be turned into library items.

---

- Create a reusable content block (e.g. a promo banner) once and place it on many pages.
- Keep a shared call-to-action in sync across the whole site by editing one library item.
- Maintain a central library of approved marketing components for editors to drop in.
- Reference the same footer/disclaimer paragraph from dozens of nodes.
- Promote an existing paragraph on a page into the library for reuse elsewhere.
- Track everywhere a library item is used via Entity Usage integration.
- Revise a library item and roll back to an earlier revision if needed.
- Use the "From library" paragraph type to embed a library item in any paragraphs field.
- Manage all library items from a single admin overview (`admin/content/paragraphs`).
- Restrict which paragraph types may be converted to library items (`allow_library_conversion`).
- Pick library items through Entity Browser for a smoother selection UX.
- Grant editors rights to create or edit library items without full paragraph-type admin.
- Build a design-system component library shared by multiple content teams.
- Update a repeated legal notice in one place instead of on every page.
- Delete an obsolete revision of a library item.
- Reuse complex nested paragraph structures without rebuilding them each time.
- Reduce editor error by centralizing frequently repeated content.
- Give a decoupled front end a single canonical source for shared components.
