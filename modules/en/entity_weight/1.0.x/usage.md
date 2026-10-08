Entity Weight adds a configurable weight field to any fieldable entity type so you can order nodes, taxonomy terms, media, paragraphs and other entities by hand instead of only by date or title.

---

Enable weight per entity type and bundle from a single settings form at `/admin/config/entity-weight`. When you enable a bundle, the module automatically creates the locked `field_entity_weight` integer field on it, adds a form-display widget (hidden by default), and generates an admin menu link. Editors reorder entities with a drag-and-drop table at `/admin/structure/entity-weight`, or type weight values directly; the weight is also available as a Views sort criterion (`field_entity_weight`). The bundled Entity Weight Views submodule goes further: it stores an independent order for a specific view display in its own database table, adds a "Reorder view" contextual link, injects that order into the view query at highest priority, and supports a shared-or-per-language order for multilingual sites. Disabling a bundle removes its field, and uninstalling the module removes all fields and field storage.

---

- Order taxonomy terms (e.g. Tags) in a custom sequence for menus or facet lists.
- Give media library items a manual display order in galleries.
- Reorder paragraphs or custom entities that lack a native ordering UI.
- Control the order of promoted articles on a landing page via a weighted Views sort.
- Enable weight only on the specific content types that need manual ordering.
- Set a bounded weight range (for example -50 to 50) to keep values manageable.
- Use a select-dropdown weight widget for small ranges and a number input for large ranges.
- Keep the weight field hidden on edit forms so editors manage order only from the ordering screen.
- Expose the weight field on edit forms so editors set order while creating content.
- Reorder large bundles page-by-page (50 entities per page) without loading everything at once.
- Exclude unpublished entities from the ordering interface to focus on live content.
- Include unpublished entities so drafts can be positioned before publishing.
- Order translated content per language, since weight values are translatable.
- Add `field_entity_weight` as an ascending Views sort so lighter items appear first.
- Give a single view display its own order that differs from the global entity weight (via Entity Weight Views).
- Add a visible "Reorder items" button to a view header, footer or empty area.
- Let editors reorder only the entities a specific view shows, respecting its filters.
- Reorder the full result set of a paged view and see which rows land within the display limit.
- Maintain one shared order across all languages for a view, or customize per language.
- Drop a language's custom view order and fall back to the shared order.
- Reorder a block-display view's items independently from its page display.
- Batch-save order changes on very large bundles without exhausting memory.
- Clean up completely on uninstall, since all created fields and storage are removed automatically.
