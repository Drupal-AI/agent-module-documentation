# Status dashboard — manual setup guide

**Status dashboard** (`status_dashboard`) is a monitoring tool for people who run
more than one Drupal site. It reviews the available updates for Drupal core and
contributed modules — including security updates — and displays them all in one
dashboard, so you can see the update posture of every site you manage at a glance
instead of logging into each one separately.

The way it works is client/server. This module is the **central dashboard**. On
each site you want to monitor you install the companion module
[`status_dashboard_client`](https://www.drupal.org/project/status_dashboard_client),
which the dashboard connects to (using a shared secret) to pull that site's update
information. After each cron run, the dashboard refreshes and shows what needs
updating across all connected sites. It can also email you notifications on a
schedule (daily, weekly, or monthly) for the update types you care about (core,
security, or feature updates).

The module depends on core's Views, is configured from its own settings form, and
provides its own permissions. It supports Drupal 8 through 11 (this is version
2.0.0-alpha9).

**A security caution worth taking seriously:** the information this dashboard shows
is sensitive. It reveals exactly which module versions are installed and which have
known-vulnerability updates pending — in other words, a precise list of a site's
outdated, exploitable components. Restrict the dashboard to trusted administrators
and never expose it publicly, or you would be handing an attacker a ready-made
target list. The upside is equally real: staying on top of security updates is one
of the most important things you can do for a site, and this makes that easy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command, enabling the
   module, and the client module you need on monitored sites.
2. [Configuration](configuration/index.md) — connecting client sites, email
   notifications, and locking down access.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Status Dashboard**
(`/admin/config/development/status-dashboard`, route
`status_dashboard.settings_form`). The dashboard itself is reached from the
**Status Dashboard** link in the administration menu.
