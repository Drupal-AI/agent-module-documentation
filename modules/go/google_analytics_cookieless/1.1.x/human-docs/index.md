# Google Analytics Cookieless — manual setup guide

**Google Analytics Cookieless** (`google_analytics_cookieless`) adds Google
Analytics page-view tracking to your site **without setting the Google Analytics
cookie**. The appeal is simple: if you only want basic visitor statistics and don't
want to show a cookie banner just for analytics, this collects page views without
storing the `_ga` cookie. It also offers IP anonymisation and page-visibility rules
so you control exactly which pages are tracked and whether logged-in users are
counted.

It works by loading the Google Analytics snippet with cookie storage turned off and
generating a client identifier from a browser fingerprint (via the FingerprintJS
library) instead of a stored cookie.

**Important — this module targets legacy Universal Analytics.** It uses
Universal Analytics property IDs in the `UA-XXXXXXX-Y` format. Google has sunset
Universal Analytics, and the module is marked deprecated/obsolete. On a current
site you should use the **Google Analytics** module with GA4 (which itself uses
first-party cookies). Treat this module as useful mainly for archival or
self-hosted GA-style endpoints, and check whether it fits before deploying it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   FingerprintJS library, and enable it.
2. [Configuration](configuration/index.md) — enter the UA property ID and set IP
   anonymisation and page-visibility rules.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Google Analytics Cookieless**
(`/admin/config/system/google-analytics-cookieless`). See
[Configuration](configuration/index.md) — and note the permission caveat described
there, because the form's access depends on the classic Google Analytics module's
permission.
