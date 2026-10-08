# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — enabled by default on standard Drupal
  installs; it is the module's only dependency.
- A **Moodle** installation with web services enabled and a **web-service
  token** you can use to authenticate (see "Connect to Moodle" on the
  [overview page](../index.md)).

There are no third-party PHP library requirements.

> **Note:** this module is **not covered** by Drupal's security advisory policy
> and is minimally maintained. Review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/moodle_field_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moodle_field_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moodle_field_widget -y
```

## Configure the connection

Enabling the module is not enough on its own — visit **Configuration → Web
services → Moodle** (`/admin/config/services/moodle`) and enter your Moodle API
token so the widget can fetch courses. See "Connect to Moodle" on the
[overview page](../index.md) for the details, including how to keep the token out
of version control.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep moodle_field_widget
```

Then, on a string field's **Manage form display**, confirm the Moodle course
widget appears in the widget dropdown, and that editing content shows a working
course picker populated from your Moodle site.
