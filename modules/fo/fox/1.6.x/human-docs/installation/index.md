# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **Drush**, since Fox is entirely a Drush console. It adds the `fox:console`
  command (alias `fox`).

There are no other Drupal module dependencies and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fox -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fox -y
```

## Grant the permission

Fox provides a permission controlling who may use the console. Grant it at **People
→ Permissions** (`/admin/people/permissions`) to trusted developer/administrator
roles only — the console can create, change, and delete entities in bulk.

## Verify it worked

Open the console:

```bash
drush fox:console
```

You should drop into an interactive Fox prompt. Try a read‑only query such as
`USE node.page` followed by `SELECT nid,title INTO data` to confirm it can reach your
entities, then exit the session. If the command isn't found, confirm the module is
enabled and that you're running a compatible version of Drush.
