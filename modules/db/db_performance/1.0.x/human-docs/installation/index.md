# Installation

## Requirements

DB Performance is self-contained:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A standard database driver — **MySQL, MariaDB, or PostgreSQL**.

There are no other module dependencies and no third‑party Composer or PHP library
requirements. Devel and Webprofiler are optional companions for broader debugging,
but they are not needed.

## Install with Composer

From the project root:

```bash
composer require drupal/db_performance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_performance -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en db_performance -y
```

Collection begins immediately. Remember that the report only becomes useful after
the site has served real traffic, so give it time before analysing.

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`), assign these to trusted
administrator roles only:

- **Access DB Performance reports** (`access db performance reports`) — view the
  slow-query report.
- **Manage DB Performance indexes** (`manage db performance indexes`) — create the
  suggested indexes (this changes your database schema).

## Verify it worked

Use the site for a while, then log in as an administrator and go to **Reports → DB
Performance** (`/admin/reports/db-performance`). You should see collected queries
with call counts and timing statistics. If the report is empty, the site simply
hasn't generated enough slow-query data yet — keep using it and check again.
