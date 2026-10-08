# Admin status report — manual setup guide

**Admin status report** (`admin_status_report`) shows site **status reports and
reminders** to administrators who hold the right permission. The idea is to surface
important operational conditions and to‑do reminders where administrators will see
them, so that significant site state or outstanding tasks aren't missed.

Visibility is controlled by a dedicated **administer admin status report**
permission — only users with that permission see the reports and reminders. It is an
operations/admin convenience tool: it has no content role and does not change access
to anything else on the site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Access is gated by the **administer admin status report** permission, which you grant
on the **People → Permissions** page (`/admin/people/permissions`). Grant it to the
administrator or operations roles that should see the reports and reminders.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Grant **administer admin status report** to the roles that should see the reports
   and reminders.
3. Users with that permission then see the site's status reports and reminders,
   helping the team stay aware of important conditions and pending tasks.

The published documentation for this module is thin, so beyond the permission‑gated
reports/reminders described above, check the module's own project page and README on
[drupal.org](https://www.drupal.org/project/admin_status_report) for the exact
screens it provides on your version.
