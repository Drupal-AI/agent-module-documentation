<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Response Check — manual setup guide

**API Response Check** (`api_response_check`) is a lightweight monitoring helper.
You give it a list of API URLs, it checks each one's HTTP response, and it records
the status so you can review — in an admin results table — whether your
external or internal API endpoints are responding. It is a simple, in-Drupal log
of endpoint availability rather than a full uptime service.

You manage the list of URLs on a settings form, and the recorded results appear on
a separate results page as a sortable, paged table showing each checked URL, its
HTTP status and a timestamp. Both pages are gated by the **Administer site
configuration** permission, so the log is never exposed to anonymous users and
there are no public-facing routes.

The module supports Drupal 8, 9 and 10. Use it for internal monitoring — for
example to keep a historical record of whether a third-party API you depend on has
been responding — and pair the checks with cron or manual runs to keep the log
fresh. If the results table grows large over time, prune old rows from its
database table.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enter the URLs to check and read the
   results table.

## Where it lives in the admin menu

- **Settings** (enter the URLs): `/admin/config/api-response-check/adminsettings`
- **Results** (view the recorded statuses):
  `/admin/config/api-response-check/view-results`

Both require the *Administer site configuration* permission.

## How to use it

Add the API URLs you want to watch on the settings form, then check the results
page to see each URL's recorded HTTP status and when it was last checked. Sort by
date or status using the table header links. See
[Configuration](configuration/index.md) for the details.
