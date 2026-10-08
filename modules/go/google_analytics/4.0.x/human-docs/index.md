# Google Analytics — manual setup guide

**Google Analytics** (`google_analytics`) adds Google's GA4 `gtag.js` tracking
snippet to the pages of your Drupal site, so visits and events are recorded in a
Google Analytics 4 property. Everything is driven from a single admin form: you
paste in your **Measurement ID** and the module injects the tracker for you — no
theme edits or custom code required.

The real value is the fine-grained control over *what* gets tracked. You decide
which **pages** are counted (an allow-list or a deny-list of paths), which
**user roles** are exempt (so you can stop logging your own admin traffic),
whether logged-in users may **opt in or out** on their profile, and whether the
module should also track outbound **links**, `mailto:`/`tel:` clicks, and file
**downloads**. Custom dimensions and metrics round out the options.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to entering your
Measurement ID and tuning the tracking scope. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Google Analytics settings form, showing the Web Property ID(s) field and the Tracking scope vertical tabs](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Web Services → Google
Analytics** (`/admin/config/services/google-analytics`). It is a single settings
form with two parts:

- **Web Property ID(s)** — where you enter one or more GA4 Measurement IDs.
- **Tracking scope** — a set of vertical tabs (Domains, Pages, Roles, Users,
  Links and downloads, Messages, and more) that control exactly what is tracked.

## Contents

1. [Installation](installation/index.md) — install Google Analytics with Composer
   and enable it.
2. [Configuration](configuration/index.md) — enter your Measurement ID and choose
   which pages, roles, and users are tracked, plus link and download tracking.
