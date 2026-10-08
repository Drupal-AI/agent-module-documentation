# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field UI** module (`field_ui`) enabled — this is the only dependency, and
  it is part of core. It supplies the Manage display and Manage form display pages
  the button attaches to.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_field_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_field_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_field_button -y
```

That's all it takes — there is no configuration.

## Verify it worked

Go to a **Manage display** or **Manage form display** page (for example
`/admin/structure/types/manage/article/display`), click a field's gear icon to
expand its settings, and confirm a red **Disable** button now sits next to Update and
Cancel. Clicking it should move the field to the Disabled section and save the
display.
