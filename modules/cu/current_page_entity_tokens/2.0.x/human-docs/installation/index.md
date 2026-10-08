# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Token](https://www.drupal.org/project/token)** module (`^1.0`) — this is
  the only dependency, and the module is built directly on top of it. Composer pulls
  it in for you if it isn't already present.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/current_page_entity_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Token module if you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/current_page_entity_tokens -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en current_page_entity_tokens -y
```

## Next steps

There is nothing to configure. Once enabled, the `[current-page:*]` tokens are
available anywhere Drupal does token replacement — see
[How to use it](../index.md#how-to-use-it).
