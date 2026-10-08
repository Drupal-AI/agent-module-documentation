# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core media stack: **Field**, **File**, **Image**, **Link**, **Media**, **Media
  Library**, **Path**, and **Responsive Image**.
- The **Entity Usage** module (`entity_usage`) — a contrib dependency used for
  file‑usage tracking.
- A **Kontainer account** with an **integration id and secret**.

## Install with Composer

From the project root:

```bash
composer require drupal/kontainer -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in **Entity Usage** and the core media dependencies in one step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kontainer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kontainer -y
```

Enabling Kontainer will also enable the core media modules and Entity Usage if
they are not already on. It creates several Kontainer media types; after you have
configured the module, export the created configuration with:

```bash
drush cex
```

## Verify it worked

Log in as an administrator and go to **Configuration → Media → Kontainer**
(`/admin/config/media/kontainer`). If the settings form loads, the module is
installed — continue to [Configuration](../configuration/index.md) to connect your
Kontainer account. The site status report will warn you while required settings
(such as the CDN asset host, if you use the CDN source) are still missing.
