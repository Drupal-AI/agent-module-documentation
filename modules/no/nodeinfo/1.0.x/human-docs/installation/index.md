# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

There are no additional contributed‑module dependencies and no third‑party Composer or
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nodeinfo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodeinfo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodeinfo -y
```

Enabling the module makes your site serve NodeInfo and/or NodeInfo2 metadata at the
well‑known endpoints.

## Verify it worked

After enabling, request the site's well‑known NodeInfo discovery document
(`/.well-known/nodeinfo`) — it should return JSON pointing to your NodeInfo document,
which in turn publishes the server metadata (software name/version, protocols, and
optionally usage stats). Confirm you are comfortable with the information disclosed
before relying on it in production.
