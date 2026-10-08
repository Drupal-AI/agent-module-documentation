# Project Browser — manual setup guide

**Project Browser** (`project_browser`) puts a point‑and‑click catalog of contrib
modules — and recipes — right inside your site's admin, so you can find, compare,
and install them without visiting Drupal.org or knowing Composer. It adds a
**Browse** page under **Extend** with search, filtering, and sorting, showing only
projects compatible with your site's Drupal version.

Results come from pluggable **sources**. The default source lists Drupal.org
contrib modules over its JSON:API; other built‑in sources cover Drupal core
modules, local recipes, already‑installed modules, and a curated "recommended"
list you point at a URL. You choose which sources are enabled, what order they
appear in, and which one opens first.

Installing from the UI is an experimental feature: turn it on, and if Drupal
core's **Package Manager** module is present, Project Browser downloads and
enables the chosen module (or applies a recipe) through a sandboxed Composer
process — no shell access needed. Without Package Manager, the UI simply shows you
the exact `composer require` command to run yourself. Access is governed by
Drupal's core permissions rather than any of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose sources, the default source,
   and the experimental in‑UI installation, option by option.

## Where it lives in the admin menu

The browsing UI is at **Extend → Browse** (`/admin/modules/browse`). The settings
form is at **Configuration → Development → Project Browser**
(`/admin/config/development/project_browser`).

## How to use it

1. Enable the module.
2. Go to **Extend → Browse** to search and filter available projects.
3. On a project you want, either follow the shown `composer require` command, or —
   if you have enabled in‑UI installation and Package Manager — install it
   directly from the page.

See [Configuration](configuration/index.md) to tune the sources and installation
behavior.
