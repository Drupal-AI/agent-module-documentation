# Installation

> **Before you install:** review the [main guide](../index.md) and evaluate the
> login flow against your site's authentication requirements on a non‑production
> site first.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** module (`user`) — enabled on every standard Drupal site, and
  pulled in automatically as a dependency.
- A working outbound **mail setup**, since the login code is delivered by email.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/email_otp_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_otp_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_otp_login -y
```

## Make the login reachable

The module does not add a menu link of its own. To let users start the flow, add
a link to `/otp-email` — for example a custom menu item under **Structure →
Menus** — or link to it from a login block or page.

## Verify it worked

Visit `/otp-email` as an anonymous visitor. You should see a form asking for a
registered email address. Test the full request‑and‑validate flow on a
non‑production site before exposing it to real users.
