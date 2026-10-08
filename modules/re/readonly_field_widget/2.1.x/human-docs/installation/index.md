# Installation

## Requirements

Read-only Field Widget is lightweight and has no third-party dependencies. It
needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's Field UI is what you'll use to assign the widget, so make sure the
  **Field UI** module is enabled if you want to configure it through the admin
  interface.

There are no additional Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/readonly_field_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/readonly_field_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readonly_field_widget -y
```

That's all it takes. There is no configuration form to visit afterwards — the
widget becomes available as a choice on every bundle's **Manage form display**
page. See the [overview](../index.md) for how to assign it to a field.
