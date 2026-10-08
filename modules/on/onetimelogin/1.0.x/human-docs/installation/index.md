# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- No external dependencies and no third‑party PHP libraries.
- Optional but helpful: **REST UI** (easier REST permission setup) and **Admin
  Toolbar** (nicer admin navigation) if you plan to use the API.

## Install with Composer

From the project root:

```bash
composer require drupal/onetimelogin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onetimelogin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onetimelogin -y
```

## Grant permissions carefully

After enabling, go to **People → Permissions** and grant **`access one-time
login`** only to roles you fully trust. This permission lets a holder generate a
link that logs in *as* another user, so it is effectively an
account‑impersonation capability — treat it accordingly.

## Verify it worked

Log in as a user who holds the permission, open another user's profile, and use
the one‑time‑login contextual link to generate a URL. Confirm the link logs you in
as that user, then revoke it (via the UI, `drush otl:revoke`, or the API) and
confirm it no longer works. Review [Configuration](../configuration/index.md) to
tighten expiry and rate limits before real use.
