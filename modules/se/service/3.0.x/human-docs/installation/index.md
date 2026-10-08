# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- **PHP 8.3 or higher** for this 3.0.x release. (Earlier branches supported older
  PHP versions — 1.0.0–1.0.3 and 2.0.0+ needed PHP 8.2, and 1.0.4+ needed PHP
  5.5 — but 3.0.0 requires 8.3.)
- No other module dependencies, and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/service -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/service -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en service -y
```

## Verify it worked

This is an API-only module, so there is no page to visit and nothing to configure.
It is working once it is enabled and your custom code can reference its base
classes and traits (for example `Drupal\service\BlockBase`,
`Drupal\service\ConfigFactoryTrait`, and `Drupal\service\EntityTypeManagerTrait`).
The payoff appears in your own module's PHP, where dependency injection now takes
far less boilerplate.
