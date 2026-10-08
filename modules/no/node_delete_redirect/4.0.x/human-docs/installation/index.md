# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Node** module (`node`) — the only dependency.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_delete_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_delete_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_delete_redirect -y
```

## Verify it worked

First make sure the roles that should manage this hold the **Administer content
types** permission (**People → Permissions**, `/admin/people/permissions`). Then
visit **Configuration → Content authoring → Node Delete Settings**
(`/admin/config/content/node-delete-settings`) — you should see the per‑content‑type
options. Continue to [Configuration](../configuration/index.md) to set a redirect.
