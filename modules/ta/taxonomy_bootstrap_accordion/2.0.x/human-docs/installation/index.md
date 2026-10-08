# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Taxonomy** module (`taxonomy`) — the only dependency, enabled
  automatically as a dependency.
- **Bootstrap CSS and JavaScript from your theme.** The module emits Bootstrap
  accordion markup but ships no Bootstrap assets of its own, so your theme (for
  example a Bootstrap base theme) must load Bootstrap for the collapse behaviour to
  work. Match the Bootstrap version in the block settings to the version your theme
  provides.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_bootstrap_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_bootstrap_accordion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_bootstrap_accordion -y
```

There are no submodules and no settings page. All configuration happens when you
place the block — see [How to use it](../index.md#how-to-use-it) in the overview.

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm that
**Taxonomy Bootstrap Accordion** appears in the list (under the *Menus* category).
Place it, select a vocabulary and your Bootstrap version, and check that the
accordion renders and collapses on the front end.
