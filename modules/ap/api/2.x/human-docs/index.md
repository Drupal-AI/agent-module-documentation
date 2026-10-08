<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — manual setup guide

**API** (`api`) is the engine behind [api.drupal.org](https://api.drupal.org). It
parses PHP source code — following Drupal/Doxygen documentation conventions — into
a set of Drupal content entities, then renders them as browsable, cross-linked,
searchable API reference pages under `/api/…`. Function calls are automatically
linked to their definitions and to the PHP manual, with hover tooltips, and a
search subsystem (autocomplete, OpenSearch, per-branch and site-wide search) sits
on top.

You use it by defining a **Project** and one or more **Branches**. A branch points
at a directory of PHP code to document; the module's parser walks the files,
extracts the DocBlocks (files, functions, classes, members, namespaces,
references, overrides) into entities, and builds stable documentation URLs. There
are also *PHP branches* (references for cross-linking to the PHP manual) and
*external branches* (reference data pulled from an admin-set URL). Parsing runs on
Drupal's queue system, so it happens in the background as cron/queue workers run.

Everything is permission-gated. Reading the docs requires **`access API
reference`**, and all administration (settings, the setup wizard, importing
comments, parsing branches) requires **`administer API reference`**. Neither
permission is granted to anonymous users by default, so nothing is exposed until
you deliberately grant it — if you are building a public docs portal, grant
`access API reference` to the anonymous role on purpose. The branch source paths
and URLs are set by administrators, not by request input, so the parser's file
and HTTP reads are not driven by untrusted requests.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   several core modules plus Pathauto), and enable it.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → API**
(`/admin/config/development/api`), and requires the `administer API reference`
permission. The rendered documentation lives under `/api/{project}/…`.

## How to use it

The module has a genuine multi-step workflow rather than a single settings screen,
so the setup is folded in here:

1. **Enable the module.** It pulls in Views, Block, Comment, Link, Options and
   Pathauto as dependencies.
2. **Configure parsing** at `/admin/config/development/api` — parsing options,
   comment settings and file paths.
3. **Bootstrap quickly** with the wizard at
   `/admin/config/development/api/wizard`, which creates a Project and a Branch in
   one step.
4. **Add branches** — a *Branch* is a local directory of PHP to document; a *PHP
   branch* holds references for cross-linking to PHP functions/constants; an
   *external branch* pulls reference data from an admin-set URL.
5. **Parse** a branch from
   `/admin/config/development/api/branch/{branch}/parse` (or via Drush). Because
   parsing is queue-backed, make sure cron or a queue runner is processing jobs.
6. **Grant `access API reference`** to the roles that should read the docs —
   including the anonymous role if you are running a public portal.

For regenerating docs from CI or cron, the module ships a Drush command set; see
the sibling [`agent/drush/commands.md`](../agent/drush/commands.md) for how to
discover the exact commands on your installed version, and
[`agent/configure/setup.md`](../agent/configure/setup.md) for the setup detail.
