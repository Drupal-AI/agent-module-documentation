# Client Config Care — manual setup guide

**Client Config Care** (`client_config_care`) solves a specific and painful
deployment hazard: a client or editor changes some configuration on the live site
through the admin UI — a block, a menu, the site name — and then your next
`drush config:import` deployment silently reverts it back to whatever is in your
exported config. Client Config Care prevents that. It watches configuration changes
made through the browser, records each one as a tracked "config blocker" entity, and
then excludes those specific items from config import so the client's live changes
are preserved.

It was built by an agency (publicplan GmbH) precisely so that clients can be given
config-editing rights on a production site without turning every deployment into a
conflict. The clever part is the granularity: it doesn't block config wholesale.
Only the items actually changed on the live site get a blocker entity — edit a
block and a blocker for that block is created, leaving everything else free to
deploy normally. This is similar in spirit to `config_ignore`, but instead of a
static ignore list you maintain by hand, it's driven by tracked entities that also
carry an audit log of who changed what and when.

Mechanically, config event subscribers observe saves, deletes and imports; a diff
tool works out what actually changed; and a **Config Filter** plugin then makes the
blocked config "stick" during both import and export. That is why the module
**requires the Config Filter module** (`config_filter`). The blocker entities are
revisionable content entities you can review, add, and delete in the admin UI, and a
set of Drush commands lets you audit and manage them from the command line. It's
designed to be used together with a Drush-based config deployment workflow, on
Drupal 10 and 11.

Access to the blocker entities is permission-gated (add / edit / delete / view /
manage revisions, plus an *administer* permission flagged as restricted). Protection
can also be switched off globally via a `settings.local.php` flag — recommended on
local development environments where you *want* imports to apply cleanly. Note the
project is currently *seeking co-maintainers* and is in maintenance-fixes-only mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (plus Config
   Filter), enable it, and grant the permissions.
2. [Configuration](configuration/index.md) — reviewing config blockers, the
   permissions, the on/off switch, and the Drush commands.

## Where it lives in the admin menu

You review and manage the tracked config blockers at **Structure → Config blocker
entities** (`/admin/structure/config_blocker_entity`). See
[Configuration](configuration/index.md) for the full workflow.

## How to use it

The typical flow is:

1. Enable the module (it records nothing until it's on).
2. Let clients make their config changes on the live site as normal — each change
   is recorded as a blocker entity automatically.
3. Review the tracked blockers at **Structure → Config blocker entities**.
4. Run your usual `drush config:import` to deploy your development changes — the
   blocked items are left untouched, so the client's work survives the deployment.

If you ever want a specific item to be overwritten by the next import again, delete
its blocker (in the UI or via Drush). To force a full clean re-import, deactivate
protection entirely (see Configuration), import, then reactivate.
