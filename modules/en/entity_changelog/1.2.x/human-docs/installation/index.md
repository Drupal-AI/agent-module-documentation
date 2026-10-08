# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **PHP 8.1** or newer (required from version 1.1.0 onward).
- Core **Views** module (`views`) — enabled automatically as a dependency; it powers
  the changelog display.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_changelog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_changelog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_changelog -y
```

Core Views is enabled automatically if it is not already on. Logging of entity
create/update/delete operations begins immediately — there is no configuration step.

## Grant the viewing permission

The changelog can hold sensitive detail about content and editors, so gate it. Under
**People → Permissions** (`/admin/people/permissions`), grant the module's changelog
viewing permission to trusted administrator roles only.

## Verify it worked

Create or edit a piece of content, then open the changelog View. You should see a new
log entry recording the operation, the entity, when it happened, and which user made
the change.
