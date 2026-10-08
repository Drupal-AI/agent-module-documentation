# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Path alias** (`path_alias`) module — the only dependency, and part of
  core. Drupal enables it automatically as needed.

There are no third‑party Composer or PHP library requirements. The module
includes legacy `.module` hook shims so it also works on core versions before
11.1.

> **Heads up:** this project does not have official security‑advisory coverage.
> The module is small and its access logic is least‑privilege by design, but weigh
> the coverage status before relying on it on a high‑stakes production site.

## Install with Composer

From the project root:

```bash
composer require drupal/path_alias_view_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_alias_view_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_alias_view_access -y
```

## Grant the permission

Enabling the module does nothing on its own until you assign its permission:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Tick **View path alias entities** (`access path_aliases`) for the role that
   should be able to read published aliases.
3. Save permissions.

## Verify it worked

As a user in the granted role, read a **published** path alias — for example via
your JSON:API `path_alias` endpoint — and confirm it comes back. Then confirm an
**unpublished** alias is *not* returned, and that a user without the permission
cannot read aliases. That combination confirms the least‑privilege, view‑only,
published‑only behaviour is working.
