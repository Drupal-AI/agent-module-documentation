# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). There is no Drupal 11
  release of this module.
- No third‑party Composer or PHP library requirements. It works with core's user
  roles and adds no dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_role_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_role_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_role_ui -y
```

There is no configuration form and no extra permission to grant. Once enabled, the
role settings form under **People → Roles** (`/admin/people/roles`) reflects the new
behaviour immediately — the core administrator‑role selector is disabled and the
current `is_admin` roles are shown.
