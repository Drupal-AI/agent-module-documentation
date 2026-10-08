Adds a Paragraphs behavior that turns a Paragraph's multi-value field into a BS Slider.

---

`bs_slider_paragraphs` is an integration submodule of BS Slider. It provides the `bs_slider`
Paragraphs behavior plugin. On a Paragraph type you enable the behavior, map one of its
multi-value fields to slider items, and choose which BS Slider optionsets are available; content
editors then pick a slider per paragraph instance. At render time the behavior loads the chosen
optionset's plugin and applies its `view()` to the mapped field's items. Depends on `bs_slider` and
the Paragraphs module.

---

- Let editors turn a "Gallery" paragraph into a carousel by choosing a slider.
- Map a paragraph's multi-value image/media field to slider items.
- Offer several slider styles (optionsets) per paragraph type and let editors pick one.
- Build reusable slider paragraph types (carousel, gallery, thumbs) without custom code.
- Choose the referenced item view mode per enabled slider (via plugin options).
- Restrict a paragraph type's slider choices to a curated set of optionsets.
- Provide a "- None -" option so a paragraph can render without a slider.
- Combine Bootstrap/Swiper/Tiny Slider optionsets on the same paragraph type.
- Keep editor UX inline via the Paragraphs behavior form.
- Show a settings summary of the selected slider on the paragraph edit form.
