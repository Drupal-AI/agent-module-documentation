# USWDS Accordions — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Installs a USWDS accordion
paragraph type. No settings page, no permissions, no CSS library (uses the theme's USWDS assets).
`hook_theme` (in `src/Hook/UswdsParagraphComponentsAccordionsHooks.php`) registers
`paragraph__uswds_accordion` → `templates/paragraph--uswds-accordion.html.twig`.

## Paragraph types & fields (config/optional)

- **`uswds_accordion`** (container, expose this one):
  - `field_accordion_section` — nested Paragraphs (entity_reference_revisions) of `uswds_accordion_section`.
  - `field_bordered` (bool) → adds `usa-accordion--bordered`.
  - `field_multiselect` (bool) → adds `usa-accordion--multiselectable` + `data-allow-multiple`.
  - `field_default_open` (list) → section index(es) rendered with `aria-expanded="true"`.
- **`uswds_accordion_section`** (child, do NOT expose): `field_accordion_section_title`,
  `field_accordion_section_body`.
- **`text_field`** — helper bundle with `field_text` (shared simple text paragraph).

## Rendering

`paragraph--uswds-accordion.html.twig`: sets `usa-accordion` classes from the boolean fields, then
loops `field_accordion_section` emitting `<h2 class="usa-accordion__heading"><button
class="usa-accordion__button" aria-expanded aria-controls>` per section. Section body is re-rendered
with the correct translation (checks `hasTranslation(langcode)`) and cache keys stripped. Button IDs
include `random(0,1000)` so they are not stable across renders.

To override markup, copy the template into your theme.
