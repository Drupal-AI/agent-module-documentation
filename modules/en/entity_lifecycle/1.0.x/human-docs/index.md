# Entity Lifecycle — manual setup guide

**Entity Lifecycle** (`entity_lifecycle`) automatically tracks **content freshness**
for nodes, media and user accounts, so a site can flag pages that have gone stale —
past events, outdated policies — and surface inactive user accounts, without editors
having to track any of it by hand. It's aimed at content‑heavy sites (news portals,
event calendars, policy hubs) where accuracy and credibility slip as content ages.

The idea is a continuous review cycle. When content is created or edited it's marked
**Current** with a timestamp. A **cron‑based scanner** then evaluates content against
conditions you configure — age, usage, login activity, and so on — and assigns a
status such as **Needs Review** or **Outdated** to anything that matches. Editors see
a **banner** when viewing content that needs attention; editing it resets the status
back to Current, restarting the cycle. The result is a self‑maintaining feedback loop
that keeps stale content visible to your team instead of quietly misleading visitors.

Notable capabilities include configurable statuses (with colors and a "needs review"
flag), an extensible **condition plugin system** with condition groups, **per‑bundle**
configuration so you scan only the content types you choose, a review validity period
per content type, adjustable scan intervals (every cron run, 6h, 12h, daily, 2 days,
weekly), **Views integration** for editorial dashboards, and **Drush commands** for
running scans manually. It depends on core **Node** and **Views**, and supports Drupal
10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable per‑bundle scanning, define
   statuses and conditions, set scan intervals and validity periods, and run manual
   scans.

## Where it lives in the admin menu

Content settings are at **Configuration → Content authoring → Entity Lifecycle**,
where you enable per‑bundle scanning, define statuses, set conditions, choose scan
intervals and tune validity periods. For user‑account lifecycle, enable the User
part of the module and configure it at **Configuration → People → Account settings**.
