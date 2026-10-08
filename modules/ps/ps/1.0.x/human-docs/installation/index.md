# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`) — this is the only dependency, and there is little point in the
  report without it. Drupal enables it automatically as a dependency when you turn
  on Paragraphs Stats.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Paragraphs isn't already in your codebase, Composer
pulls it in too.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ps -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ps -y
```

## Next steps

There is no configuration form. Grant the two permissions, open **Reports →
Paragraphs stats Report**, and click **Update the data structure** to populate the
metrics — see [How to use it](../index.md#how-to-use-it) for the full walkthrough.
