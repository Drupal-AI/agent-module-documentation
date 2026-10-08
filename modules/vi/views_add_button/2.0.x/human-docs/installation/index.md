# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled.
- The **[Token](https://www.drupal.org/project/token)** module
  (`drupal/token ^1.15`), used for the button's token support. Composer installs
  it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/views_add_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_add_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_add_button -y
```

Drupal enables Views and Token at the same time if they are not already on. There
is no configuration step — the button becomes available as a Views area handler
("Global: Entity Add Button") and a Views field handler ("Entity Add Button") that
you add inside any View.

## Verify it worked

Edit any View, click **Add** next to **Header** (or **Fields**), and search the
handler list for **Entity Add Button**. If it appears, the module is installed and
ready to configure.
