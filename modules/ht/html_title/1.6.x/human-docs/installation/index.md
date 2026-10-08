# Installation

## Requirements

HTML Title is lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`), which is part of standard Drupal and is enabled
  automatically as a dependency.
- No third-party Composer packages, PHP extensions, or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/html_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_title -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_title -y
```

Enabling it immediately lets the default allowed tags (`<br>`, `<sub>`, `<sup>`)
render in node titles. Titles you've already saved with those tags start showing
their markup right away — nothing about the stored values changes.

## Verify it worked

Edit a node and set its title to something like `H<sub>2</sub>O`, then view the
node. The "2" should render as a subscript rather than showing the raw `<sub>`
tags. To allow more tags, or to apply the same rendering to other fields and Views
columns, see [Configuration](../configuration/index.md).
