# Show Database Details — manual setup guide

**Show Database Details** (machine name `show_database_name`) answers a question every
team with more than one environment eventually asks in a nervous moment: *which
database am I actually looking at right now?* It reads the default database
connection info and surfaces the **host** and **database name** in three convenient
places — an item in the admin toolbar, a "Database Host & Name" block you can place
anywhere, and a line in the runtime status report.

The value is being able to tell production, staging, and development apart at a
glance, so you do not run a destructive command against the wrong environment or spend
time guessing connection details during an incident. It is, in effect, a lightweight
environment indicator focused specifically on the database.

A quick naming note to avoid confusion: the Composer package and the on-disk folder
are both `show_database_name_d8`, but the **machine name** you enable with Drush is
`show_database_name`. It is a Drupal 8 port of the older Drupal 7 "Show Database Name"
module.

Because a database host and name are exactly the kind of infrastructure detail you do
*not* want exposed to the public, every one of the three surfaces is gated by a
dedicated, restricted permission — **access database information** (declared
`restrict access: TRUE`). Only roles you explicitly trust ever see it; it never
appears on anonymous or low-privilege pages. The module works the moment you enable it
and grant that permission — there is nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the viewing permission.

## How to use it

Once enabled, grant **access database information** (under **People → Permissions**)
to the roles that should see the database details. Those users will then see:

- a **database item in the admin toolbar** (which links through to the status report
  for admins);
- an optional **"Database Host & Name" block** you can place in any region via
  **Structure → Block layout**;
- a line in the **status report** at **Reports → Status report**
  (`/admin/reports/status`).

Users without the permission see none of it.
