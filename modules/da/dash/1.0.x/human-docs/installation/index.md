# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **System** module (always present).
- No third‑party PHP or JavaScript library requirements — the React interface is
  bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/dash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dash -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dash -y
```

## After enabling

Grant the Dash permission to the administrators who should see the dashboard,
under **People → Permissions**. Keep it restricted to trusted roles, since the
dashboard surfaces operational and site‑wide information.

## Verify it worked

Log in as a user with the dashboard permission and open the admin dashboard. You
should see the widget grid — content, users, entities, modules, system/status, and
health checks — and be able to click any widget to open its detail view.
