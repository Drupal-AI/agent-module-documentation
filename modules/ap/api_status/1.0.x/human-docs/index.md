<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Status — manual setup guide

**API Status** (`api_status`) is a tiny monitoring helper. It records the last
success and last failure of any API call in Drupal's State API and shows them on a
report dashboard, so you can see at a glance whether an integration is healthy — a
lightweight health signal without a full monitoring stack.

There is no automatic instrumentation: you (or a module you build) call the
module's service after each API request to log a `success` or `failure`, optionally
with the endpoint path. The service keeps the last success/failure time per named
API and maintains the list of tracked APIs. Because it uses the State API, it needs
no database table of its own.

The module makes no outbound requests, holds no secrets and exposes no writable
public endpoints — its only route is the report dashboard, which is gated by its
own permission. It supports Drupal 9, 10 and 11.

This guide is written for a **human** setting the module up. Wiring the `log()`
calls into your integration code is a developer step; for the exact service API,
read the sibling [`agent/`](../agent/start.md) docs — in particular
[`agent/api/service.md`](../agent/api/service.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The dashboard is under **Reports → API Status** (`/admin/reports/api-status`) and
requires the **`access api status dashboard`** permission. It lists the tracked
APIs with their last success/failure time and endpoint.

## How to use it

1. Enable the module and grant **`access api status dashboard`** to the roles that
   should see the report (for example a support role).
2. In your own integration code, call the tracker service after each API request:
   `\Drupal::service('api_status.tracker')->log('stripe', 'success', '/v1/charges')`
   on success, or `'failed'` on failure. (See
   [`agent/api/service.md`](../agent/api/service.md) for the full signature.)
3. Open the dashboard to see the last success/failure per API and spot a silently
   failing third-party integration.

The value comes from that instrumentation step — until your code calls `log()`,
the dashboard has nothing to show.
