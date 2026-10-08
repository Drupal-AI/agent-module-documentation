# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Node** module (`node`) — the only dependency, enabled automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/conditional_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conditional_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conditional_message -y
```

After enabling, review the module's permissions under **People → Permissions** —
you can grant *view / add / edit / delete conditional message* rights to editors
separately from full administration.

## Verify it worked

Go to **Content → Conditional message** (`/admin/content/conditional-message`).
You should see the message overview listing, ready for you to create your first
message (see [Configuration](../configuration/index.md)).
