# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
  (For Drupal 10.4+ / 11 you may prefer the module's 4.x branch; this guide
  covers the 3.4.x branch.)
- Core modules **Node**, **Field**, and **Serialization** — Drupal enables these
  automatically as dependencies.
- An **OpenAgenda account** with an API key and at least one agenda (identified by
  its UID).

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/openagenda -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openagenda -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openagenda -y
```

Drupal will enable the required core modules (Node, Field, Serialization) along
with it.

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) to enter your
OpenAgenda API key and connect an agenda. Once connected, use the default
**OpenAgenda** content type (or add an OpenAgenda field to your own type) and
confirm that the agenda's events render on the page.
