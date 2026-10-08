# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Domain** (`domain`) — the Domain Access module, which provides the domain
  records this module scopes entity types against.
- No separate PHP library requirements.

> **Release note:** at the documented version this module is a release candidate
> (1.0.0-rc2). Test it on non-production first if you are deploying to a live site.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_entity_type -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Domain module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_entity_type -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_entity_type -y
```

Make sure the Domain module is set up with your domains created first.

## Grant the permissions

The module provides its own permissions. Go to **People → Permissions**
(`/admin/people/permissions`) and grant them to the roles that should manage
per-domain entity-type access.

## Verify it worked

With the Domain module configured and the permissions granted, confirm that
entity-type listings and menus are scoped by domain as you expect. Because this
governs listings and menus rather than individual content items, verify it
composes correctly with your existing Domain Access node-grant configuration.
