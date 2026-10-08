# Configuration

Emergency Alerts shows nothing until you configure an alert and choose how to
display it. Everything starts on one settings form.

## Open the settings form

1. Log in as a user with the **Administer emergency alerts** permission.
2. Go to `/admin/config/emergency_alerts` (route `emergency_alerts.settings`).

## Set the alert

- **Title** — the headline of the alert.
- **Message** — the alert body, entered as **rich text**. Because this is rendered
  as markup, only trusted editors should have the permission to edit it.
- **Alert level** — the severity, one of:
  - **Announcement** — an informational notice.
  - **Warning** — a warning‑level alert.
  - **Danger** — a critical alert.

  The level is applied as a CSS class (`.emergency-alert.announcement`,
  `.emergency-alert.warning`, or `.emergency-alert.danger`) so you can style each
  severity in your theme.

## Choose how it displays

Emergency Alerts can appear in two ways — you can use either or both:

- **As a block.** Place the **Emergency Alert** block in a region from **Structure
  → Block layout** (`/admin/structure/block`). If you want it in a specific spot,
  you can add a dedicated `emergency_alert` region to your theme. Standard block
  visibility rules apply, so you can scope where it shows.

- **As a full‑page banner (override).** Enable the **override** setting on the
  settings form. This promotes the alert into the page template on all non‑admin
  routes (the admin UI is deliberately excluded), letting the alert effectively
  take over the page for critical situations.

## Styling and templates

The module ships two Twig templates — `emergency-alert.html.twig` and
`html--emergency-alert.html.twig`. Copy these into your theme and customise them as
needed (keep the `page.emergency_alert` region if you use the full‑page override).
Then add CSS for the severity classes above to match your site's look.

## Dismissal

The alert can be dismissible: a bundled JavaScript library (`persist_close`) lets
a visitor close the alert and remembers that choice across page loads, so it does
not keep reappearing once dismissed.

## Save

Click **Save configuration**. The alert then appears via whichever display method
you enabled — reload a front‑end page to see it. Toggling the alert off later is
just a matter of returning to this form.
