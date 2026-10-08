# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Field** module (`field`) — enabled on any standard Drupal site, and
  pulled in automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/required_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/required_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_message -y
```

## Verify it worked

Edit a required field (**Manage fields → *(the field)* → Edit**). With **Required
field** ticked, you should see a new **Required message** box. Enter a message,
save, then submit a form leaving that field empty — your custom message should
appear instead of the default. See the "How to use it" section of the
[overview](../index.md) for the full walkthrough.
