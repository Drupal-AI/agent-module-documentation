<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends the Views Reference Field (viewsreference) module with improved field formatters, a select widget, and settings plugins for embedding views through a reference field.

---

Views Reference Field lets an entity reference a View (and display) to embed it in content; this suite improves that experience. It ships `ViewsReferenceFieldFormatterImproved` and a lazy-builder variant `ViewsReferenceLazyFieldFormatterImproved` for rendering the referenced view, an Autocomplete Deluxe-based `ViewsReferenceSelectWidgetImproved` for picking views, and ViewsReferenceSetting plugins — filters, exposed filters, and an argument tokenizer — that let editors override a view's filters/arguments per reference. Per-reference settings are stored serialized in the field's `data` column.

Because the stored `data` is serialized, the formatters and widget decode it with `unserialize($value, ['allowed_classes' => FALSE])` — object instantiation is disabled, so a tampered field value cannot trigger PHP object injection. The suite depends on both `viewsreference` and `autocomplete_deluxe`, and defines an `administer vrfs configuration` permission (flagged `restrict access`). It has no routes of its own — everything operates through Field UI (widget/formatter selection) and rendered entity display.

Setup: install alongside `viewsreference` and `autocomplete_deluxe`, add a Views Reference field to an entity, choose the improved widget on the form display and an improved formatter on the view display, then configure which exposed filters/arguments editors may override.

---

- Embed a referenced view in entity display with an improved formatter
- Lazy-render a referenced view via the lazy field formatter
- Pick a view/display using an Autocomplete Deluxe select widget
- Let editors override a view's exposed filters per reference
- Override view arguments through the argument tokenizer plugin
- Configure which ViewsReference settings are available per field
- Store per-reference filter/argument settings with the field value
- Safely decode serialized field data with object instantiation disabled
- Replace the default viewsreference widget with the improved one
- Improve the editor UX for choosing views to embed
- Tokenize arguments passed to an embedded view
- Restrict suite configuration behind a dedicated permission
- Render different views per entity via a reference field
- Pass contextual filters into embedded views
- Build landing pages that embed configurable views
- Expose selected filters to content editors, not all of them
- Combine with Field UI to control form and display separately
- Reuse a single view across content with per-item settings
