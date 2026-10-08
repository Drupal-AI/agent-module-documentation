Layout Paragraphs Library bridges Layout Paragraphs and the Paragraphs Library so components built in the drag-and-drop builder can be promoted to reusable library items and reused across content.

---

This submodule of Layout Paragraphs integrates the builder with Paragraphs' `paragraphs_library` module. It adds a **Promote to library** button to the Layout Paragraphs component edit/insert form for any paragraph type whose `allow_library_conversion` third-party setting is on (and which is not itself a layout section). Promoting creates a `LibraryItem` from the paragraph and replaces the in-layout component with a `from_library` reference paragraph, all through AJAX and the Layout Paragraphs tempstore. Conversely, a `from_library` paragraph gets an **Unlink from library** button that swaps the reference back for an editable local copy. The module also alters the paragraph type form to hide the `allow_library_conversion` option on paragraph types that are configured as Layout Paragraphs sections (sections cannot become library items). It is implemented purely with native form-alter/submit/AJAX hooks in `layout_paragraphs_library.module` — no config, permissions, or services of its own. Enable it after `paragraphs_library` and `layout_paragraphs`, then turn on "Allow adding to library" for the relevant paragraph types.

---

- Let editors save a component built in the Layout Paragraphs builder to the Paragraphs Library for reuse.
- Show a "Promote to library" button on eligible components in the builder.
- Reuse a library component across many nodes/entities via a `from_library` reference.
- Unlink a library-referenced component back into an editable local paragraph.
- Keep a single source of truth for repeated content blocks (footers, CTAs, promos).
- Automatically create a `LibraryItem` entity when promoting a component.
- Preserve component behavior settings when promoting/unlinking (settings are copied across).
- Prevent layout section paragraphs from being promoted to the library (they are excluded).
- Hide the "Allow adding to library" option on paragraph types used as Layout Paragraphs sections.
- Update one library item and have every place it is referenced reflect the change.
- Combine reusable library components with one-off inline components in the same layout.
- Support editorial workflows where approved blocks are curated in a shared library.
- Insert an existing library item as a component when adding to a layout.
- Maintain compatibility with inline_entity_form when promoting inside nested forms.
- Provide reuse without leaving the drag-and-drop building experience.
- Enable it alongside Paragraphs Library to add reuse to any Layout Paragraphs field.
