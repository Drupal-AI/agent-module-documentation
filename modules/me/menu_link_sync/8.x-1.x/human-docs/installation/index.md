# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **Menu Link (Menu Node API)** module (`menu_link`) — a required
  dependency that Composer pulls in for you.
- No third‑party PHP or JavaScript libraries.

**Recommended (optional):**

- [Menu Link Weight](https://www.drupal.org/project/menu_link_weight) — enables
  synchronizing a link's *relative* tree position rather than just its numeric
  weight.
- [Hierarchical Select](https://www.drupal.org/project/hierarchical_select) — makes
  large menu trees easier to manage.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Menu Link (Menu Node API) module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_sync -y
```

## Verify it worked

Edit a translated node and open the **Menu link settings** section of the form —
you should see a new **Synchronize** button. Clicking it should update the parent
and weight fields via AJAX to match the source translation's menu link.
