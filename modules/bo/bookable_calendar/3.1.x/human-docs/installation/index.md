# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- **PHP 8.3 or newer**, with the **Sodium** extension (used to encrypt external
  calendar credentials).
- Core's **Text** and **Views** modules (enabled automatically as dependencies).
- The [**Smart Date**](https://www.drupal.org/project/smart_date) module
  (`drupal/smart_date` `^4.3`), including its **Smart Date Recur** submodule —
  Bookable Calendar uses Smart Date for all date/time and recurrence handling.
  Composer pulls it in automatically.
- The optional [**Token**](https://www.drupal.org/project/token) module is
  recommended so the email-template forms show a token browser, but it is not
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/bookable_calendar:^3.0
```

This pulls in Smart Date and the other shared dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bookable_calendar:^3.0`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bookable_calendar -y
```

This also enables Smart Date (and Smart Date Recur), Text, and Views if they are
not already on, and installs the default Views.

## Grant the booking permission

The key permission for a public calendar is **Create booking contact**
(`create booking contact`). Unlike the module's administrative permissions, this
one is **not** restricted, precisely so you can grant it to the *anonymous* (or
*authenticated*) role to let visitors book. Assign permissions at **People →
Permissions** (`/admin/people/permissions`). The `administer …` permissions (which
gate settings, check-in, and the bookings feed) and **Bypass booking contact
checks** are restricted — grant those only to trusted staff.

To let non-admin schedule managers run their own calendars, grant the "own"
permissions (**Create bookable calendar**, **Edit own bookable calendars**,
**Create/Edit openings on own bookable calendars**) plus the relevant view and
overview permissions. See [Configuration](../configuration/index.md).

## Optional submodules

Bookable Calendar ships several optional submodules — enable only what you need:

- **Bookable Calendar VBO Booking** (`bookable_calendar_vbo_booking`) — Views Bulk
  Operations actions to bulk-book or bulk-remove reservations. Requires
  [Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations).
- **Bookable Calendar Commerce** (`bookable_calendar_commerce`) — paid reservations
  through Drupal Commerce 3.x checkout. Requires
  [Commerce](https://www.drupal.org/project/commerce).
- **Bookable Calendar External Sync** (`bookable_calendar_external`) plus a provider —
  **Google Calendar** (`bookable_calendar_google`) or **Microsoft Outlook**
  (`bookable_calendar_microsoft`) — to synchronize reservations and optionally block
  externally busy times.

```bash
drush en bookable_calendar_vbo_booking -y
```

## Verify it worked

Visit **Configuration → System → Bookable Calendar**
(`/admin/config/system/bookable-calendar`) to confirm the settings form loads, then
create a calendar and an opening under **Structure → Bookable Calendar**. See
[Configuration](../configuration/index.md) for the setup.

## Upgrading from 2.x

Version 3.0 is a major, destructive data-model upgrade. Back up first, update to the
latest 2.2.x and run its database updates, then deploy 3.x and run `drush updatedb`.
Read the module's `UPGRADE.md` before upgrading — the update consolidates the legacy
per-seat rows into Booking Contact party sizes and removes the old `booking` entity
type and reverse-reference fields.
