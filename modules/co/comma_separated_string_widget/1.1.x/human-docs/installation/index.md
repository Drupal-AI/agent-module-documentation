# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Field** module (enabled in any standard Drupal site), since this
  provides a field widget.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/comma_separated_string_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comma_separated_string_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comma_separated_string_widget -y
```

## Verify it worked

Edit the **Manage form display** of a content type that has a multi‑value string
field. The **Comma separated string widget** should appear in that field's widget
dropdown. Select it, save, then add a piece of content and confirm that typing
comma‑separated values produces separate stored values. See "How to use it" on the
[overview page](../index.md) for the full walkthrough.
