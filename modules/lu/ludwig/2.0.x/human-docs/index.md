# Ludwig — manual setup guide

**Ludwig** (`ludwig`) is a manual alternative to Composer for installing the
third-party PHP libraries that a contributed module needs. On a site that
deliberately avoids Composer-managed workflows — or where the hosting environment
won't let you run Composer on the server — Ludwig gives you a way to download a
module's library dependencies through the Drupal admin UI instead.

It works like this: a module ships a small `ludwig.json` file listing each
required package with a version and a download URL (usually a GitHub `.zip`).
Ludwig scans every module and profile for these files, and the **Packages report**
at *Reports → Packages* lists every declared package with its status —
*Installed*, *Missing*, *Overridden*, and so on. Simply visiting that report page
downloads any missing packages: Ludwig fetches each archive, extracts it into the
requiring module's own `lib/` directory, and flushes caches. Libraries that use
PSR-4 or PSR-0 autoloading are then wired up automatically.

Ludwig is aimed at developers and site builders maintaining non-Composer sites.
It has **no settings form and no configuration to fill in** — the Packages report
*is* the interface, and it's where downloads happen. Note that this 2.0.x release
provides **no Drush command**; downloads are triggered by visiting the report
page. For most managed Drupal sites, Composer remains the recommended default —
reach for Ludwig specifically when Composer isn't an option.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent — including the `ludwig.json` format
and how autoloading is wired up — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no configuration page: Ludwig has no settings form or config object. Its
one screen is the Packages report — see **How to use it** below.

## Where it lives in the admin menu

Everything happens on the **Packages report** at **Reports → Packages**
(`/admin/reports/packages`), reachable by users with core's *View site reports*
(`access site reports`) permission. A companion inspect-only view lives at
`/admin/reports/packages_skip`.

## How to use it

1. Install and enable a module that declares its libraries with a `ludwig.json`
   file. On the report, that module's libraries show as **Missing**.
2. Go to **Reports → Packages** (`/admin/reports/packages`). Ludwig automatically
   downloads each missing archive, extracts it into the module's `lib/` folder,
   and flushes caches. PSR-4/PSR-0 libraries become autoloadable right away.
3. If any download failed, use the **"Download missing packages"** action button
   to re-run it. To review the list *without* triggering downloads, open
   `/admin/reports/packages_skip` instead.

> **The extension directory must be writable.** Downloads copy files into each
> module's own directory, so that location has to be writable by the web server —
> otherwise Ludwig reports that the extension directory is not writable.

The report's columns (Package, Namespace, Paths, Resource, Version, Required by,
and Status) let you diagnose why a library isn't loading — for example a
`classmap` or `files` library shows as *Not installed* until its module wires it
up in code, and a lower duplicate version shows as *Overridden* when a higher
version is required elsewhere.
