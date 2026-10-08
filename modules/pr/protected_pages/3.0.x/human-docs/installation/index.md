# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Path Alias** module (`path_alias`), enabled automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/protected_pages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_pages -y
```

The module ships **no submodules**.

## Set permissions

Two permissions matter here. Go to **People → Permissions**
(`/admin/people/permissions#module-protected_pages`) and grant:

- **Administer protected pages configuration** — to the roles that should manage
  protected paths and settings (typically administrators).
- **Bypass protected pages** — to any roles that should be able to view protected
  pages *without* entering a password.

## Verify it worked

Log in as an administrator and go to **Configuration → System → Protected Pages**
(`/admin/config/system/protected_pages`). You should see the (empty) list of
protected pages with an **Add protected page** link. Add a test path, then visit
that path as an anonymous user — you should be redirected to the password prompt
at `/protected-page`. See [Configuration](../configuration/index.md) for the full
walkthrough.
