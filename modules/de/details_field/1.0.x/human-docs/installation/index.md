# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) and **Text** (`text`) modules, which Drupal enables
  automatically as dependencies.

There are no third-party Composer or PHP library requirements. This module is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/details_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/details_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en details_field -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click **Add
field**. In the field-type list you should now see **Details element** under the
*Formatted text* category. See the [main guide](../index.md) for how to add and
display it.
