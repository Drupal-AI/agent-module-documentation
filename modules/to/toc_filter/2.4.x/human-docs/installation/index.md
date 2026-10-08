# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — part of core, normally already enabled.
- The **TOC API** module (`toc_api`), a contributed dependency that does the actual
  parsing and rendering. Composer installs it for you when you require TOC Filter.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/toc_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TOC API and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toc_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toc_filter -y
```

Drupal enables the required **TOC API** module at the same time. No submodules ship
with TOC Filter itself.

## Next step

Enabling the module does not switch anything on by itself — you need to turn the
filter on for at least one text format before `[toc]` tokens do anything. See
[Configuration](../configuration/index.md).
