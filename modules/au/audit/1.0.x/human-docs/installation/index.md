# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- No third-party Composer libraries are required by the base module. Some
  code-quality sub-audits (PHPStan, PHPCS, PHPUnit) expect the corresponding
  developer tools to be available in your environment.

## Install with Composer

From the project root:

```bash
composer require drupal/audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audit -y
```

## Enable the sub-audits you need

Audit ships many submodules, one per dimension (security, SEO, performance,
database, entities, fields, views, modules, updates, PHPStan/PHPCS/PHPUnit, Twig,
images, i18n, complexity, duplication, watchdog, and others). Enable only the ones
you want, for example:

```bash
drush en audit_security audit_performance -y
```

To run the whole set at once, enable the aggregator:

```bash
drush en audit_all -y
```

After enabling, grant the audit permissions to trusted roles and run the audits —
see [Configuration](../configuration/index.md).
