# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Metatag** module (`metatag`) — required. You should already have a Metatag
  field on the bundle whose form you want to simplify.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_simple_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Metatag if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_simple_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_simple_widget -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a Metatag field)* → Manage form
display**, open the Metatag field's widget settings (the gear icon), and confirm
**Simplified meta tags form** is available as a widget choice. Select it, save, and
check that the node edit form now shows the simplified title/description fields.
