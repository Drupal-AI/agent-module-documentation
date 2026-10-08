# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.2 or newer** (`php: >=8.2`).
- The [Token](https://www.drupal.org/project/token) module (`token`) — Composer pulls it in
  automatically as a dependency.
- Optional: [Custom Formatters](https://www.drupal.org/project/custom_formatters) if you want
  to use `[formatted_field-*]` / `[field_property:*]` tokens inside its HTML + Token engine.
  Field Tokens integrates with it but does not require it.

## Install with Composer

From the project root:

```bash
composer require drupal/field_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed (including the Token module).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/field_tokens -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_tokens -y
```

There is no settings form and no submodules. The new tokens are available the moment the
module is enabled — see [How to use it](../index.md#how-to-use-it).
