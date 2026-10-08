# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Nothing else — there are no module dependencies and no third‑party Composer or PHP libraries.
  CORS UI simply provides a UI for core's existing CORS middleware.

## Install with Composer

From the project root:

```bash
composer require drupal/cors_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/cors_ui -W`, `ddev drush …`. Inside the container (`ddev ssh`)
> run them without the prefix.

## Enable the module

```bash
drush en cors_ui -y
```

On install the module seeds its `cors_ui.configuration` object from the site's *current*
`cors.config` parameter (from `services.yml`), normalized to match its schema — so enabling it
**does not change your existing CORS behaviour**. From that point on, the admin form is the place
to make changes.

## Grant the permission

The module adds one permission, **`administer cors`**, marked *restrict access*. Grant it only to
trusted administrators at **People → Permissions** — it exposes core's own CORS policy, which is a
security-sensitive setting (see [Configuration](../configuration/index.md)).

There are no submodules and no Drush commands.
