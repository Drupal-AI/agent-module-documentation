# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).

There are no module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/check_username -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/check_username -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en check_username -y
```

Once enabled, the live availability check is attached to the registration form and
the user create/edit forms automatically.

## Verify it worked

Open the user registration page and start typing a username that already exists.
After the configured delay, you should see immediate feedback that the name is
taken. Adjust the delay on the [Configuration](../configuration/index.md) page if
needed.

## A note before going live

The availability endpoint (`/check-username`) is reachable anonymously and reveals
whether a given username exists, with no rate limiting — enabling bulk username
enumeration. If that matters for your site, consider hardening it (stronger
permission, flood control, or a non‑revealing anonymous response) before relying on
this in production. See the [overview](../index.md) for details.
