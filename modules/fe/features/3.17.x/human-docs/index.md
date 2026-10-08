# Features — manual setup guide

**Features** (`features`) lets you package a subset of your site's configuration —
a content type plus its fields, form/view displays, a view, permissions, and so on
— into an installable **"feature" module**. That bundle can then be exported to
code, committed to version control, moved between sites, and reverted back to a
known state when the live configuration drifts.

The important distinction is how Features differs from Drupal core's configuration
management (CMI). Core's config sync is designed to manage a site's configuration
**as a whole**, and it includes site-specific UUIDs. Features uses the same
underlying system but manages only **part** of the configuration and omits the
UUIDs, so a Feature can be reused across multiple, unrelated sites. On modern
Drupal, core CMI plus **Config Split** is usually the better choice for syncing an
entire site between environments; Features shines when you want to bundle
**reusable, distributable** functionality (for a distribution or install profile)
that you can update over time — something Recipes, by design, do not do.

Under the hood, Features groups config into **packages** using a pipeline of
**assignment method** plugins, then writes them out with **generation method**
plugins (to the filesystem, or as a downloadable archive). The behavior is
controlled by a `features_bundle` configuration entity. It depends on core's
**Config** module and the contributed **Config Update** module (used for diffing
and reverting). Most day-to-day work is done through **Drush commands**; the
optional **Features UI** submodule provides the admin screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Config Update dependency, and add the UI submodule if you want it.

There is **no configuration page** in the base module — the admin screens are
provided by the optional **Features UI** submodule, and the primary workflow is the
Drush command cycle, both described in "How to use it" below.

## Where it lives in the admin menu

With the **Features UI** submodule enabled, the screens are at **Configuration →
Development → Features** (`/admin/config/development/features`). Without it, Features
is driven entirely from the command line.

## How to use it

The typical export/deploy/revert cycle uses Drush:

- **Export** configuration into feature modules:
  `drush features:export` (config lands in each feature module's `config/install`).
- **See what has drifted** between a feature's stored config and the active site
  config: `drush features:diff`.
- **Re-apply (revert)** a feature's stored config back onto the site after it
  drifts: `drush features:import` (or `drush features:import:all` to revert every
  overridden feature at once).
- **Check status** — active bundle, enabled assignment methods, package states:
  `drush features:status`, `drush features:list:packages`, `drush features:components`.
- **Add** specific config items to an existing package: `drush features:add`.

With the Features UI you can review and edit which configuration a feature contains
before exporting, and see override/state information on screen. Advanced users can
create additional `features_bundle` entities to namespace one product's or client's
features separately from another's, and tune which config types count as
"core"/"site"/"base" so machine-specific config is not exported.
