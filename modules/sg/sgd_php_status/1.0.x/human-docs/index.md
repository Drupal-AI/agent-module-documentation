# Site Guardian PHP Status — manual setup guide

**Site Guardian PHP Status** (`sgd_php_status`) adds extra PHP information to
Drupal's built-in Status report. When you visit **Reports → Status report**, this
module contributes additional PHP configuration and health details so you (or a
monitoring tool) can see how PHP is set up alongside everything else Drupal
already reports.

It is a small piece of the wider *Site Guardian* monitoring framework: as well as
appearing on the Status report, it acts as a `hook_site_guardian_status()`
provider, meaning the same PHP details are handed to Site Guardian when that
companion system is present. On its own it simply enriches the report.

There is nothing to configure — the module works the moment you enable it. It has
no dependencies beyond Drupal core, no submodules, and no settings form. It does
not open any new public surface: the Status report it feeds is already restricted
to administrators by core's *View site reports* (`access site reports`)
permission, so the PHP information stays admin-only.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, there is nothing more to do. Go to **Reports → Status report**
(`/admin/reports/status`) and you will find the additional PHP information listed
among the report's entries.
