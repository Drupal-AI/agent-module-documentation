# Mouseflow Tracking — manual setup guide

**Mouseflow Tracking** (`mouseflow_tracking`) adds
**[Mouseflow](https://mouseflow.com/)** to your site by injecting Mouseflow's
JavaScript tracking code into your pages. Mouseflow provides session recording,
heatmaps, and behavioural analytics — it captures how visitors interact with
pages (mouse movement, clicks, scrolling, and potentially form input) so you can
see where people struggle or drop off. With this module, adding Mouseflow to a
Drupal site takes about a minute: paste your tracking code and enable it.

The module gives you control over **where** tracking runs: you can exclude admin
pages, restrict or exclude specific pages, and exclude specific IP addresses (so
your own team's sessions don't pollute the data). It has no other module
dependencies and plays no access-control role.

**Privacy is the key consideration here.** Session recording captures detailed
user interaction and can inadvertently record **sensitive input** — passwords or
personal data typed into forms — unless those fields are masked. Before you turn
it on: enable Mouseflow's **field masking/exclusions** for sensitive inputs,
**disclose the tracking in your privacy policy**, and gate it behind your
**cookie/consent** management (GDPR/CCPA), since this is third-party tracking.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — paste your Mouseflow tracking code,
   turn tracking on, and set page/IP exclusions.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → System → Mouseflow
Tracking** (`/admin/config/system/mouseflow-tracking`). See
[Configuration](configuration/index.md).
