# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **Filter** module (`filter`) enabled — this is the module dependency,
  and it is part of core.
- The PHP extensions **`ext-dom`** and **`ext-libxml`** (present in almost every
  PHP build), plus the **`composer/semver`** library, which Composer installs
  automatically as a requirement.
- **At least one Markdown parser library**, installed separately with Composer
  (see below). Without a parser installed, the module runs but has nothing to
  render Markdown with.

## Install with Composer

From the project root, install the module:

```bash
composer require drupal/markdown -W
```

Then install a parser library. The recommended one is CommonMark:

```bash
composer require league/commonmark
```

Other supported parsers you can install instead (or as well) include Parsedown
(`erusev/parsedown`, `erusev/parsedown-extra`) and PHP Markdown
(`michelf/php-markdown`). The module detects which libraries are present and marks
any it cannot find as unavailable.

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/markdown -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdown -y
```

Enabling the module does not render any Markdown on its own — you still have to
switch the filter on for a text format and choose a parser. Continue to
[Configuration](../configuration/index.md).
