# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). Nothing else.
- No third‑party libraries. (Older versions needed the Browscap module to work
  out the browser and OS — that is no longer the case, and Browscap is **not**
  required.)

## Install with Composer

From the project root:

```bash
composer require drupal/jserror -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jserror -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jserror -y
```

Then visit **Configuration → Development → JSerror** to review the settings before
leaving it running on a live site — see [Configuration](../configuration/index.md).

## Permissions

Two permissions control access, set at **People → Permissions**:

- **View site reports** — read the error report at **Reports → Recent JavaScript
  errors**.
- **Administer JSerror** — change the settings or clear the log.

Because the report contains information about real visitors, grant **View site
reports** only to roles that should see it.

## A note on strict Content Security Policies

JSerror relies on an inline script running before everything else on the page, and
that script carries no CSP nonce. On a site that enforces a strict Content
Security Policy which does not permit inline scripts, the script won't run and the
module will quietly do nothing. If you enforce a strict CSP, you'll need to
accommodate that inline script for JSerror to work.

## Verify it worked

Trigger a JavaScript error on the front end (for example on a test page), then go
to **Reports → Recent JavaScript errors**. The error should appear as a grouped
row with an occurrence count. Open the row to see the individual occurrences, with
the affected pages, browsers, and platforms.
