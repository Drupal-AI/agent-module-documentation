# Webform Migrate — manual setup guide

**Webform Migrate** (`webform_migrate`) moves legacy **Drupal 6 and Drupal 7
webforms — and their submissions — into the modern Webform module** on Drupal 9,
10, or 11. If you are upgrading an old site that used the classic Webform module,
this is what carries your forms and the responses people filled in over the
years across to the new site, instead of rebuilding every form by hand.

It works entirely through Drupal's Migrate API. The module ships four *source
plugins* — `d6_webform`, `d7_webform`, `d6_webform_submission`,
`d7_webform_submission` — and four matching migration definitions. The form
migrations read your legacy database's webform tables and build Webform config
entities, converting the old components into Webform's `elements` YAML and mapping
legacy settings (confirmation message, redirect, drafts, submission limits,
preview, progress bar) onto the new webform. The submission migrations read the old
submitted-data tables and recreate the responses as `webform_submission` entities,
still attached to their original host node.

Because it plugs into Migrate, the module has **no admin UI, no settings form, no
permissions, and nothing to configure in the browser**. You run it either as part
of a full Drupal-to-Drupal upgrade, or manually with the standard Migrate tooling
against a configured legacy source database. Its one extension point is a pair of
hooks that let a developer customize the generated Webform YAML for a specific
element type — useful when a custom or contrib component isn't mapped out of the
box.

This guide is written for a **human** running the migration. If you want terse,
token-cheap references for an AI coding agent — including the field mappings and
alter-hook signatures — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Webform module) and enable it.

## Where it lives in the admin menu

Nowhere of its own — Webform Migrate adds no admin pages. Its migrations surface
through Drupal's migration tooling: the **Migrate Drupal** upgrade UI, or Drush
commands from the Migrate Tools module.

## How to use it

There are two ways to run the migration.

**As part of a full upgrade.** Run the Drupal-to-Drupal migration — for example via
the core *Migrate Drupal UI*, or `drush migrate:upgrade` — pointed at your legacy
site's database and files. Webform Migrate registers itself as the module that
"finishes" the legacy Webform module, so its migrations join the generated upgrade
set automatically. Forms are imported before their submissions (the submission
migration depends on the form migration).

**Manually with Migrate Tools / Migrate Plus.** Configure a connection to your
legacy database (usually a `migrate` source connection in `settings.php`), then run
the individual migrations with `drush migrate:import` — for example the `d7_webform`
migration first, then `d7_webform_submission`. You can also reference the source
plugins (such as `d7_webform`) in your own `migrate_plus.migration` config entities
to build a custom migration.

If a legacy component doesn't convert cleanly, a developer can implement
`hook_webform_migrate_d7_webform_element_ELEMENT_TYPE_alter()` (or the D6
equivalent) to rewrite the generated YAML for that element type.
