# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer**.
- **MariaDB 10.11+** (SQLite support is planned for a future version).
- Core modules **Link**, **Image**, **Taxonomy**, **Text**, and **Views** —
  enabled automatically as dependencies.

Recommended (optional) companions:

- **Pathauto** — auto-generate clean URLs for your stashed links.
- **Views Bulk Operations** — bulk-manage stashes.
- **Better Exposed Filters** — nicer filtering on the main list view.

> **Beta / not security-covered:** at the documented version LinkStash is a beta
> release and is **not covered** by Drupal's security advisory policy. Test it
> before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/linkstash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkstash -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkstash -y
drush cr
```

## Grant permissions

LinkStash is per-user, so grant its permissions to the roles that should be able
to keep bookmarks (typically authenticated users). Go to **People → Permissions**
(`/admin/people/permissions`) and enable:

- **create linkstash**
- **view own linkstash**
- **edit own linkstash**
- **delete own linkstash**

## Verify it worked

Log in as a user with the permissions above and visit `/linkstash/add`. Save a
public URL and confirm LinkStash fetches its title, description, and thumbnail,
then check that it appears in your collection at `/linkstash`. Nothing more is
required for basic use — see [Configuration](../configuration/index.md) for
optional tuning.
