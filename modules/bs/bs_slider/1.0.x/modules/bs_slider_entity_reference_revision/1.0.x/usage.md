Adds a BS Slider field formatter for entity_reference_revisions fields.

---

`bs_slider_entity_reference_revision` is an integration submodule of BS Slider. It provides one
field formatter, `bs_slider_entity_reference_revisions`, for `entity_reference_revisions` fields
(the field type used by Paragraphs and other revisioned references). Set it under Manage display,
pick a BS Slider optionset, and the referenced (revisioned) entities are rendered through that
optionset's slider plugin. Depends on `bs_slider` and the Entity Reference Revisions module.

---

- Render a multi-value Paragraphs field as a slider/carousel.
- Display any entity_reference_revisions field through a BS Slider optionset.
- Build a slider of nested revisioned content without writing code.
- Choose which slider library (Bootstrap/Swiper/Tiny Slider) renders the referenced items via the optionset.
- Keep the referenced entities' own view mode / access handling while sliding them.
- Reuse a single optionset across several ERR fields and displays.
- Combine with the ERR "link" setting inherited from the base formatter.
- Theme the output per plugin/optionset via BS Slider template suggestions.
