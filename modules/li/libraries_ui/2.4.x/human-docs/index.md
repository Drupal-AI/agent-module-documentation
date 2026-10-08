# Libraries UI — manual setup guide

**Libraries UI** (`libraries_ui`) adds an admin report that lists every asset (CSS/JS)
library declared on your site — by installed modules, by themes, and by core — so you
can browse each library's version, files, dependencies and settings without opening a
single `*.libraries.yml` file by hand.

It is a read-only inspector: it has no configuration and stores nothing. It simply
walks Drupal's library discovery and renders what it finds. That makes it handy for
site builders and developers who need to answer questions like "what version of this
library is on the site?", "which module provides that library?", "what does this
library depend on?", or "was my new `*.libraries.yml` entry actually picked up?".

There is also a Drush command, `drush libraries:debug` (alias `ld`), that exposes the
same information on the command line with an interactive picker and a
version/dependencies table. For developers, the module's `libraries_ui` service offers
a one-call way to fetch all library metadata as a PHP array for use in your own code.

This guide is written for a **human** using the report through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The report is under **Reports → Libraries** (`/admin/reports/libraries`). Access is
gated by the **Access libraries_ui** permission, which is marked restricted — grant it
only to trusted administrators at **People → Permissions**.

## How to use it

Once the module is enabled:

1. Go to **Reports → Libraries** (`/admin/reports/libraries`).
2. Browse the list. Each extension (module, theme, or core) is shown with the
   libraries it defines, and each library lists its declared version, the CSS/JS files
   it attaches, its dependencies, and whether assets are marked as minified.

From the command line, `drush libraries:debug` (or `drush ld`) does the same — pick a
single extension in the interactive picker to see just its libraries, or dump the lot.

Developers who want the raw data in code can call the `libraries_ui` service's
`getAllLibraries()` method, which returns an array keyed by extension → library →
definition (core is always included). It's a convenient way to build a custom report or
integration on top of Drupal's library metadata.
