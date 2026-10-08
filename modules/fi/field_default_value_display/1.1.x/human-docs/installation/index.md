# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: ^11`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules. Field is
  almost always already on; Field UI is the module that gives you the *Manage
  fields* screens this column enhances, so make sure it is enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_default_value_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_default_value_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_default_value_display -y
```

If Field UI is not yet enabled, turn it on too:

```bash
drush en field_ui -y
```

There is no configuration to do.

## Verify it worked

Go to any content type's field list — for example **Structure → Content types →
Article → Manage fields**. You should see a new **Default value** column showing
each field's configured default (or empty where no default is set). Confirm the
same column appears on other fieldable entity types, such as a taxonomy
vocabulary's or user account's Manage fields page.
