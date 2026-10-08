# Editoria11y SI (Siteimprove) — manual setup guide

**Editoria11y SI (Siteimprove)** (`editoria11y_si`) connects your site to
[Siteimprove](https://www.siteimprove.com/) (a subscription quality-assurance
service) and surfaces the issues it finds directly in the
[Editoria11y](https://www.drupal.org/project/editoria11y) accessibility checker's
in-page interface. The result is that Siteimprove-detected problems appear to
content authors in the same familiar Editoria11y tooltips they already use for
in-page accessibility checks — no separate dashboard to visit.

This is the **1.2.x** release of the module. Its focus is showing Siteimprove's
**broken links** to content authors through the Editoria11y UI, along with an
admin report view. (If you are on Drupal with Editoria11y 3.x, look at the
module's 3.0.x release, which broadens this to misspellings and reading-level
scores as well.)

To work, the module needs three things: the **Editoria11y** module (for the
in-page display), the **Key** module (to hold your Siteimprove API credentials
securely rather than in plain config — a genuine security plus), and an active
**Siteimprove subscription with an API key**. It fetches QA data from Siteimprove
over the network (outbound API calls) and displays that editor-facing data; it
has no access-control role beyond the one permission it defines.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Editoria11y and Key dependencies.
2. [Configuration](configuration/index.md) — create the Siteimprove Key, select it
   on the settings form, schedule the import, and export config.

## Where it lives in the admin menu

The settings form sits under Editoria11y at **Configuration → Content authoring →
Editoria11y → SI** (`/admin/config/content/editoria11y/si`). The Siteimprove
credentials themselves are created as a Key at **Configuration → System → Keys**
(`/admin/config/system/keys`).
