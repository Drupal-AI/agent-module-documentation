# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_nid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_nid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_nid -y
```

There is no configuration to do — the module has no settings form.

## Grant the permission

The custom‑ID field only appears for users who hold the **`custom_nid access`**
permission, which is marked *restricted*. At **People → Permissions**, grant it only to
a trusted migration or administrator role, and plan to revoke it once the task is done.

## Verify it worked

As a user who holds `custom_nid access`, go to **Content → Add content** and begin
creating a node. You should see a field for entering the node's ID. Enter an unused ID
and save; entering one that already exists produces a "Nid already exists" message.
