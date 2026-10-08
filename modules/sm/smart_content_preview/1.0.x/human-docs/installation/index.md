# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Smart Content** (`smart_content`) — the base module this submodule extends.

There are no third-party Composer packages or PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_content_preview -W
```

The Composer package name (`drupal/smart_content_preview`) matches the module's
machine name (`smart_content_preview`). The `-W` (`--with-all-dependencies`) flag
lets Composer install Smart Content and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_content_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_content_preview -y
```

Drupal enables Smart Content at the same time, since it is a dependency. There's
nothing else to configure — once enabled, a **Preview** checkbox appears next to
each segment in your Smart Content segment sets.
