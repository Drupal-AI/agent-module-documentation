# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other modules, PHP libraries, or third-party services are required.

The module adds no permissions and no settings — it simply changes the reset form's
behaviour once enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/secure_password_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (This release line is currently a release candidate; if
Composer will not resolve it on your site, you can request the beta explicitly, e.g.
`composer require 'drupal/secure_password_reset:^1.0@beta'`, as noted on the project
page.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/secure_password_reset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en secure_password_reset -y
```

You can also enable it from **Extend** (`/admin/modules`). That is all there is to it —
the reset form now gives the same message for both valid and invalid usernames.

## Verify it worked

Go to `/user/password`, submit a username or email that does **not** exist on the site,
and confirm the response is a neutral "check your email" style message rather than an
error revealing that no such account exists.
