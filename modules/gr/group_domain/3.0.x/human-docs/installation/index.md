# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Group** module (`group`) — Group Domain maps domains onto groups.
- A multi‑domain setup, since the module's purpose is to associate distinct domains
  with distinct groups.

## Install with Composer

From the project root:

```bash
composer require drupal/group_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_domain -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_domain -y
```

Drupal enables the Group dependency automatically if it isn't already on.

## Verify it worked

Map a domain to a group, then browse that domain and confirm the correct group's
content and context are active. Check that the domain surfaces only its group's
content if that is your intended isolation, and confirm Group's own permissions
still apply to member actions.
