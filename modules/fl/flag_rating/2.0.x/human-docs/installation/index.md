# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Flag** module (`flag`) — Flag Rating extends it.
- Core's **Views** module (`views`) — used to display and aggregate ratings.
- Core's **Node** module (`node`).

These are installed/enabled as dependencies. There are no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_rating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_rating -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_rating -y
```

This also enables the Flag, Views, and Node modules if they aren't already on.

## Verify it worked

Go to **Structure → Flags** (`/admin/structure/flags`) and create a flag. Confirm
that **AJAX Rating Link** is available as the plugin type. After saving and
selecting a score field, place the flag on a content type via **Manage display**
and view a piece of content — you should see the rating control (stars) rendered
and be able to submit a rating.
