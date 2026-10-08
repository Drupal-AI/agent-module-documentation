# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- No third‑party Composer libraries and no other module dependencies — Pagerer
  builds on core's own pager system.

## Install with Composer

From the project root:

```bash
composer require drupal/pagerer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pagerer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagerer -y
```

Once enabled, head to
**Configuration → User interface → Pagerer** to build your first preset — see
[Configuration](../configuration/index.md).

## Submodule — try it out

Pagerer ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Pagerer example** | `pagerer_example` | A demo page at `/pagerer/example` where you can preview and compare the pager styles. Handy while you decide which styles to use; you can leave it disabled in production. |

```bash
drush en pagerer_example -y
```

## Verify it worked

Visit `/admin/config/user-interface/pagerer`. You should see the **Pagerer** pager
preset listing with an **Add pager** action.
