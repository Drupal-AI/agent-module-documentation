# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Drupal core's **Media** module (`media`), which Drupal enables automatically as
  a dependency.

There are no contributed‑module dependencies, no API keys, and no third‑party PHP
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_dreambroker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_dreambroker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_dreambroker -y
```

Core's Media module is enabled automatically if it is not already on.

## Verify it worked

Go to **Structure → Media types → Add media type**
(`/admin/structure/media/add`) and confirm that **Dream Broker** appears in the
**Media source** dropdown. Full step‑by‑step setup is in the
[main guide](../index.md).
