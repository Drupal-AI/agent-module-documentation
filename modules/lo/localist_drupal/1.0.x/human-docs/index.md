# Localist Drupal — manual setup guide

**Localist Drupal** (`localist_drupal`) imports events from **Localist**, a hosted
event-management platform, into your Drupal site. It uses Drupal's Migrate system
— together with custom migration plugins and functions — to pull events, groups,
and taxonomy terms from the Localist API and store them as native Drupal content.
Dates are handled with **Smart Date**, which copes better with the start/end times
Localist produces, so a Localist-managed calendar ends up as ordinary Drupal
content you can theme, list in Views, and filter like anything else.

Out of the box it gives you a settings page to connect to your Localist instance,
sets up a group migration (which you can override) to sync events from a specific
Localist group, and ships an installable **recipe** that creates an example
migration so you can see how the pieces fit together. Migrations you register in
the module's configuration then run automatically on **cron** (hourly).

Because the module leans on Migrate, expect to do some migration work: the base
setup connects and syncs groups, but you write (or adapt from the example) the
event migration that maps Localist's event fields onto your content type. The
project's `README.md` covers building custom event migrations in detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Migrate and
   Smart Date dependencies, then enable it.
2. [Configuration](configuration/index.md) — connect to Localist, run the
   preflight check, create groups, and pick a group to sync.

## Where it lives in the admin menu

The Localist settings page sits at **Configuration → Web services → Localist
settings** (`/admin/config/services/localist`).
