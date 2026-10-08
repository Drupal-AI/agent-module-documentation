# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- The **Webform** module (`webform`) — this is the module's dependency and provides
  all of the form-building functionality. Drupal enables it for you when you turn on
  Sector Webform (Composer downloads it with the command below).

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sector_webform -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_webform -y
```

Enabling it turns on Webform (if it is not already on), installs the default Sector
webforms, and creates the **Webform Manager** and **Webform Submission Manager**
roles.

## Verify it worked

Go to **Structure → Webforms** (`/admin/structure/webform`) and confirm the
default forms are listed. Then check **People → Roles** (`/admin/people/roles`) for
the two new Sector-compatible webform roles. Note that this project is **not covered
by Drupal's security advisory policy**, so keep it updated and review the forms it
ships before exposing them publicly.
