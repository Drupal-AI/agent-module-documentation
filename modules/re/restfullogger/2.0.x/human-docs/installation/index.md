# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Database Logging** module (`dblog`) — where the messages are written —
  and core's **RESTful Web Services** module (`rest`). `rest` is a declared
  dependency; make sure `dblog` is enabled too.
- The contributed **REST UI** module (`restui`) is recommended: with it enabled you
  can see and configure the active REST endpoints at **Configuration → Web services →
  REST**.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/restfullogger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add REST UI if you do not already have it:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restfullogger -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restfullogger -y
drush en dblog restui -y
```

## Turn on the resource and grant the permissions

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`) and enable the Watchdog database logger resource
   (the endpoint served at `/dblog/logger`). Set the method to **POST**, choose the
   format(s), and pick an authentication method so the endpoint is not open.
2. Go to **People → Permissions** (`/admin/people/permissions`) and grant, **only to
   a trusted role** used by the integration:
   - **POST log messages**, and
   - **Access POST on the Watchdog database logger resource**.

   Do not grant these to *Anonymous* or *Authenticated user* broadly — a client that
   can post logs can flood or pollute your log.

## Verify it worked

Send an authenticated POST with at least the required fields:

```json
POST https://your-site/dblog/logger
{ "message": "Hello from my integration", "path": "/test" }
```

Then check **Reports → Recent log messages** (`/admin/reports/dblog`) for the entry
(on the `restfullogger` channel unless you set another). If nothing appears, confirm
both permissions are granted to the calling role, the resource is enabled, and the
JSON includes both `message` and `path`.
