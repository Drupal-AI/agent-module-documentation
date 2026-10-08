# Microsoft Clarity — manual setup guide

**Microsoft Clarity** (`microsoft_clarity`) integrates the free
[Microsoft Clarity](https://clarity.microsoft.com/) behavioral-analytics service
into your Drupal site. Clarity shows how visitors actually use your pages through
**heatmaps** and **session recordings** — where people click, how far they scroll,
and how they move through a page. The module's job is to inject Clarity's tracking
script so that this data flows to Microsoft; you configure it with your Clarity
**project ID**.

It has no module dependencies and works across Drupal 8.9 through 11. Once you
provide the project ID (and set any options), the script is placed on the site and
Clarity begins collecting behavioral data.

Because session recording observes visitor behavior — and, unless configured to
mask, can capture what users type and see — this module carries clear privacy
responsibilities. It loads a third-party script that sends behavioral data to
Microsoft, so plan to disclose it in your privacy policy, gate it behind
cookie/tracking consent where your jurisdiction requires (so the script does not run
before a visitor agrees), and configure Clarity's **masking** so sensitive fields
are not recorded. The module places the script; making the setup compliant is
operator configuration, not something enabling the module does on its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your project ID and handle
   consent, disclosure, and masking.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Web services → Microsoft
Clarity** (`/admin/config/services/microsoft_clarity`), where you set the project ID
and other options.
