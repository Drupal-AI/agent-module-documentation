# Landing Page Scheduler — manual setup guide

**Landing Page Scheduler** (`landing_page_scheduler`) gives content managers a
simple way to **redirect visitors to a chosen page for a limited window of time**.
You pick a target page and a start/end time, and during that window visitors are
sent to it — handy for a campaign splash, a seasonal promotion, or a temporary
"we're doing maintenance" landing page. When the window closes, normal browsing
resumes.

Everything is driven from one configuration page. You choose the **node** to
redirect to, the **time window** during which the redirect is active, and an option
to redirect each visitor **only once** rather than on every request. The redirect
target is an admin‑configured **internal page**, so this is a site‑building and
marketing tool, not an access‑control mechanism.

It requires no modules beyond Drupal core, and it ships its own permission so you
can decide which roles are allowed to configure the schedule.

One practical caution: scope the redirect carefully so it doesn't unintentionally
trap administrators or other logged‑in users who need to keep working on the site
while the window is open, and double‑check that the target really is the internal
page you intend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the target page, set the time
   window and the once‑only option, and assign the permission.

## Where it lives in the admin menu

The configuration page is at **Configuration → System → Landing Page Scheduler**
(`/admin/config/system/landing-page-scheduler`). Access to it is controlled by the
module's own permission, set on **People → Permissions**.
