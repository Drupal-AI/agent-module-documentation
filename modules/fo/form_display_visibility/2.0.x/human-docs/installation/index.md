# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) — this is a hard dependency, because the
  conditions are configured on the Field UI "Manage form display" page. Drupal
  enables it automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/form_display_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_display_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_display_visibility -y
```

## Verify it worked

1. Go to **Structure → Content types → *(any type)* → Manage form display**.
2. Click the **cogwheel** next to any field to open its widget settings.
3. You should see a **Visibility Conditions** section with **Access by Role** and
   **Access by Permission** options.

If those conditions appear, the module is working. See
[Configuration](../configuration/index.md) for how to use them.
