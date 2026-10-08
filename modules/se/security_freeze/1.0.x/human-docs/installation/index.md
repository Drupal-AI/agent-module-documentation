# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`).
- No other modules or PHP libraries are required — the module deliberately has no
  dependency on any other module, including for its Content-Security-Policy handling.
- **SSH access** to the server, since the module is operated entirely through Drush
  (there is no web UI).
- The module provides its own permission.

**Infrastructure prerequisites for a working freeze** (the module blocks writes at the
application layer, but these are the real guarantees):

- **Cache, lock, and flood must be off the database** — use Redis, Memcached, or
  another external backend. If they stay on the database, the first cache miss against a
  read-only database will crash the site. The `freeze:on` command runs a preflight
  check and warns you if any are still database-backed.
- **The database server must be set to read-only** — after arming the freeze, set
  `read_only = ON` (and `super_read_only = ON` on MySQL/Aurora). This is the
  un-bypassable backstop.
- **Optionally, mount the application codebase read-only** to stop raw file changes.

## Install with Composer

From the project root:

```bash
composer require drupal/security_freeze -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (This is currently an alpha release — review it before relying
on it in production.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/security_freeze -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en security_freeze -y
```

Enabling the module changes nothing on its own — it stays **dormant** until you arm it.

## Arm, check, and lift the freeze

All over SSH:

```bash
drush freeze:on       # arm the read-only lockdown (heed the preflight warnings)
drush freeze:status   # report whether the site is currently frozen
drush freeze:off      # lift the lockdown
```

After `freeze:on`, set your database server to read-only (see Requirements). After
`freeze:off`, return the database server to read-write.

## Verify it worked

With the freeze armed, confirm that: public pages still load; attempting to log in
(even as user 1) is refused; and API/write attempts return clean **403** responses
rather than 500 errors. Run `drush freeze:status` to confirm the current state.
