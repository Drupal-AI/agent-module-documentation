# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **User** module (enabled automatically as a dependency).
- No third‑party Composer or PHP library requirements.

Recommended companions (not required): the **Google Tag** module and the
**Webform** module, which fit naturally into the GCLID capture‑and‑submit
workflow.

## Install with Composer

From the project root:

```bash
composer require drupal/gclid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gclid -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gclid -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Configure
GCLID settings**. If the settings form loads, continue to
[Configuration](../configuration/index.md).
