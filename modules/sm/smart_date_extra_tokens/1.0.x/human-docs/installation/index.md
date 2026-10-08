# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Smart Date** module (`smart_date`).

There are no third-party Composer packages or PHP libraries required, and no
configuration to do afterwards.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_date_extra_tokens -W
```

The Composer package name (`drupal/smart_date_extra_tokens`) matches the module's
machine name (`smart_date_extra_tokens`). The `-W` (`--with-all-dependencies`)
flag lets Composer install Smart Date and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_date_extra_tokens -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_date_extra_tokens -y
```

That's all — no configuration is required or provided. The extra tokens
(`value-closest` and `end_value-closest`) are immediately available wherever tokens
are supported.
