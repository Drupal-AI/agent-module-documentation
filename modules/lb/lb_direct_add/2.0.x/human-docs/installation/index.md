<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Layout Builder** (`layout_builder`) and **Block** (`block`) modules
  enabled — these are the module's dependencies, and Drupal enables them
  automatically.
- Optionally, [Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
  if you want the direct-add list to honor per-region block-type rules. This is not
  required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_direct_add -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lb_direct_add -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_direct_add -y
```

That is all it takes. The direct-add widget is active in every Layout Builder region
immediately, using the default dropbutton style. There are no submodules.

## Verify it worked

Edit any entity or view mode that uses Layout Builder. Where you previously saw a
single **Add block** link in each region, you should now see a **drop-button** listing
the available inline block types directly.

Next, if you want the popover style instead of the dropbutton, or want to control who
sees the "More…" chooser, see [Configuration](../configuration/index.md).
