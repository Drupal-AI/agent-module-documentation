# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **User** module (`user`), which is always present on a standard site.
- No third‑party Composer or PHP libraries.
- Each user needs an authenticator app on a phone or desktop — Google
  Authenticator, Authy, Aegis, 1Password, Duo Mobile, or any RFC 6238–compliant
  app.

## Install with Composer

From the project root:

```bash
composer require drupal/one_time_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/one_time_password -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en one_time_password -y
```

## Verify it worked

Log in as a user and go to **My account → Two‑factor authentication**
(`/user/{user}/two-factor-auth`). You should see a QR code and enrolment fields.
Scan it into an authenticator app, confirm with the generated code, then log out
and back in — you should now be prompted for the rotating six‑digit code. Once
that round trip works, review the [Configuration](../configuration/index.md) page
to decide who must enrol and how lost devices will be recovered.
