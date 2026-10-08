# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Path** module (`path`) enabled — the only dependency. Drupal enables it
  automatically as a dependency when you turn on Extended Path Aliases.

There are no third‑party Composer or PHP library requirements to *install* the
module. One optional, advanced feature (carrying aliases through to block
visibility on `*` tab paths) can use the PECL `runkit` library — see "How to use
it" in the [overview](../index.md); it is not required for normal operation.

**Recommended:** [Pathauto](https://www.drupal.org/project/pathauto), to generate
the base aliases that this module then extends to tabs and links.

## Install with Composer

From the project root:

```bash
composer require drupal/path_alias_xt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_alias_xt -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_alias_xt -y
```

The core behaviour is active immediately — no configuration required.

## Verify it worked

Pick a page that has a URL alias (say `about-us` for `node/123`). Log in as a user
who can edit it, then hover or click its **Edit** tab. The URL should read
`about-us/edit` rather than `node/123/edit`. If the tabs still show raw system
paths, confirm a **base alias actually exists** for the page — extended aliases
are derived from it.
