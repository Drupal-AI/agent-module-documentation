# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **Solo** theme, installed (but not necessarily set as the default) — this is
  the destination the module copies blocks into.
- The **W3CSS** theme or one of its sub-themes as your existing source theme —
  that is where the blocks are copied *from*.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/solo_copy_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/solo_copy_blocks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en solo_copy_blocks -y
```

## Install the Solo theme first

Before running the copy, download and install the **Solo** theme. During
installation you can simply install it *without* setting it as your default
theme — the module only needs it present so it has somewhere to copy the blocks
to.

## Verify it worked

Log in as an administrator and go to **Configuration → System → Copy Blocks to
Solo Theme** (`/admin/config/system/solo-copy-blocks`). If the page loads with a
**Copy Blocks** button, the module is installed and ready. See
[Configuration](../configuration/index.md) for how to run the copy.
