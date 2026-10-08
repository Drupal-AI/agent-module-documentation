# Update Manager Advanced — manual setup guide

**Update Manager Advanced** (`advupdate`) makes Drupal's routine "Available
updates" notification email far more useful. Out of the box, that cron email just
tells you updates exist; this module appends the full per‑project detail you would
otherwise have to open `/admin/reports/updates/update` to see — each project's
installed version versus its recommended version, with links to the release
notes, and inline flags for security releases and unsupported versions.

The expanded email groups projects into **Enabled**, **Disabled**, and **Manual
updates required (core)** sections, so a site maintainer can tell at a glance from
their inbox which contrib modules are behind and which updates are security‑
critical. The feature is turned **on by default** the moment you enable the
module, and you can toggle it with a single checkbox on Drupal's own Update
settings form.

The module also adds a **Security Updates** admin block. When placed, it lists
only the projects with pending security updates (installed vs recommended version,
with a link to the updates report), is visible only to users who can administer
site configuration, and hides itself automatically when there are no security
updates to show. The module depends on core's **Update** and **Block** modules
and requires **Drupal 11.3+**. It adds no permissions and no Drush commands of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the email toggle on the Update
   settings form and the Security Updates block.

## Where it lives in the admin menu

The module has no page of its own. Its one setting is added to Drupal's existing
Update settings form at **Reports → Available updates → Settings**
(`/admin/reports/updates/settings`). The Security Updates block is placed from
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

Enable the module and the expanded update email is active straight away — no
further steps needed. Then, optionally, adjust the checkbox on the Update settings
form or place the Security Updates block on an admin dashboard. Both are covered
in [Configuration](configuration/index.md).
