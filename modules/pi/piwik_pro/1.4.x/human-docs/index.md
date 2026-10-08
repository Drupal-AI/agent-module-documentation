# Piwik PRO — manual setup guide

**Piwik PRO** (`piwik_pro`) connects your Drupal site to the Piwik PRO
analytics platform. It injects the Piwik PRO tag‑manager container — the small
tracking `<script>` snippet — into your pages, so visitor data is collected by
your Piwik PRO account. (This is *Piwik PRO*, the privacy‑focused commercial
platform — not the original open‑source Piwik, which is now called Matomo.)

You point the module at your Piwik PRO account by entering two public
identifiers from your Piwik PRO administration panel: an **Account ID** (the
container ID) and a **tracking domain** (the address the container script loads
from). Once those are set, the snippet is added to page output automatically —
you do not need to touch any theme templates.

A single settings form controls exactly *where* the snippet loads. You can
include or exclude tracking by request path (admin, node‑add, and user pages are
excluded by default), by user role (for example, stop tracking editors), and by
content type (for example, track only articles). Each of these three rules can
be inverted, so you can just as easily say "track *only* these pages" as "track
every page *except* these." There are also cookie options (secure cookies,
SameSite=Strict), a master switch to turn all tracking off, and — for sites
running a Content‑Security‑Policy — the option to serve the snippet with a CSP
nonce.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional dashboard submodule.
2. [Configuration](configuration/index.md) — the settings form field by field:
   your account identifiers, the visibility rules, cookies, and CSP.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → System →
Piwik PRO** (`/admin/config/services/piwik-pro`). You need the **Administer
Piwik PRO** permission — a restricted, administrator‑level permission — to open
it.

## How to use it

The workflow is: install and enable the module, sign in to your Piwik PRO
account to find your **Account ID** and **container/tracking domain**, then paste
those two values into the settings form and save. Tracking begins immediately on
every front‑end page that passes the visibility rules. From there you can
tighten the scope — exclude admin roles, limit tracking to certain content
types, or temporarily switch tracking off during maintenance — all from the same
form, with no code changes. All settings are stored in exportable Drupal
configuration.
