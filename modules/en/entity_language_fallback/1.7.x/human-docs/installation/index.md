# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) enabled — this is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on Entity
  Language Fallback. You'll want more than one language configured for the module
  to be useful.
- **Optional:** the [Search API](https://www.drupal.org/project/search_api) module,
  if you want fallback translations indexed and searchable. The integration only
  activates when Search API is present; it is not required.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_language_fallback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_language_fallback -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_language_fallback -y
```

## Next steps

Enabling the module adds an **Entity fallback language** section to each language's
edit form. Set the fallback chains there — see
[Configuration](../configuration/index.md).
