# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Checklist API** module (`drupal/checklistapi` `^2.0`) — it provides the
  checklist page, progress tracking, permissions and UI. Composer installs it
  automatically.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_checklist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Checklist API along
with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/seo_checklist -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_checklist -y
```

Drupal enables Checklist API automatically as a dependency. Once enabled, the checklist
is available at **Configuration → Search and metadata → SEO Checklist** — see
[Configuration](../configuration/index.md).

## Submodule — enable only if you want it

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **SEO Checklist Optional Modules** | `seo_checklist_optional_modules` | A convenience submodule that bundles the SEO contrib modules the checklist recommends, so you can pull in the optional toolkit without adding each module by hand. |

```bash
drush en seo_checklist_optional_modules -y
```

It requires the base SEO Checklist module, which is already present once you've
installed it above.
