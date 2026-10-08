# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **User** module (`user`), which is part of a standard Drupal install.
- No third-party Composer or PHP library requirements.

Optionally, two plugin modules improve how session details are shown — a
**BrowserDetector** browser formatter and a **Geocoder** hostname formatter. Install
either if you want friendlier browser names or location lookups; neither is
required.

## Install with Composer

From the project root:

```bash
composer require drupal/session_inspector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/session_inspector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en session_inspector -y
```

## Grant the permissions

The feature is off for users until you grant a permission. Go to
**People → Permissions** (`/admin/people/permissions`) and set:

- **inspect own users sessions** — grant to any role whose users should be able to
  view and terminate their own sessions. This is the main, safe permission to hand
  out.
- **inspect other user sessions** — grant only to trusted administrative roles who
  need to view *other* users' sessions. Use this sparingly.

## Verify it worked

Log in as a user in a role that has **inspect own users sessions**, open their user
profile, and look for the **Sessions** tab (also at `/user/[uid]/sessions`). It
should list the current sessions and let the user delete any of them.
