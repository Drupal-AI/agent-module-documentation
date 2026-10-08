# Config Patch — manual setup guide

**Config Patch** (`config_patch`) turns the difference between a site's **active**
configuration (what's live in the database) and its **sync/export**
configuration (what's on disk / in your repo) into a **patch** — a unified diff
you can commit back to source control. The classic use case: someone makes a
config change through the UI on production, and you want to capture that change as
a patch and bring it back into your codebase instead of losing it or letting a
deployment silently overwrite it.

It adds a **Patch** tab next to the usual config *Synchronize* page, listing every
config object that differs between active and sync storage, with a button whose
action depends on the selected **output plugin**. Output is pluggable: the bundled
**Text** plugin simply prints the patch (in the browser or on the CLI), and
optional contrib submodules can push the patch as a pull/merge request to GitLab,
GitHub, Gitea, or Azure. A toolbar widget shows a live count of how many config
items have drifted, and two Drush commands let you generate patches and list
changed files from the command line. It respects **Config Ignore** rules when
computing the diff.

Under the hood it uses the `sebastian/diff` library (pulled in automatically by
Composer) to build the diffs. There are no module dependencies beyond that, and it
runs on Drupal 10 and 11. Access is gated by core's configuration permissions plus
the module's own *Administer config_patch* permission — all restricted, since
config export/import is sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the output‑plugin
interface for building your own submission target — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   `sebastian/diff`) and enable the module.
2. [Configuration](configuration/index.md) — the settings form (config base path
   and default output plugin), the permissions involved, and the Drush commands.

## Where it lives in the admin menu

- The **Patch** tab sits with the config sync tasks at **Configuration →
  Development → Configuration synchronization → Patch**
  (`/admin/config/development/configuration/patch`).
- The module's settings form is at **Configuration → Development → Config Patch**
  (`/admin/config/development/config_patch`).
- A toolbar widget shows the count of differing config items and links to the
  Patch tab.

## How to use it

Make a config change in the UI, open the **Patch** tab (or run `drush
config:patch text`), and you'll get a unified diff of active‑vs‑sync config that
you can pipe into `patch -p1` in your repo or, with a submodule, push straight to
your Git host. See [Configuration](configuration/index.md) for the settings, the
permissions each part needs, and the exact Drush commands.
