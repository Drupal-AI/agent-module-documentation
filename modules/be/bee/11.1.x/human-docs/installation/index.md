# Installation

## Requirements

- **Drupal core `^10.2 || ^11`**.
- The **BAT** booking/event stack: `bat_booking`, `bat_event_series`,
  `bat_event_ui`.
- **Office Hours** (`office_hours`) for opening times.
- For paid bookings, the **Commerce** modules `commerce_order`,
  `commerce_product`, and `commerce_store`.

This is a large dependency set — BEE is the centre of a booking system, so expect
to pull in and configure several modules, not just one.

## Install with Composer

From the project root:

```bash
composer require drupal/bee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
BAT, Office Hours and Commerce dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bee -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bee -y
```

Drupal will enable the BAT, Office Hours and Commerce dependencies alongside it.

## Submodule

- **`bee_webform`** — integrates BEE bookings with Webform. Enable it only if you
  need that integration:

  ```bash
  drush en bee_webform -y
  ```

After enabling, set the permissions, mark a content type bookable, and (for paid
bookings) configure Commerce as described in the
[overview](../index.md#how-to-use-it).
