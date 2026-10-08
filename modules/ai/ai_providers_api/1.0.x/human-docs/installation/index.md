# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other module dependencies are declared. This is a framework module intended
  to be built on in code.

> **Version note:** at the time these docs were written the module was an early
> alpha release (1.0.0‑alpha4). Treat it as a developer preview rather than a
> production‑hardened dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_providers_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_providers_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_providers_api -y
```

## After enabling

Go to **People → Permissions** and grant the *Administer AI providers*
permission to trusted administrative roles only. From there the module is used
by developers who define provider plugins against its interface — see
[the overview](../index.md) for how it fits together.
