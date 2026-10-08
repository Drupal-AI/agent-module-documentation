# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **HTTPS across the whole site.** `SameSite=None` requires the `Secure` flag, so
  the cookie is only sent over HTTPS. Do not use this module on a site served over
  plain HTTP.

There are no module dependencies and no third‑party PHP or JavaScript library
requirements. The module decorates core's `SessionManager` and `SessionConfiguration`
services.

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_samesite_support -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_samesite_support -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_samesite_support -y
```

There is no configuration form — the behavior applies to the session cookie
immediately. Before enabling on production, re‑read the security trade‑offs in the
[overview](../index.md): `SameSite=None` removes a CSRF layer from the session
cookie, `Secure`/HTTPS is mandatory, and a legacy duplicate session identifier is
sent on every request.

## Verify it worked

Log in and inspect the response cookies in your browser's developer tools (or with
`curl -I`). You should see the Drupal session cookie carrying `SameSite=None; Secure`,
alongside a legacy duplicate cookie without the `SameSite` attribute. Then confirm
the actual scenario you installed it for — for example, that you stay logged in
inside the cross‑domain iframe that previously logged you out.
