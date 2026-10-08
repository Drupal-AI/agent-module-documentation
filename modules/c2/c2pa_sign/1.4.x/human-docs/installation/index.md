# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A **C2PA signing certificate and private key** to sign with. You supply these
  during configuration; keep them out of the codebase and out of exported config
  (see [Configuration](../configuration/index.md)).

No other contrib modules are declared as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/c2pa_sign -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/c2pa_sign -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en c2pa_sign -y
```

After enabling, set up the signing certificate and key as described in
[Configuration](../configuration/index.md) before relying on the signatures.
