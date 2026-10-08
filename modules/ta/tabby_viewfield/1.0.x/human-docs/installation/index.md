# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Tabby** module (`tabby`) — Tabby Viewfield relies on it to render the
  tabs, so it must be present and enabled (along with the Tabby JS library it
  needs). Composer pulls it in for you with the command below.
- A **Viewfield** field on the entity you want to display as tabs (the *viewfield*
  field type).

There are no PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tabby_viewfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Tabby
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tabby_viewfield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tabby_viewfield -y
```

This also enables the Tabby dependency if it is not already on.

## Verify it worked

On an entity that has a Viewfield, open **Manage display** and confirm that
**Tabby viewfield** appears as a format option for the field. Set it, configure the
tab titles, and view an entity with several views in the field — they should render
as tabs.
