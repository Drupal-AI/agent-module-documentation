# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`). The Composer
  package additionally accepts core `^10.3 || ^11 || ^12`, so on the 2.0.x branch
  you need a reasonably recent Drupal.
- Core's **Taxonomy** (`taxonomy`) module — Drupal enables it automatically as a
  dependency.
- The Tagify JavaScript library ships with the module; there is no separate
  library download to manage.

## Install with Composer

From the project root:

```bash
composer require drupal/tagify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tagify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tagify -y
```

## Submodules — enable only what you need

Tagify ships four optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Tagify Facets** | `tagify_facets` | A Facets widget that renders facet values as clickable tags. |
| **Tagify Icons** | `tagify_icons` | An icon picker for UI Icons fields. |
| **Tagify Iconify Icons** | `tagify_iconify_icons` | An icon picker backed by the Iconify library. |
| **Tagify User List** | `tagify_user_list` | A user‑picker widget that shows avatars beside each suggestion. |

For example:

```bash
drush en tagify_user_list -y
```

Each submodule requires the base Tagify module, which is already present once you
have installed it above.

## Next steps

With the module enabled, head to any entity‑reference field's **Manage form
display** tab and switch its widget to Tagify — see
[Configuration](../configuration/index.md) for the per‑field options.
