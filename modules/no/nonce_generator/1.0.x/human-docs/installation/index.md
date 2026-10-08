# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/nonce_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nonce_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nonce_generator -y
```

## Verify it worked

There is no admin page to visit — the module is a developer primitive with no
settings. It is working once it is enabled: its nonce service and the
`nonce_script` render element become available to your code, and inline scripts
you emit through a NonceScript plugin will carry a fresh per‑request nonce that
matches the `script-src` CSP header. See the "How to use it" section of the
[overview](../index.md) for how to consume it from a custom module.
