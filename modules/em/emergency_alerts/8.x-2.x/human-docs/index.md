# Emergency Alerts — manual setup guide

**Emergency Alerts** (`emergency_alerts`) shows a single, prominent site‑wide
notice — the kind of high‑priority announcement you often see at the top of
academic or public‑sector sites. You configure one active alert (a title, a
rich‑text message, and a severity level) and display it either as a placeable
block or, for the most urgent situations, as a full‑page banner that takes over
the page.

The severity level is rendered as CSS classes — `.emergency-alert.announcement`,
`.emergency-alert.warning`, and `.emergency-alert.danger` — so you can style the
three levels (informational, warning, critical) to match your theme. The alert can
be made dismissible: a small JavaScript library remembers when a visitor closes it
so it doesn't keep reappearing. The module ships Twig templates you're expected to
copy into your theme and style.

Emergency Alerts works only after you configure it — there's nothing to see until
you set a title and message and choose how to display it. It has no other module
dependencies. Because the alert message is admin‑authored rich text that is
rendered as markup, restrict who can edit it: grant the **Administer emergency
alerts** permission only to trusted editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the alert title, message and
   severity, and choose block or full‑page display.

## Where it lives in the admin menu

Once enabled, the settings form sits at `/admin/config/emergency_alerts` (route
`emergency_alerts.settings`), gated by the **Administer emergency alerts**
permission. The alert itself is also exposed as an **Emergency Alert** block you
place from **Structure → Block layout**.
