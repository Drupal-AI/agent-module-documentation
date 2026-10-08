# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A site that uses content moderation for the content your team will review.

There are no contrib module dependencies and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_team -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_team -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_team -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and confirm the
Moderation Team permissions appear. Grant them to your moderator role, assign
that role to team members, and confirm each moderator sees their own share of the
submission queue. See the [main guide](../index.md) for the setup steps.
