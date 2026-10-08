# Site Studio Configuration Management — manual setup guide

**Site Studio Configuration Management** (`sitestudio_config_management`) is a
"glue" module that wires **Acquia Site Studio** (formerly Cohesion) into Drupal's
standard configuration-management workflow. Site Studio stores most of its design —
styles, components, templates — as `cohesion_*` config that needs its own package
export/import and a rebuild step. Keeping that in sync with the usual
`drush config:export` / `config:import` is normally a manual, error-prone chore.
This module makes it automatic.

It does its work in two ways. On install it ships the **recommended
configuration** — it adds `cohesion_*` to Config Ignore's ignore list, provides a
ready-made Config Split named `site_studio` that isolates `cohesion_*` config into
its own folder, and enables all the `cohesion_*` entity types for Site Studio sync.
At runtime it hooks the core Drush config commands: after `config:export` it runs
`sitestudio:package:export`, and after `config:import` it runs `cohesion:import`
plus `sitestudio:package:import`, adding a `cohesion:rebuild` when it detects that
the Cohesion module was upgraded since the last run. An event subscriber covers the
extra case of installing a site from existing config.

This is deployment-pipeline infrastructure for Acquia CMS / Site Studio sites.
There is **no user interface, no settings form, and no permissions** — you install
it and it changes what the config Drush commands do. All Site Studio steps are
skipped automatically until Site Studio itself is configured with a valid API key
and organization key.

This guide is written for a **human** working on a site's config workflow. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including its
   Config Ignore, Config Split, and Cohesion requirements) and enable the module.

## Where it lives in the admin menu

Nowhere — the module has no admin pages. Its effect is felt entirely through the
`drush config:export` and `drush config:import` commands, and through the
Config Ignore / Config Split configuration it ships on install.

## How to use it

There is nothing to configure in this module itself. The one thing you must ensure
is that **Site Studio is configured** — the module only runs its Site Studio steps
when Cohesion's settings (`cohesion.settings`) hold both an `api_key` and an
`organization_key`. Until then it logs a warning and skips, so installing it early
on an un-keyed site is harmless.

Once Site Studio is keyed:

- Run `drush config:export` as usual — the module also exports Site Studio
  packages.
- Run `drush config:import` as usual — the module also imports the Site Studio
  packages and, when Cohesion was upgraded, rebuilds them.

It tracks the Cohesion version in Drupal's state so it knows when a rebuild is
needed, and logs each Site Studio command it runs to its own logger channel. In a
CI/CD pipeline this means a single `config:import` promotes both your Drupal config
and your Site Studio design in one step, avoiding partial deploys where one lands
without the other.
