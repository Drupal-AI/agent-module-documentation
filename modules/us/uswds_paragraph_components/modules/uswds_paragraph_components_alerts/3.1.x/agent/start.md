# USWDS Alerts — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Installs one USWDS alert
paragraph type. No settings page, no permissions.
`src/Hook/UswdsParagraphComponentsAlertsHooks.php` registers `paragraph__uswds_alert` →
`templates/paragraph--uswds-alert.html.twig` and a `hook_preprocess_paragraph` that attaches the CSS
library.

## Paragraph type & fields (config/optional)

**`uswds_alert`** (expose this):
- `field_alert_title` — heading text (`usa-alert__heading`).
- `field_alert_body` — formatted text body (rendered via `{{ content.field_alert_body }}`).
- `field_alert_status` — list; value maps to modifier: `info`→`usa-alert--info`, `warning`→
  `usa-alert--warning`, `error`→`usa-alert--error`, `success`→`usa-alert--success`.
- `field_no_icon` (bool) → `usa-alert--no-icon`.
- `field_slim` (bool) → `usa-alert--slim`.

## Rendering & assets

`paragraph--uswds-alert.html.twig` assembles the `usa-alert` class list from the status + booleans and
emits `<div class="usa-alert…"><div class="usa-alert__body"><h3 class="usa-alert__heading">…`.
CSS shim `uswds_paragraph_components_alerts/uswds-alerts`
(`css/uswds-paragraph-components-alerts.css`) is attached in `hook_preprocess_paragraph()` for
`uswds_*` bundles when `view_mode !== 'preview'`. Full USWDS styling still comes from your theme.
