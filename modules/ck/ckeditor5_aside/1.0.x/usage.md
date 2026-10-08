CKEditor 5 Aside adds an `<aside>` option to the CKEditor 5 heading dropdown so editors can wrap a block of text in a semantic `<aside>` tag.

---

CKEditor 5 Aside is a deliberately tiny module: it contributes one CKEditor 5 plugin definition that extends core's heading feature with an extra "Aside" option at the top of the block/heading dropdown. Choosing it converts the current single block (for example a paragraph or an `<h3>`) into `<aside>…</aside>`. During editing a small admin stylesheet floats and outlines the aside so it stands out inside the editor, but no styles are applied on the rendered front end — you style `<aside>` yourself in your theme. The module has no configuration form, routes, permissions, services, or PHP/JS logic; enabling it and turning the "Aside" button on in a text format's CKEditor toolbar/settings, plus allowing the `<aside>` tag in that format's filters, is all that is required. It only handles a single block with no nested tags.

---

- Give content editors a one-click way to mark a paragraph as a semantic HTML `<aside>` callout.
- Add sidebar-style notes, tips, or "did you know" boxes inside body copy.
- Produce pull quotes wrapped in `<aside>` for later theme styling.
- Convert an existing `<h3>` or `<p>` block into an `<aside>` from the heading dropdown.
- Emit semantic, accessibility-friendly `<aside>` markup instead of a generic styled `<div>`.
- Keep aside markup clean (`<aside>text</aside>`) with no extra classes or wrapper attributes.
- Let each text format decide whether the Aside option is available by toggling it in the format's CKEditor 5 settings.
- Restrict asides to formats where the `<aside>` tag is permitted by Limit allowed HTML tags.
- Provide an in-editor visual cue (float, border, shadow) so authors can see the aside while writing.
- Style the front-end appearance of asides entirely from your own theme CSS.
- Use alongside core's Heading plugin, which this module requires to be enabled in the format.
- Add editorial side notes to blog posts or documentation pages.
- Build "related information" boxes next to article body text.
- Mark author bios or disclaimers as `<aside>` for cleaner document structure.
- Improve SEO/semantics by using `<aside>` rather than presentational wrappers.
- Offer a lightweight alternative to heavier callout/box modules when only the tag is needed.
- Enable the option only for privileged formats (e.g. Full HTML) while leaving basic formats plain.
- Support Drupal 10 and Drupal 11 sites using CKEditor 5.
- Serve as a minimal example of adding a custom heading model to CKEditor 5 via a `*.ckeditor5.yml` plugin definition.
- Combine with theme utility classes by styling the bare `<aside>` tag in your stylesheet.
- Wrap short callouts where a single block (not multiple stacked tags) needs the aside treatment.
