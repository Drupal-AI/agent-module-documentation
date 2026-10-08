# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

This module requires only Drupal core — there are no other module dependencies,
Composer packages, or external libraries to install.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/json_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/json_viewer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_viewer -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Two quick checks:

- Go to a content type's **Manage display** (for example
  **Structure → Content types → Article → Manage display**). On a text, file, or
  entity-reference field, the format dropdown should now offer a **JSON Viewer**
  option.
- Add the **JSON Previewer** block from **Block layout**
  (`/admin/structure/block`) and confirm the editor-plus-preview panel appears.

If JSON isn't rendering later on, the most common cause is invalid JSON, or (for
the file and media viewers) a file whose MIME type isn't `application/json`. If
styles look off, clear the cache with `drush cr`.
