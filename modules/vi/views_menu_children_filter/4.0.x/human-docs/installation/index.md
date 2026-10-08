# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core's **Views** module (`views`) enabled — the only dependency. Drupal enables it
  automatically as a dependency, and the **Views UI** module is what you use to build
  the Views in practice.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/views_menu_children_filters -W
```

> **Note the trailing `s`.** The project's machine name is
> `views_menu_children_filter` (singular), but its Composer package is
> `drupal/views_menu_children_filters` (plural). Use the plural form with Composer and
> the singular form with `drush en`.

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_menu_children_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_menu_children_filter -y
```

That is all the setup there is. The new **Menu children** argument and sort, and the
**Menu item enabled** filter, become available inside the Views UI immediately — there
is no configuration page and no permissions to grant.

## Verify it worked

Edit any node-based View at **Structure → Views**. In the **Contextual filters**
section, click **Add** and search for **Menu children** — if it appears in the list,
the module is active. See the [How to use it](../index.md#how-to-use-it) section of
the overview for building an actual "child pages" listing.
