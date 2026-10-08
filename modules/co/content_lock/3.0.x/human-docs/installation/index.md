# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other module dependencies — Content Lock needs only Drupal core.
- **Optional:** the **Conflict** module (`drupal/conflict`) if you want to lock at
  the translation level (so different users can edit different translations of
  the same content at the same time).

## Install with Composer

From the project root:

```bash
composer require drupal/content_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_lock -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_lock -y
```

After enabling, open **Configuration → Content authoring → Content lock** to
choose which entity types and bundles are lockable — see
[Configuration](../configuration/index.md). Nothing is locked until you enable it
there.

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Content Lock Timeout** | `content_lock_timeout` | Automatically releases forgotten locks once they pass the configured timeout. **Note:** this submodule is deprecated in the 3.0.x branch — timeout handling is being folded into the main module. |

Enable it only if you need automatic stale‑lock release:

```bash
drush en content_lock_timeout -y
```
