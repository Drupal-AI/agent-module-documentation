# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`).
- The contributed **Time Field** module (`time_field`) — this provides the
  underlying time input that Simple Open Hours builds on. Installing Simple Open
  Hours with Composer pulls it in automatically.

There are no third-party PHP or JavaScript library requirements.

> **Note:** the current release is a beta (1.0.0-beta2), so test it before relying
> on it in production. This module is not covered by Drupal's security advisory
> policy.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_open_hours -W
```

The Composer package name (`drupal/simple_open_hours`) matches the module's
machine name (`simple_open_hours`).

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Time Field
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_open_hours -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_open_hours -y
```

Drupal enables core's Datetime module and the Time Field module automatically as
dependencies if they are not already on.

## Verify it worked

Go to a content type's **Manage fields** screen and click **Add field**. If
**Simple Open Hours** appears in the list of available field types, the module is
installed correctly — see the [main guide](../index.md) for how to add and display
the field.
