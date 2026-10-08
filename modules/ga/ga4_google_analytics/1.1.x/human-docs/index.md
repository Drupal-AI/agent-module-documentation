# GA4 Google Analytics — manual setup guide

**GA4 Google Analytics** (`ga4_google_analytics`) adds Google Analytics 4 tracking to
your Drupal site. You paste in a single **Measurement ID** (the `G-XXXXXXXXXX` value
from your GA4 property) on one settings form, and the module injects the standard
`gtag.js` tracking snippet into the `<head>` of every page — no theme code required.
It is deliberately lightweight and has no module dependencies.

Beyond the basic "track everything" behavior, it gives you two visibility controls.
A **role** control lets you limit tracking to visitors who hold at least one selected
role (for example, track only anonymous visitors and leave staff untracked). A
**page** control, built on Drupal core's request-path condition, lets you list paths
(with `*` wildcards and `<front>`) and choose whether to track *only* those pages or
*everywhere except* them — handy for keeping analytics off admin and user pages.

There is also a **Scripts Custom Attributes** field for adding a small, strictly
validated set of attributes (`async`, `type="…"`, `data-*="…"`,
`crossorigin="anonymous"`) to the injected script tags. Its main purpose is
cookie-consent integration: a consent manager such as **Klaro** can use those
attributes to hold the tracking script back until the visitor consents, helping with
GDPR compliance.

All settings live in a single config object, and a single permission gates the
settings form. Note there is no default configuration shipped — the config object does
not exist until you save the form once, so nothing is tracked until you enter an ID.
The module defines no field types, plugins, services, or Drush commands.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the config keys and how the
snippet is injected — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field
   (Measurement ID, roles, pages, custom attributes), Klaro consent, and the
   permission.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → GA4 Google
Analytics** (`/admin/config/services/ga4-google-analytics`). See
[Configuration](configuration/index.md) to fill it in.
