# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reviews -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reviews -y
```

## Verify it worked

Go to **Structure → Reviews → Settings**
(`/admin/structure/reviews/settings`). You should see the reviews settings form,
where you turn the system on and choose which content types accept reviews. Before
users can submit or moderate reviews, review the module's permissions at **People →
Permissions** and continue to [Configuration](../configuration/index.md).
