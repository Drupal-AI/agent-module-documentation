# Installation

## Requirements

Tax Number is deliberately self‑contained:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No modules outside Drupal core are required.
- The [Webform](https://www.drupal.org/project/webform) module is optional — you
  only need it if you want to use the tax‑number *webform element*. The field
  type works with core alone.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/tax_number -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package `drupal/tax_number` matches the
module's machine name, `tax_number`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tax_number -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tax_number -y
```

## Verify it worked

After enabling, add a field to any content type: on the **Manage fields** screen
you should now see **Tax number** as an available field type. Add it, then open
**Manage form display** and confirm the widget offers a choice of validator
(default, Spanish, Portuguese). If you have Webform installed, the **Tax number**
element should appear in the webform element list as well.
