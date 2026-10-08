# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Editor** module (`editor`) — the only dependency, and Drupal enables it
  automatically when you turn on BUEditor.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bueditor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bueditor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bueditor -y
```

Drupal enables the core Editor module as a dependency at the same time.

## After enabling

Enabling the module does not change any text format yet — you still have to attach a
BUEditor to a format. Head to [Configuration](../configuration/index.md) to create or
adjust an editor, grant the permissions, and choose BUEditor as the editor for a text
format.
