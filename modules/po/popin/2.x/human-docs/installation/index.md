# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No additional Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/popin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/popin -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en popin -y
```

## Verify it worked

1. Go to **Structure → Block layout** and place the **Popin block** into a region
   (for example the footer).
2. Go to **`/admin/content/popin`** and set some content (a title is enough to
   start).
3. Visit the front end as a fresh visitor (a new session or a private window) — the
   popin should appear once. Reload and it should not appear again for that session.
