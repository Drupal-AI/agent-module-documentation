# Siteimprove Analytics — manual setup guide

**Siteimprove Analytics** (`siteimprove_analytics`) adds the Siteimprove
Analytics JavaScript tracker to your site so your pages can be measured in the
Siteimprove platform — without editing any templates. It injects the tracker
script on every page, and lets you control **who** is tracked and **which pages**
are excluded.

You give it the numeric **application code** from your Siteimprove dashboard, and
the module loads
`https://siteimproveanalytics.com/js/siteanalyze_<code>.js` asynchronously on
matching pages. Two filters decide where the script runs: an **audience** setting
(anonymous visitors only, logged-in users only, or everyone) and an
**excluded-routes** list of path patterns (admin pages, node add/edit, user edit,
and so on are excluded by default). Paths are matched by their alias, so you can
exclude friendly URLs too.

The module has a small settings form, provides the **"administer
siteimprove_analytics"** permission, and stores everything in a single config
object — which means you can also set the code and filters from `settings.php` per
environment (for example, to keep staging untracked). The tracker only loads once
a code is entered. It has no dependencies beyond Drupal core and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your application code, choose
   the audience, tune the excluded routes, and (optionally) set it all per
   environment from `settings.php`.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Siteimprove Analytics**
(`/admin/config/system/siteimprove-analytics`).

## How to use it

Enable the module, then open the settings form and paste in your Siteimprove
application code. Choose which visitors to track and adjust the excluded routes if
needed, then save — tracking starts immediately on the pages that pass the filters.
Full details are in [Configuration](configuration/index.md).
