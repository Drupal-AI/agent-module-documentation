# Installation

## Requirements

AI Provenance is deliberately self-contained — it records disclosure data and
calls no provider, so it depends only on core:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **System**, **User**, and **Options** modules (always present / enabled
  automatically).

It does **not** require the AI module, because it never makes AI calls. There are
no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provenance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provenance -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provenance -y
```

## After enabling

1. Grant **Administer AI provenance** (restricted) to the administrators who
   configure tracking and manage records, and **View AI provenance** to the roles
   that should see the front-end disclosure badges.
2. Head to [Configuration](../configuration/index.md) to choose which entity types
   are tracked.
