# Installation

## Requirements

Block Region Permissions is dependency‑free beyond core. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is where the Block layout page
  and the "Administer blocks" permission come from. Drupal enables it as a
  dependency automatically.

There are no third‑party Composer or PHP library requirements. The module is
recommended alongside — but does not require —
[Block Content Permissions](https://www.drupal.org/project/block_content_permissions).

## Install with Composer

From the project root:

```bash
composer require drupal/block_region_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_region_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_region_permissions -y
```

Or enable **Block Region Permissions** from **Extend**
(`/admin/modules`).

## Next steps

Enabling the module does nothing visible until you grant the new per‑region
permissions. Head to **People → Permissions** and assign the
"Administer: *Theme* - *Region*" permissions (plus core "Administer blocks") to
the roles that should manage particular regions — see
[How to use it](../index.md#how-to-use-it) on the overview page.
