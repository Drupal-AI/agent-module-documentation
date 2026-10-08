# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Layout Paragraphs** module (`drupal/layout_paragraphs`) — required. This is
  a contrib module, so Composer pulls it in for you if it isn't already present.
- **Optional:** the **CodeMirror Editor** module (`codemirror_editor`), which
  upgrades the rules textarea into a syntax‑highlighted YAML editor, and **Mercury
  Editor** if you want to restrict its templates.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs_restrictions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required **Layout Paragraphs**
module if you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_paragraphs_restrictions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs_restrictions -y
```

This enables Layout Paragraphs as a dependency if it isn't already on. Then author
your rules in the settings form — see [Configuration](../configuration/index.md).

There are no submodules.
