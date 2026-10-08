# Installation

## Requirements

Field States UI is a field/form‑building helper. It needs:

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`, and it requires
  `drupal/core: ^11.2`). This 4.x branch is Drupal 11 only.
- Core's **Field UI** in play — you configure states on the **Manage form display**
  pages that Field UI provides.

There are no third‑party Composer or PHP library requirements, and it depends on no
other contributed modules.

## Install with Composer

From the project root:

```bash
composer require drupal/field_states_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_states_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_states_ui -y
```

Once enabled, a **Manage Field States** option appears in the widget settings on
every Manage form display page. There is no settings page to visit next — head
straight to a bundle's form display and start adding states, as described in
[Configuration](../configuration/index.md).
