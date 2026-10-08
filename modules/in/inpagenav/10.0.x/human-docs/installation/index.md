# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module, which Drupal ships and enables by default — you place
  the navigation as a block.

There are no third-party Composer packages or external JavaScript libraries to
download; the module bundles its own small script.

## Install with Composer

From the project root:

```bash
composer require drupal/inpagenav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inpagenav -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inpagenav -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Block layout**. You should be
able to place a block called **Inpage Navigation Block**. Its settings form is at
**Structure → Inpage navigation → Settings**
(`/admin/structure/inpagenav/settings/config_settings`).

Once you have configured which headings to collect and placed the block, open a
long page and confirm that a list of jump links appears and scrolls you to each
section. Next, see [Configuration](../configuration/index.md).
