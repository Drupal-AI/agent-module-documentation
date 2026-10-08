# Group 2 to 3 upgrade — manual setup guide

**Group 2 to 3 upgrade** (`group2to3`) is a one‑shot migration tool that carries a
site's **Group** module data and configuration across the break between Group 2.x
and Group 3.x. Group 3 renamed the *group content* subsystem to *group
relationships* and changed its table and entity definitions; rather than forcing
you to rebuild your groups by hand, this module runs an ordered pipeline of steps
during a normal database update (`drush updb`) that copies the old data and
configuration into the new structures.

The pipeline copies Group Content configuration (types and fields) to Group
Relationship, creates the new tables and copies the rows, updates installed
entity definitions, fixes entity‑reference field configuration changed in Group 3,
rewrites Views that referenced `group_content` so they use `group_relationship`,
and finally removes the old Group 2 configuration. It is progress‑tracked, so a
long migration resumes safely across batch iterations.

This is deliberately a **throwaway** module. You install it while still on Group
2.x, switch Composer to Group 3.x, run the database updates, verify the result,
and then **uninstall and remove it**. It exposes no routes, no permissions, and
no settings — all of its work runs inside the update runner with the operator's
privileges.

> **Back up first.** This module changes your database and deletes the old Group
> configuration once data has been migrated. Take a full database backup and
> export your configuration (`drush cex`) before you begin, and test the upgrade
> on a copy of the site before running it in production. Note also that this is an
> obsolete/unsupported branch — the maintainers expect the 2.x‑to‑3.x path to be
> resolved in Group itself — so treat it as a last‑resort migration aid.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, run the upgrade,
   and remove it afterwards.

There is **no configuration page** for this module — it has no settings form. All
of the work happens automatically during `drush updb`.

## How to use it

The upgrade is run as a sequence, not through the admin menu:

1. On a site still running **Group 2.x**, back up the database and export config.
2. Install and enable this module (see [Installation](installation/index.md)).
3. Point Composer at Group 3.x: `composer require drupal/group:^3.0 -W`.
4. Run the database updates: `drush updb`. The migration pipeline executes here.
5. Verify your groups, group content (now group relationships), and any affected
   Views behave as expected.
6. Export the migrated configuration with `drush cex`.
7. **Uninstall and remove** this module once the upgrade is confirmed.
