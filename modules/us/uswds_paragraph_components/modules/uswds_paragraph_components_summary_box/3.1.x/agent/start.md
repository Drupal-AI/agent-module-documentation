# USWDS Summary Box — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Installs one flat USWDS
summary box paragraph type — the simplest component in the suite. No settings page, no permissions, no
CSS library (uses the theme's USWDS assets). Hooks in
`src/Hook/UswdsParagraphComponentsSummaryBoxHooks.php`.

## Paragraph type & fields (config/optional)

**`uswds_summary_box`** (expose this):
- `field_header` — box heading.
- `field_text` — formatted body text.

## Rendering

Theme hook `paragraph__uswds_summary_box` → `templates/paragraph--uswds-summary-box.html.twig`. Emits
`<div class="usa-summary-box" role="complementary"><div class="usa-summary-box__body"><h3
class="usa-summary-box__heading">{{ content.field_header }}</h3><div class="usa-summary-box__text">{{
content.field_text }}</div>` — both fields rendered through their formatters (safe). No nested
paragraphs.
