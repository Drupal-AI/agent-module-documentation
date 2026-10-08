# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- **PHP 8.1 or 8.2** (`^8.1.0 || ^8.2.0`).
- The **`illuminate/collections`** Composer library (`^9.0 || ^10.0`) — Composer
  installs this for you automatically when you require the module.

Fluent has no other module dependencies.

## Install with Composer

Because Fluent depends on a third‑party PHP library, installing with Composer is the
supported path — it pulls `illuminate/collections` into your project's `vendor/`
directory. From the project root:

```bash
composer require drupal/fluent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the collections library
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fluent -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fluent -y
```

You do **not** need to enable the `fluent_test` submodule — it exists only for the
project's automated tests.

## Verify it worked

Fluent has no admin page. To confirm it is available, call its helper from any code
context (for example a quick `drush php:eval`) against a loaded entity:

```php
using($node)->value('title');
```

If it returns the node title, the library is wired up correctly.
