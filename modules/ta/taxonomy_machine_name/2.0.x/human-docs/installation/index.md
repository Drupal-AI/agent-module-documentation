# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — Drupal turns it on
  automatically as a dependency if it isn't already.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_machine_name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_machine_name -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_machine_name -y
```

When it installs, the module adds the `machine_name` field to taxonomy terms and
backfills a machine name for every term you already have, in batches. There is no
configuration form to visit.

## Grant the overview-page permission

The **Machine name** column on the vocabulary overview page is hidden until you
grant the **view machine name overview page** permission. Do this under
**People → Permissions**, or from the command line:

```bash
drush role:perm:add content_editor 'view machine name overview page'
```

## Optional submodule

Taxonomy Machine Name ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Taxonomy Machine Name** | `search_api_taxonomy_machine_name` | Integration so the term machine name is available to Search API. Enable it only if you index taxonomy terms with Search API. |

Enable it the same way when you need it:

```bash
drush en search_api_taxonomy_machine_name -y
```
