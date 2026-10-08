# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Feeds** module (`drupal/feeds` `^3.0`).
- The **Tamper** module (`drupal/tamper` `^1.0-alpha3`) — this supplies the
  actual transformation plugins.

Both Feeds and Tamper are hard dependencies; Feeds Tamper only makes sense with
them present. There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Feeds and Tamper along with
it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/feeds_tamper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Feeds Tamper together with its dependencies (Drush will pull them in
automatically, but you can list them explicitly):

```bash
drush en feeds_tamper -y
```

## Grant permissions

Feeds Tamper adds two kinds of permission:

- **Administer feeds_tamper** — a global permission to manage tampers on any feed
  type.
- **Tamper *(feed type)*** — a per‑feed‑type permission generated for each feed
  type, so you can let an editor tamper just one specific feed.

Grant these at **People → Permissions** (`/admin/people/permissions`) to the
roles that should manage feed transformations.

## Submodules

Feeds Tamper ships no submodules.
