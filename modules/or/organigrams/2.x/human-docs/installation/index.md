# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (organigrams are built on taxonomy vocabularies).
- **Optional:** the **[Token](https://www.drupal.org/project/token)** and
  **[Token Filter](https://www.drupal.org/project/token_filter)** modules — only
  needed if you want to embed an organigram inside a text field with the
  `[organigrams:{vid}]` token. The page and block displays work without them.

There are no third‑party Composer or PHP library requirements.

> **Development release.** This is a `2.x` dev release (minimum stability: dev). Test
> it on a non‑production environment first and pin the version deliberately.

## Install with Composer

From the project root:

```bash
composer require drupal/organigrams -W
```

To also add the optional token modules for the embed‑in‑text display:

```bash
composer require drupal/token drupal/token_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/organigrams -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en organigrams -y
```

Or enable **Organigrams** from *Extend* (`/admin/modules`). If you installed the
token modules, enable them too:

```bash
drush en token token_filter -y
```

After enabling, grant the organigram permissions (**Create organigrams**, **View
organigrams**, and **Import organigrams**) to the appropriate roles, then create your
first chart from **Structure → Taxonomy → Add organigram** — see
[Configuration](../configuration/index.md).
