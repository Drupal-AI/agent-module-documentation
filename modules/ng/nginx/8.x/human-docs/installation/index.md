# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Let's Encrypt** module (`letsencrypt:letsencrypt`) — a required
  dependency used for TLS certificate integration. Install it with Composer if it
  isn't already present.
- An **Nginx** web server you administer, since the module's purpose is to supply
  server configuration for it.

There are no third‑party PHP library requirements.

> **Note:** the project is at `8.x-dev` and is not covered by Drupal's security
> advisory policy — vet it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/nginx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Let's Encrypt
module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nginx -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nginx -y
```

Drupal will enable the Let's Encrypt module as a dependency.

## Verify it worked

Enabling the module makes its shipped Nginx configuration available. The
meaningful verification is at the web‑server level: apply the configuration to
your Nginx setup, reload Nginx, and confirm the site serves correctly (and, if you
use the Let's Encrypt integration, that certificates are issued and valid). See
"How to use it" in the [overview](../index.md).
