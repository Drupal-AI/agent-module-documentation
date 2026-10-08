# eTracker Analytics — manual setup guide

**eTracker Analytics** (`etracker`) adds the **eTracker** web‑analytics tracking
system to your Drupal site. eTracker is a German, privacy‑focused analytics
provider; this module injects its JavaScript tracking code (eTracker API v5.0) into
your pages, with a no‑script fallback, so visitor behaviour is measured in your
eTracker account.

It is more than a snippet‑paster. You can control where the tracking code is placed
(header or footer), track click events (mailto links, external links, downloads by
extension), track site search and system messages, restrict tracking to specific
pages or roles, and enrich the data with areas derived from taxonomy or breadcrumbs,
targets, segments (roles / language) and multilingual tags. Default and tracking
parameters can be altered with hooks or rules, and the tracking output is themeable.
An eTracker account (which is a paid service) is required.

Because analytics tracking sets cookies and loads a third‑party script, it has
privacy and consent implications. The module ships a **`cookies_etracker`**
submodule that integrates with the **COOKiES** consent module so the tracker only
loads once the visitor consents — you should use it (and disclose the tracking per
GDPR / German privacy law). It also honours the browser's Do‑Not‑Track signal by
default and can let registered users opt in or out. The module has no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the consent submodule.
2. [Configuration](configuration/index.md) — enter your eTracker account ID and
   choose what to track.

## Where it lives in the admin menu

The settings form is at **Configuration → System → eTracker**
(`/admin/config/system/etracker`).

## How to use it

Enter your eTracker account ID on the settings form and the tracking JavaScript is
added to your pages in the configured scope. You can confirm it by viewing a page's
source in your browser and looking for the eTracker code. If you enable the consent
submodule, the script is gated behind the visitor's cookie consent.
