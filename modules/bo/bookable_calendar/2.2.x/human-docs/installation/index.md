# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Text** and **Views** modules (enabled automatically as dependencies).
- The [**Smart Date**](https://www.drupal.org/project/smart_date) module
  (`drupal/smart_date` `^4.0|^4.1`), including its **Smart Date Recur** submodule —
  Bookable Calendar uses Smart Date for all its date/time and recurrence handling.
  Composer pulls it in automatically.
- The optional [**Token**](https://www.drupal.org/project/token) module is
  recommended so the email-template forms show a token browser, but it is not
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/bookable_calendar -W
```

The `-W` (`--with-all-dependencies`) flag is important — it lets Composer pull in
Smart Date and any other shared dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bookable_calendar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bookable_calendar -y
```

This also enables Smart Date (and Smart Date Recur), Text, and Views if they are
not already on, and installs the default Views and an optional ECA process model.

## Grant the booking permission

The key permission for a public calendar is **Create booking contact**
(`create booking contact`). Unlike the module's administrative permissions, this
one is **not** restricted, precisely so you can grant it to the *anonymous* (or
*authenticated*) role to let visitors book. Assign permissions at **People →
Permissions** (`/admin/people/permissions`). The `administer …` permissions (which
gate settings, check-in, and the bookings feed) and **Bypass booking contact
checks** are restricted — grant those only to trusted staff.

## Optional submodule — bulk booking

Bookable Calendar ships one optional submodule, **Bookable Calendar VBO Booking**
(`bookable_calendar_vbo_booking`), which adds Views Bulk Operations actions so staff
can bulk-book or bulk-remove bookings across many opening instances at once:

```bash
drush en bookable_calendar_vbo_booking -y
```

## Verify it worked

Visit **Configuration → System → Bookable Calendar**
(`/admin/config/system/bookable-calendar`) to confirm the settings form loads, then
create a calendar and an opening under **Structure → Bookable Calendar**. See
[Configuration](../configuration/index.md) for the setup.
