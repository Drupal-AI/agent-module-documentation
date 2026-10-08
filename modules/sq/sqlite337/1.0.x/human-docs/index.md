# SQLite 3.37 — manual setup guide

**SQLite 3.37** (`sqlite337`) provides a SQLite database driver that works with
**SQLite 3.37 or newer**. This matters because the SQLite driver bundled with
Drupal 11 core requires SQLite 3.45+, which is not yet available everywhere. This
module relaxes that requirement to 3.37+, which is far more broadly available — so
you can install and run Drupal 11 on hosts and systems that would otherwise be
blocked, making it easier to move from Drupal 10 to Drupal 11.

It is an infrastructure module: it changes how Drupal connects to and talks to
SQLite, and has no content, settings screen or access role of its own. It builds
on core's **SQLite** driver and runs on Drupal 10.2 and 11. This release is an
alpha.

One recommendation from the module's own guidance: if you *do* have access to
SQLite 3.45+, upgrade to that and use core's driver instead of this module. Reach
for SQLite 3.37 only when the newer SQLite version isn't available to you.

This guide is written for a **human** installing the module. Setup is a little
different from a normal module because it involves your `settings.php` — see the
Installation guide. If you want terse, token‑cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the driver, wire it into your
   database settings, and enable the module.

## How to use it

There is nothing to configure through the UI. Once the driver's `settings.inc` is
referenced from your `settings.php` (or written there by the installer) and the
module is enabled, Drupal uses the SQLite 3.37‑compatible driver for its database
connection automatically.
