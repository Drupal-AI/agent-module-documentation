# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **User** module (`user`), always present on a Drupal site.
- A **properly configured email system** — the whole login flow depends on
  outbound email reaching users, ideally over a TLS‑secured mail transport.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dripyard_simple_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dripyard_simple_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dripyard_simple_login -y
```

Enabling the module immediately alters the login routes: the login form moves to
`/login`, direct access to the standard password‑reset form is blocked, and the
one‑time‑login route uses the module's simplified messaging.

## Complete the required setup step

Enabling the module is not enough on its own — you **must** update core's
**Password recovery** email template so it reads as a login link, because that is
the email used to deliver magic links. See "How to use it → Required: update the
password‑recovery email template" in the [overview](../index.md).

## Verify it worked

1. Make sure your site can actually send email (test with a password‑reset or a
   `drush` mail test), since the login flow depends on it.
2. Log out and visit **`/login`** — you should see the magic‑link form asking for
   an email address rather than a password field.
3. Enter a real account's email, open the resulting message, and confirm the
   one‑time link logs you in.
