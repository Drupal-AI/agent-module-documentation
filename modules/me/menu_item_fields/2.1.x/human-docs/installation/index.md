# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- Core's **Menu Link Content** module (`menu_link_content`) enabled — the only
  dependency, and Drupal enables it automatically.
- No third-party Composer or PHP libraries.
- To build fields you also need core's **Field UI** module enabled, which the
  submodule below relies on.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_item_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_item_fields -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_item_fields -y
```

This makes menu links fieldable and renderable and registers the **"Menu with fields"**
block — but on its own it gives you no way to *add* fields yet. For that, enable the
submodule below.

## Submodule — enable it to build fields

Menu Item Fields ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Menu Item Fields UI** | `menu_item_fields_ui` | Turns on Drupal's Field UI for menu links, so the standard **Manage fields**, **Manage form display**, and **Manage display** screens become available for menu items. |

Enable it when you are building your fields:

```bash
drush en menu_item_fields_ui -y
```

Like core's own Field UI, you can **disable this submodule in production** once your
fields are created — the fields keep working; you just lose the editing screens.

## Optional companion module

To add link attributes such as `rel` and `target` to menu items, the module suggests
the **Link Attributes** module (`drupal/link_attributes`). Install it with
`composer require drupal/link_attributes` if you want those options.

## Verify it worked

With the UI submodule enabled, go to **Structure → Menus** and edit a menu link — you
should see the Field UI tabs (Manage fields, etc.) for menu links. Then place the
**Menu with fields** block at **Structure → Block layout** and confirm it offers a
**view mode** setting. See the
[How to use it](../index.md#how-to-use-it) section of the overview for the full
workflow.
