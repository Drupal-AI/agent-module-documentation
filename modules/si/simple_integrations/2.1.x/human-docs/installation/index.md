# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No dependent modules, no PHP libraries, and no third‑party Composer packages —
  the connection client is built on Drupal core's own Guzzle HTTP client.

For SOAP connections (which this module does not handle directly) the maintainer
suggests adding the `meng-tian/async-soap-guzzle` library separately.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_integrations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_integrations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_integrations -y
```

## Verify it worked

After enabling, go to **Configuration → Integrations**. If the integrations list
loads, the module is installed. On its own the module provides only the framework —
you will not see any integrations until your custom module ships one (see
[Configuration](../configuration/index.md)). The project ships an example integration
config you can look at as a template.
