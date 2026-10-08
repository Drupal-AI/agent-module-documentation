# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies — it builds on core's Field UI (**Manage form display**).

## Install with Composer

From the project root:

```bash
composer require drupal/fwl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fwl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fwl -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display** and click
the gear/edit icon on any field's widget. You should now see **Width in %** and
**Maximum width in px** inputs in the widget's settings. Set two fields to 50%,
save, then open that entity's edit form — the two fields should sit side by side.
