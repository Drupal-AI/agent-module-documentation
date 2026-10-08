# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module, version **6.x** (`drupal/webform:^6.0`) — Composer
  pulls it in and Drupal enables it as a dependency.
- For paid bookings, a **PayPal REST** application (client id and secret). This
  is optional; without it, booking forms are free.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_booking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (such as Webform) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_booking -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_booking -y
```

Once enabled, a **Booking** element becomes available in the Webform UI and the
global settings form appears at **Configuration → Web services → Webform
Booking**.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Webform Booking Calendar** | `webform_booking_calendar` | A FullCalendar block and feed that displays your bookings on a calendar. |
| **Webform Booking Price Element** | `webform_booking_price_element` | A titled price line-item element you can combine with the booking element to build multi-service forms. |

Enable them individually, for example:

```bash
drush en webform_booking_calendar -y
```

Each submodule requires the base Webform Booking module, which is already present
once you have installed it above.
