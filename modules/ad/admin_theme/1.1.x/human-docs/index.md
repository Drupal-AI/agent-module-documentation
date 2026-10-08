# Admin Theme — manual setup guide

**Admin Theme** (`admin_theme`) lets you force Drupal's administration theme onto
any set of front-end paths — and exclude paths — going well beyond what core
offers. Out of the box Drupal can only apply the admin theme to node-edit pages
(the "Use the administration theme when editing or creating content" checkbox).
This module replaces that limitation with an arbitrary **Include / Exclude** path
list, so you can give editors the backend look on a custom dashboard, a reports
section, a whole admin area that lives outside `/admin`, or any views-based
management page you built for staff.

You configure it with two fields — **Include** and **Exclude** — that the module
adds to the standard Appearance page. Each takes a list of path patterns (one per
line), using the same familiar syntax as block visibility: a leading slash, `*`
wildcards, and the `<front>` token. Any path that matches Include and does not
match Exclude is rendered with the admin theme. The settings are saved as
exportable configuration, so you can deploy your include/exclude rules across
environments.

Internally, Admin Theme works by decorating Drupal's admin-route determination
rather than adding a theme negotiator, which means it composes cleanly with the
rest of core's theme system. It has no dedicated settings page of its own (its
configure link points at the core Themes page), no permissions, and no Drush
commands. It works on Drupal 9.5, 10.2+, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the Include and Exclude path lists
   and how they interact.

## Where it lives in the admin menu

There is no separate settings page. The **Include** and **Exclude** fields are
added to the core Appearance page at **Appearance** (`/admin/appearance`), and the
module's configure link points there.

## How to use it

Enable the module, go to the Appearance page, and fill in the **Include** list
with the paths where you want the admin theme (and optionally the **Exclude** list
for exceptions). Save, and clear caches if the change doesn't appear immediately.
See [Configuration](configuration/index.md).
