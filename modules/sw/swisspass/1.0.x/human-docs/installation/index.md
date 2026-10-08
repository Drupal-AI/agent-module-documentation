# Installation

## Requirements

- **Drupal 10.3 or above** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module (`webform`) — the SwissPass element plugs into Webform,
  so it must be installed and enabled. Composer installs it as a dependency when
  you use the `-W` flag below.

There are no third‑party PHP or JavaScript library requirements, and there are no
submodules. Note that the released branch is a beta (`1.0.0-beta5`) and the project
is **not covered by Drupal's security advisory policy**, so test it before relying
on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/swisspass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Webform
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swisspass -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swisspass -y
```

## Verify it worked

Edit any Webform (**Structure → Webforms**), click **Add element**, and confirm
that **SwissPass Number** appears in the element type list. If it does, the module
is installed correctly. See [Configuration](../configuration/index.md) to add and
set up the element.
