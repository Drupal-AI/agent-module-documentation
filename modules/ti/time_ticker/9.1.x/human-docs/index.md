# Time Ticker — manual setup guide

**Time Ticker** (`time_ticker`) provides a block that displays the current date and
time for a timezone you choose, and keeps it ticking live. The block renders a
formatted timestamp (in the style `jS M Y - h:i:s A`, for example
"1st Jan 2026 - 09:15:03 AM"), and a small JavaScript library polls a lightweight
AJAX endpoint so the displayed time advances without a page reload.

It is handy for an intranet, a dashboard, or a site header or footer where you want
a visible clock — presented for a chosen region regardless of the server's own
timezone. The module stores a single timezone in its settings, computes the time
through a small service, and exposes it both in the block and over a read-only JSON
endpoint at `/time_ticker/ajax`.

Setup is a three-step affair: enable the module, pick the timezone on the settings
form, then place the **Time Ticker** block into a region via Block layout. The
module depends only on core's **Block** module. The AJAX endpoint is read-only and
returns only the formatted current time — no user or system data — so its exposure
is negligible. Two honest caveats worth knowing: the settings form is gated by the
**Administer blocks** permission rather than a regional-configuration permission,
and this release does not carry drupal.org security-advisory coverage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the display timezone and place the
   block.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → Time Ticker**
(`/admin/config/regional/time-ticker`, route `time_ticker.admin_settings`). Access
to it is controlled by the **Administer blocks** permission.
