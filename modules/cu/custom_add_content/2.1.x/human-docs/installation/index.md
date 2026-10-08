# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies, and no third‑party PHP or JavaScript libraries.
- *Recommended (optional):* [Special Menu Items](https://www.drupal.org/project/special_menu_items)
  for unlinkable menu headings, and
  [Menu Item Visibility](https://www.drupal.org/project/menu_item_visibility) for
  per‑item visibility.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_add_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_add_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_add_content -y
```

Enabling the module creates the **Custom add content page** menu, with a link per
existing content type.

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`) and confirm the **Custom add
content page** menu is present with your content types listed. Then visit
`/node/add` and check that it renders as the customizable menu rather than the core
alphabetical list.
