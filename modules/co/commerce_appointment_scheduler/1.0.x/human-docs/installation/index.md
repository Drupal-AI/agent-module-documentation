# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drupal Commerce**: `commerce`, `commerce_cart`, `commerce_order`,
  `commerce_product`.
- Drupal core **Datetime** (`datetime`), **Field** (`field`), and **Image**
  (`image`).
- **Optional:** a **Twilio** account if you want store SMS notifications.

There are no other required third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_appointment_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_appointment_scheduler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_appointment_scheduler -y
```

## Assign permissions

On **People → Permissions** (`/admin/people/permissions`), grant:

- **`administer commerce appointment scheduler`** — configure global defaults and
  per‑variation appointment rules. Staff/admin roles only.
- **`view commerce appointment bookings`** — view the upcoming appointments report.

## Optional: Twilio SMS credentials

If you plan to send SMS notifications, your Twilio credentials (account SID, auth
token) are secrets. With DDEV, store them as environment variables:

```bash
ddev dotenv set .ddev/.env --twilio-account-sid=<value> --twilio-auth-token=<value>
ddev restart
```

Reference them from the module's Twilio settings rather than committing raw values.

## A note on security coverage

This project is **not covered by the Drupal security advisory policy**. That
doesn't mean it's unsafe, but you won't get official security advisories for it, so
review it yourself before using it on a production store.

## Verify it worked

Continue to [Configuration](../configuration/index.md) to set your global booking
defaults and enable appointments on a product variation. Then, on the storefront,
open that product and confirm the booking calendar appears in the add‑to‑cart form
and that you can select a date and time.
