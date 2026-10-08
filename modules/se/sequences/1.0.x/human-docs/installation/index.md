# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No other module dependencies, and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/sequences -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sequences -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sequences -y
```

## Verify it worked

This is an API-only module, so there is no page to visit. From your own custom
code (or a quick `drush php:eval`) you can confirm the service is available:

```php
$next_id = \Drupal::service('sequences.generator')->nextId('my_sequence');
```

Calling it repeatedly for the same sequence name should return increasing
integers. Remember these IDs are sequential and therefore predictable — use random
tokens instead wherever unguessability is a security requirement.
