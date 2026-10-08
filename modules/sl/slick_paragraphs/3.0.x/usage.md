Slick Paragraphs adds field formatters that render a multi-value Paragraphs field as a Slick carousel/slideshow, so each paragraph item becomes a slide. It bridges the Slick and Paragraphs modules with no configuration UI of its own.

---

Slick Paragraphs provides two Field UI formatters for `entity_reference_revisions` (Paragraphs) fields. **Slick Paragraphs Vanilla** (`slick_paragraphs_vanilla`, extends Slick's `SlickEntityFormatterBase`) renders each referenced paragraph "as is" via its configured view mode, so every slide can have a different composition of fields — combine it with Field Group, Display Suite, or Bootstrap Layouts for per-slide layouts; it works on both top-level and child Paragraphs fields and requires Blazy. **Slick Paragraphs Media** (`slick_paragraphs_media`, id-labelled "Slick Paragraphs Media", extends Slick's `SlickMediaFormatter`) offers richer, advanced slides (main image/background plus overlays such as media, image, or nested references) and is only applicable to a second-level (child) Paragraphs field. Both formatters expose Slick's standard formatter options — you pick a Slick **optionset** and map which paragraph fields provide the slide stage/overlay content. Applicability is gated by `isApplicable()`: the field must be multi-value with `target_type` = `paragraph` (the Media variant additionally requires the host entity type to be a paragraph, excluding the outer host to avoid nested-paragraph complications). The module ships only config schema (no settings form, permissions, services, or Drush); optionsets are created in the Slick module at `/admin/config/media/slick`. The typical structure is Node → Paragraphs field → Slideshow bundle → Slides (child Paragraphs field, formatted with Slick) → Slide bundle holding the non-paragraph fields (image, title, caption, link, layout). Known limitation: the formatters only work in Field UI Manage display, not in Views UI.

---

- Render a multi-value Paragraphs field as a Slick carousel by selecting a Slick Paragraphs formatter on the field's display.
- Turn a "Slideshow" paragraph bundle's child "Slides" field into a rotating slider.
- Build slides that mix text, image, and video using Paragraphs fields.
- Give each slide a different field composition with the Vanilla formatter and a paragraph view mode.
- Use Field Group or Display Suite inside a paragraph to lay out complex slides.
- Create advanced slides with a background image plus overlay media using the Media formatter.
- Overlay a video or image on top of a slide's main image within a paragraph slide.
- Choose which paragraph image/entity-reference field acts as the slide stage (main image).
- Choose which fields act as slide overlays (media, image, or nested entity references).
- Attach a specific Slick optionset (skin, arrows, dots, autoplay, responsive breakpoints) to the carousel.
- Nest a Slick carousel inside another slide to build nested/independent sliders.
- Render a multi-value text, image, or media field inside a slide paragraph as its own nested Slick.
- Make an individual paragraph bundle behave as a single slide.
- Add extra Paragraphs before or after the slideshow on the same host entity.
- Present a gallery of Paragraphs-based cards as a swipeable carousel.
- Add caption placement/layout per slide via a List (text) field with keys like top, bottom, left, right, center, below.
- Use split-layout skins to show image and caption side by side per slide.
- Reuse an existing paragraph bundle as slides without creating a new bundle.
- Format a top-level Paragraphs field directly as a carousel with the Vanilla formatter.
- Restrict the Media formatter to second-level (child) Paragraphs fields for advanced slideshows.
- Attach Slick carousels to any fieldable entity (node, user, ECK) that references Paragraphs.
- Keep slide content editable inline as normal Paragraphs while displaying it as a slider.
- Export the formatter/optionset choice as display config for deployment between environments.
- Combine with Blazy for lazy-loaded slide images in the Vanilla formatter.
- Avoid Views UI for these formatters (only Field UI Manage display is supported).
