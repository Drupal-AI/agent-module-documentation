# slick_paragraphs — agent start

Renders a multi-value Paragraphs (`entity_reference_revisions`) field as a Slick carousel:
each paragraph item becomes a slide. Two Field UI formatters — `slick_paragraphs_vanilla`
(each paragraph as-is, top-level or child, needs Blazy) and `slick_paragraphs_media`
(rich slides with image/overlay, child paragraphs only). Depends on `slick` (>= 3.x) and
`paragraphs`. No settings form, permissions, services, or Drush; optionsets live in the
Slick module (`/admin/config/media/slick`).

- Set up a Paragraphs field to display as a Slick carousel (formatters, optionset, slide field mapping) → [configure/slick_paragraphs.md](configure/slick_paragraphs.md)
- Theming: view modes, templates, per-slide layout → [theming/slick_paragraphs.md](theming/slick_paragraphs.md)
