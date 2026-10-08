# Config Filter - Ignore Disabled Languages — manual setup guide

**Config Filter - Ignore Disabled Languages** (`idlc`) is a small helper that stops
Drupal's configuration export and import (`drush cex` / `drush cim`) from touching
the language-specific configuration of languages that aren't installed on the
current site. In other words, if a site doesn't have German enabled, this module
keeps `drush cim` from trying to delete all the `language.de.*` config, and keeps
`drush cex` from dropping language config that other sites still need.

It's built for the classic **shared-codebase / multisite** situation: several sites
in one codebase share a single `config/sync` directory, but each site enables a
different set of languages. Drupal stores language overrides in "config collections"
named `language.<langcode>`, and normally a config import on a site missing a
language would report those collections as pending deletions. This module filters
them out of the sync boundary so imports stay clean and no site clobbers another
site's language config.

There is nothing to configure. The whole module is one filter plugin that plugs into
the [Config Filter](https://www.drupal.org/project/config_filter) pipeline — enabling
the module (and its dependency) is the entire setup. It only affects data crossing
the export/import pipeline; it never changes your live, runtime configuration. When
you later install a new language, its config is automatically included again on the
next export.

This guide is written for a **human** operator. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs Config
   Filter) and enable the module.

## Where it lives in the admin menu

Nowhere — there is no settings form, no permission, and no Drush command. It works
silently once enabled.

## How to use it

Just enable it. With the module (and its `config_filter` dependency) on, your normal
`drush cex` / `drush cim` workflow automatically ignores the config of uninstalled
languages. It also plays nicely alongside other Config Filter plugins such as
[Config Ignore](https://www.drupal.org/project/config_ignore) and
[Config Split](https://www.drupal.org/project/config_split) in the same pipeline.
