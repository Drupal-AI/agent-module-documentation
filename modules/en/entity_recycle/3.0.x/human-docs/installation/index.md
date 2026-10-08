# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Node** module (`node`) — the only dependency, and part of a standard
  Drupal install.
- No third‑party Composer or PHP library requirements.

> **Version note:** the 3.0.x branch is an alpha release
> (`3.0.0-alpha1`) under active development — test it before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_recycle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_recycle -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_recycle -y
```

## Verify it worked

Log in as an administrator and delete a piece of test content. Instead of
disappearing permanently, it should move to the recycle bin. Open the
**Content Recycle Bin** listing (as a user with the **view entity recycle bin**
permission) and confirm the item is there and can be restored. Then review the
recycle‑bin permissions and behaviour on the
[Configuration](../configuration/index.md) page.
