# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`). The module's
  own docs recommend recent core — Drupal 10.4.8+ or 11.1.8+ — for the best
  experience.
- **Node** (core) and **Linkit** (`drupal/linkit`) — both must be enabled.
- **The HTML Purifier library**, `ezyang/htmlpurifier` — SafeDelete uses it to
  parse links out of body-field markup. Add it with Composer (see below).

There are no required submodules; an optional submodule reports on menu links that
point at archived nodes.

## Install with Composer

From the project root, require the module and the HTML Purifier library:

```bash
composer require drupal/safedelete ezyang/htmlpurifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Linkit and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/safedelete ezyang/htmlpurifier -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en safedelete -y
```

Drush will enable Linkit and Node as dependencies if they are not already on.

## Verify it worked

Visit **Configuration → Development → SafeDelete**
(`/admin/config/development/safedelete`) — the settings form loading confirms the
module is active. Then head to [Configuration](../configuration/index.md) to choose
which content types SafeDelete should guard, since it takes effect only for the
bundles you enable there.
