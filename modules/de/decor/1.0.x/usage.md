Decor marks images inside opt-in container elements as decorative by giving them an empty `alt` attribute, `role="presentation"`, and removing their `title` — so assistive technologies skip them.

---

Decor is a tiny, configuration-free accessibility module. It attaches a single JavaScript library globally (via `hook_page_attachments`) that runs a `Drupal.behaviors` behavior. The behavior finds container elements marked with `.js-decor`, `.js-decorative-image`, or `[data-decor="img"]`, then for every `<img>` inside them adds the class `is-decor`, sets `alt=""` and `role="presentation"`, and strips any `title` attribute. This satisfies WCAG Technique H67 (null alt text and no title on images assistive tech should ignore) toward Success Criterion 1.1.1 Non-text Content (Level A). There is no admin UI, no configuration, no permissions, no PHP entities, and no server-side rendering of user data — you simply add a marker class to the container in your Twig templates and the module does the rest on the client.

---

- Mark a hero banner background image as decorative by wrapping it in a `.js-decor` container.
- Treat repeated card/teaser thumbnails as decorative so screen readers announce only the heading and text.
- Silence purely ornamental icons or dividers that sit inside a marked container.
- Retrofit accessibility on a theme where authors cannot set empty alt text through core's media UI.
- Apply the legacy `.js-decorative-image` class on markup migrated from an older implementation.
- Use the `[data-decor="img"]` attribute form when a CSS class is inconvenient or already reserved.
- Ensure duplicated logo images in headers/footers are ignored by assistive technology.
- Remove redundant `title` tooltips from decorative images site-wide without editing each image.
- Add `role="presentation"` to ornamental images so they are removed from the accessibility tree.
- Fix WCAG H67 audit failures for images that carry unnecessary alt/title text.
- Mark slideshow/carousel decorative frames so only meaningful slides are announced.
- Flag background pattern or texture `<img>` elements inside a section as decorative.
- Improve screen-reader flow on landing pages heavy with stock/ornamental imagery.
- Let front-end developers opt individual template regions into decorative treatment.
- Style decorative images differently via the added `.is-decor` class if desired.
- Keep image markup untouched in the database while adjusting accessibility at render time.
- Support Drupal 10, 11, and 12 sites needing a lightweight decorative-image helper.
- Combine with theme components (Twig `{% embed %}`/`{% include %}`) that emit reusable card markup.
- Avoid per-image alt-text editing effort for large galleries of ornamental images.
- Provide a consistent, code-driven way to mark decorative images across a design system.
