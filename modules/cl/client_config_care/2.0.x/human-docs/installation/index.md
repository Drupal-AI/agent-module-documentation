# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Config Filter** module (`config_filter`) — this is a hard dependency,
  because the "stick" behaviour is implemented as a Config Filter plugin. Composer
  will pull it in automatically.
- A **Drush-based config workflow** — the module is designed to be used with
  `drush config:import` for deployments.

There are no third‑party PHP library requirements beyond that.

## Install with Composer

From the project root:

```bash
composer require drupal/client_config_care -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Config Filter if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/client_config_care -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en client_config_care -y
```

## Grant the permissions

Client Config Care adds a set of permissions covering the config blocker entities —
add, edit, delete, view (published and unpublished), and manage revisions — plus an
**administer** permission that is flagged as *restrict access* (grant it only to
trusted, technical roles). Assign these under **People → Permissions** according to
who should review and manage the tracked blockers.

## Turn it off on local/dev environments

You usually want protection **off** on local development, where you *do* want config
imports to apply cleanly. Add this to your `settings.local.php` to deactivate it
there:

```php
$settings['client_config_care'] = [
  'deactivated' => TRUE,
];
```

With this set, the module records no blocker entities and blocks nothing.

## Verify it worked

With the module enabled (and not deactivated), change a piece of config through the
admin UI — for example the site name at **Configuration → System → Basic site
settings** (`/admin/config/system/site-information`) — and save. Then visit
**Structure → Config blocker entities** (`/admin/structure/config_blocker_entity`).
You should see a new config blocker entity for the item you just changed. You can
also confirm protection is active from the command line with
`drush client_config_care:is_activated`.
