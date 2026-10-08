# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`), since the module adds its information to
  the Manage fields overview. Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_quick_cardinality -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_quick_cardinality -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_quick_cardinality -y
```

## Verify it worked

Go to any bundle's **Structure → Content types → *(type)* → Manage fields**. Each
field row should now show its cardinality (1, a specific number, or "unlimited")
without your having to open the field's settings. If you see it, the module is
working — there's nothing else to configure.
