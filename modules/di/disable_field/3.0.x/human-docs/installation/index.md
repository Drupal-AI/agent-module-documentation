# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Field** (`field`) and **User** (`user`) modules — both are part of a
  standard Drupal install and are enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/disable_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_field -y
```

The README recommends clearing caches once after first enabling the module
(`drush cr`) so the new settings section shows up on field forms.

## After enabling

Grant the **Administer disable field settings** permission to the roles that
should be allowed to configure locked fields (see
[Configuration](../configuration/index.md)), then open any field's **Edit** form
to find the **Disable Field Settings** section.
