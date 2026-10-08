# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Configuration Manager** module (`config`).
- The **Configuration Provider** module — the 2.x or 3.x branch — which Configuration
  Share builds on to register its shared-config handling.

There are no third‑party PHP library requirements. This is the 8.x‑1.0‑rc5 release
and the project is minimally maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/config_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Configuration
Provider dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_share -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_share -y
```

## Verify it worked

There is no admin screen to check. To confirm the mechanism, create (or use) a
module that lists `config_share` as a dependency and places an item in its
`config/shared` directory. Installing that provider module should *not* install the
shared item; installing another config item that depends on it should pull the
shared item in on demand.
