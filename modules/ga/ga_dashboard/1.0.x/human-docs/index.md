# Google Analytics dashboard — manual setup guide

**Google Analytics dashboard** (`ga_dashboard`) adds a single admin page that
gathers several Google Analytics reports onto one screen inside Drupal — sessions
and pageviews, top pages, top cities, site speed, and top traffic sources — each
rendered as a chart. It saves stakeholders and editors a trip to the Google
Analytics web UI when all they want is a quick at‑a‑glance summary.

It is deliberately thin. The module is essentially a curated **layout** over
reports that other modules provide: it embeds several displays of the
`ga_reports_page` View and stacks them into one page at `/admin/ga-dashboard`. All
of the heavy lifting — pulling data from Google, authenticating, and drawing the
charts — is done by its dependencies: **Google Analytics Reports**
(`google_analytics_reports`) supplies the data and the Google authentication,
while **Charts** (`charts`) and **Charts Google** (`charts_google`) render the
graphs. This module itself has no settings, entities, or permissions of its own.

Two things follow from that design. First, the real setup work — connecting your
site to Google — happens in the **Google Analytics Reports** module, not here.
Second, the dashboard route is gated only by the broad **Access content**
permission, so the page itself is reachable widely; the embedded Views still apply
their own access, but if your analytics data is sensitive, consider restricting the
underlying Views or placing the page behind stronger access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and authenticate with Google.

This module has **no configuration form of its own**. The one setup step —
authenticating your site with Google — is done in the Google Analytics Reports
module, described in Installation.

## Where it lives in the admin menu

The dashboard is at **`/admin/ga-dashboard`**. Google authentication is
configured in the dependency at **Configuration → System → Google Analytics
Reports API** (`/admin/config/system/google-analytics-reports-api`).

## How to use it

1. Complete installation and authenticate with Google (see Installation).
2. Visit **`/admin/ga-dashboard`**. The page stacks the GA report charts —
   sessions/pageviews, top pages, top cities, site speed, and top sources.
3. If the analytics data is sensitive, restrict the underlying `ga_reports_page`
   Views or protect the route, since the dashboard page is otherwise broadly
   reachable.
