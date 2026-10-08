# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no module dependencies.
- To *see* the restyled tabs, a user needs the core **Access contextual links**
  permission, and the page must be a front‑end (non‑admin) route.

## Install with Composer

Note that the **project (Composer) name is `betterlt`** while the **module machine name
is `better_local_tasks`** — the two differ, so watch which you use where.

From the project root:

```bash
composer require drupal/betterlt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/betterlt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `better_local_tasks`:

```bash
drush en better_local_tasks -y
```

That is the entire setup. There is no configuration form.

## Verify it worked

Log in as a user with the **Access contextual links** permission and visit a **front‑end**
page that has local tasks (a node with View/Edit/Delete tabs, for example). You should see
the tabs restyled as a compact panel pinned to the left edge that slides out on hover, each
row carrying an icon. On admin‑theme pages, and for anonymous users, the default core tabs
remain — that is expected.
