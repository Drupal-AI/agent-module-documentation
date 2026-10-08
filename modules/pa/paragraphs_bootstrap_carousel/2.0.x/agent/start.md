<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Bootstrap Carousel (paragraphs_bootstrap_carousel) — agent index

A **field formatter** (`paragraphs_bootstrap_carousel_formatter`) that renders a paragraphs
reference field (`entity_reference_revisions`) as a **Bootstrap 5 carousel**: each referenced
paragraph becomes one slide (image + optional caption + optional click link). Ships an example
`bootstrap_carousel` paragraph type with `field_image` / `field_caption` / `field_link`, a theme
hook + Twig template that emits the Bootstrap carousel markup, and an optional Bootstrap CDN library.

- Dependencies: `paragraphs:paragraphs`, `drupal:link` (info.yml); also uses core `image`/`text` via the shipped fields.
- No settings page (no route). Configuration is per **entity-display** (Manage display) on the formatter.
- No permissions, no drush commands, no plugin types defined. Provides config **schema** for the formatter settings.

What you'd do:
- **Turn a paragraphs field into a carousel / set interval, caption, link, image style, indicators, controls** → [fields/formatter.md](fields/formatter.md)
- **Understand the shipped `bootstrap_carousel` paragraph type and its slide fields; add a paragraphs field and point the formatter at it** → [configure/paragraph-type.md](configure/paragraph-type.md)
- **Theme hook, template variables/markup, and the Bootstrap CDN library** → [theme/carousel.md](theme/carousel.md)

Key facts:
- Formatter id: `paragraphs_bootstrap_carousel_formatter`; field type it applies to: `entity_reference_revisions`.
- Class: `Drupal\paragraphs_bootstrap_carousel\Plugin\Field\FieldFormatter\ParagraphsBootstrapCarouselFormatter`.
- Config schema key: `field.formatter.settings.paragraphs_bootstrap_carousel_formatter`.
- Theme hook: `paragraphs_bootstrap_carousel`; template: `templates/paragraphs-boostrap-carousel.html.twig`.
- Library: `paragraphs_bootstrap_carousel/bootstrap` (Bootstrap 5.2.3, jsdelivr CDN) — attached only when the `cdn` setting is on.
- Shipped paragraph type id: `bootstrap_carousel`; fields `field_image` (image, required by formatter), `field_caption` (text_long), `field_link` (link).
- Core: `^9.3 || ^10 || ^11`. Package: `Fields`.
