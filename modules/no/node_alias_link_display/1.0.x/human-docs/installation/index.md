# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/node_alias_link_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_alias_link_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_alias_link_display -y
```

Enabling the module makes the filter available; you still need to switch it on
for each text format that should use it — see the "How to use it" section of the
[overview](../index.md).

## Verify it worked

Enable the filter on a text format (for example Full HTML), then view a piece of
content in that format containing an internal `/node/123` link. The rendered link
should point to the node's path alias (for example `/news/my-article`) instead of
`/node/123`. On a multilingual site, confirm the alias resolves to the correct
translated URL for the active language.
