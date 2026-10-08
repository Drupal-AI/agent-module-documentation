# Matomo Reports — manual setup guide

**Matomo Reports** (`matomo_reports`) brings your Matomo (formerly Piwik) web
analytics into the Drupal admin, so editors and site owners can see visitor,
traffic and goal reports without logging in to a separate Matomo back office. It
pulls the data from your Matomo server's HTTP API using a `token_auth` credential
and renders Matomo's own report widgets inside `/admin/reports`.

The reports section covers the familiar Matomo territory: a visitors overview with
times and locations, actions (top pages, entry/exit pages, site search, downloads,
outlinks), events, referrers (search engines, keywords, social, campaigns), goals
and transitions. You can filter by Today / Yesterday / last week, month or year, or
an explicit date range, and switch between multiple Matomo-tracked sites. There is
also an optional **"Matomo page statistics"** block that shows the view count for
the current page.

Access can be shared or personal. Set a single **global token** and everyone with
the right permission sees the same reports; leave it blank and each user supplies
their own Matomo token on their profile, so report visibility follows their Matomo
access. Two permissions keep viewing and configuring separate. Note that Matomo
Reports does **not** require the companion [Matomo](https://www.drupal.org/project/matomo)
tracking module — but the page-statistics block does need it, because it relies on
the tracked site ID.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect to your Matomo server, set the
   token(s), restrict sites, and grant permissions.

## Where it lives in the admin menu

- **Reports:** the report screens are at **Reports → Matomo Reports**
  (`/admin/reports/matomo-reports`).
- **Settings:** the connection settings form is at **Configuration → System →
  Matomo Reports** (`/admin/config/system/matomo-reports`).
- **Block:** add the **Matomo page statistics** block through **Structure → Block
  layout**.
