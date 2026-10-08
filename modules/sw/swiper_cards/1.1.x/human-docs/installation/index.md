# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which is part of the standard install and is
  enabled automatically as a dependency.

There are no third‑party PHP or JavaScript library requirements to install
separately, and there are no submodules. Note that this project is **not covered
by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/swiper_cards -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swiper_cards -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

You can enable it from the command line:

```bash
drush en swiper_cards -y
```

Or through the UI: go to the **Extend** page (`/admin/modules`), find **Swiper
Cards**, tick its checkbox, and click **Install**.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. A **Swiper Cards** block should appear in the list of
available blocks. See [Configuration](../configuration/index.md) to set it up.
