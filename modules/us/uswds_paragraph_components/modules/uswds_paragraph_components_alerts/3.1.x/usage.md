Submodule of USWDS Paragraph Components that installs a USWDS **alert** paragraph type — an info/warning/error/success notice rendered as `usa-alert` markup.

---

Enabling this submodule imports the `uswds_alert` paragraph bundle plus its fields and displays. Fields: `field_alert_title` (heading), `field_alert_body` (formatted text), `field_alert_status` (a list — `info`/`warning`/`error`/`success` mapping to `usa-alert--info` etc.), `field_no_icon` (bool → `usa-alert--no-icon`) and `field_slim` (bool → `usa-alert--slim`). The template `paragraph--uswds-alert.html.twig` builds the `usa-alert` class list from the status and boolean fields and renders `usa-alert__heading` + `usa-alert__body`. A component CSS shim (`uswds_paragraph_components_alerts/uswds-alerts`) is attached via `hook_preprocess_paragraph()` for any `uswds_*` bundle when the view mode is not `preview`. Expose `uswds_alert` on your Paragraphs field.

---

- Show a site-wide or in-page informational notice using the USWDS info alert.
- Warn users about important conditions with a warning alert.
- Surface an error/failure state with an error alert.
- Confirm a successful action or positive status with a success alert.
- Render a compact notice with the slim variant.
- Hide the status icon with the no-icon option for a cleaner look.
- Give an alert a bold heading plus formatted body text.
- Embed an alert inside body content via a Paragraphs field.
- Provide accessible, consistent USWDS alerts across a federal site.
- Combine multiple alerts of different statuses on one page.
- Override `paragraph--uswds-alert.html.twig` to adjust heading level or markup.
- Reuse the alert component inside columns or other container paragraphs.
- Communicate maintenance windows or policy changes as a styled notice.
- Load the alert CSS shim only on the front end (preview view mode is excluded).
- Standardize notification styling without building the paragraph type by hand.
