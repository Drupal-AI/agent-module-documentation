# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1** or later.
- Core modules **Node**, **Field** and **User** (enabled automatically as
  dependencies).
- **Drush** — the module is a suite of Drush commands.
- Some features need extra core modules: translation commands require **Language**
  and **Content Translation**; moderation commands require **Content Moderation**.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_webmaster -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drush_webmaster -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_webmaster -y
```

Because these commands can make real, destructive structural changes to a site,
be deliberate about *where* you enable this — favour local, dev and staging
environments, and treat production use with care.

## Permissions

Drush Webmaster defines its own permissions. Review them and grant them to the
appropriate roles at **People → Permissions** (`/admin/people/permissions`).
Remember that Drush/CLI is already a privileged context, so the practical guard
on these commands is who can run Drush on the environment.

## Verify it worked

List the module's commands:

```bash
drush list wm
```

You should see the `wm:*` commands (schema discovery, entity query, views,
menus, and so on). A quick, read-only check is `drush wm:schema:dump`, which
prints the site's schema as structured YAML.
