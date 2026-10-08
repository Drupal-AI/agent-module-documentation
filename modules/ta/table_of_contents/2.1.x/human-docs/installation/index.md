# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Text** (`text`) and **Block** (`block`) modules — both part of a standard install.
- The PHP **DOM extension** (`ext-dom`), which is enabled in virtually all PHP builds.
- The **`symfony/css-selector`** library, which converts your CSS selector into the query used to
  find headings. Composer installs it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/table_of_contents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `symfony/css-selector`
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/table_of_contents -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en table_of_contents -y
```

Enabling the module doesn't add a table of contents anywhere by itself — you switch it on per
field and then place its block.

## Next step

Head to [Configuration](../configuration/index.md) to enable the TOC on a field and place the
block.
