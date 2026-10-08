<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Quote adds a "Quote" paragraph type for styled pull-quotes and testimonials, with a title, quote text, author, image, and five predefined layout styles, part of the Extra Paragraph Types (EPT) family built on ept_core.

---

Quotes and testimonials are recurring editorial elements: a client testimonial with a headshot, a persona quote, a pull-quote highlighting a key sentence. EPT Quote provides these as a single Paragraphs bundle (`ept_quote`) that ships preconfigured fields — Title, Text, Quote Author, and a media Image — plus the shared EPT settings field for per-paragraph design options (margins, padding, borders, background color/image, container width, edge-to-edge). A "Quote styles" radio in the paragraph edit form selects one of five bundled CSS layouts (`persona`, `company`, `persona_with_small_icon`, `with_square_image`, `with_frame_and_background_image`), each attaching its own component stylesheet. The chosen style becomes an `ept-quote-<style>` CSS class on the paragraph wrapper and the matching library is loaded on render. It requires ept_core and paragraphs, and — because the image field uses core Media — expects an "Image" media type to exist (enforced by `hook_requirements` at install). There is no admin settings form of its own; global colors and breakpoints come from ept_core. Add the paragraph to any entity that has a Paragraphs reference field (article body, landing page, Layout Builder via a paragraphs field, etc.).

---

- Add a styled quote to a page as a Paragraphs item.
- Build a client testimonial with a headshot and author name.
- Show a persona quote (photo + quotation) in the `persona` style.
- Present a company quote in the `company` style.
- Use the `persona_with_small_icon` layout to place a small author icon beside the name.
- Use the `with_square_image` layout for a square portrait next to the quote.
- Use the `with_frame_and_background_image` layout for a framed, image-backed quote.
- Highlight a pull-quote inside a long-form article.
- Add an attributed citation with author credit.
- Compose several quotes into a testimonials section on a landing page.
- Insert a quote paragraph inside a Layout Builder region via a paragraphs field.
- Reuse the bundled `ept_quote_image` image style for consistent author thumbnails.
- Adjust per-quote spacing (margins/padding) using the EPT design options.
- Give a single quote a custom background color or background image.
- Make one quote edge-to-edge (full viewport width) without touching the theme.
- Constrain a quote to a preset container width (small/default/large, etc.).
- Round the corners or add a border to an individual quote box.
- Combine EPT Quote with other EPT paragraph types (Text, Image, CTA) on the same page.
- Translate quote content per language (fields are non-translatable by default; enable as needed).
- Lazy-load the author image (view display sets `image_loading: lazy`).
- Provide editors a tabbed edit form (Content tab + Settings tab via field_group).
- Fall back to the `persona` layout automatically when no style is selected.
- Standardize testimonial markup across a site without writing custom Twig.
- Swap layout styles on an existing quote without re-entering content.
- Enable only this paragraph type when other EPT modules are not needed.
