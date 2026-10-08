# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Comment** module (`comment`), which Drupal enables automatically as a
  dependency.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_comment_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bulk_comment_delete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_comment_delete -y
```

## Set the permission

At **People → Permissions**, grant **administer bulk commnet delete** (note the
misspelling of "comment") to the roles allowed to run bulk comment deletions.
Then use the tool at `/admin/content/bulk-comments` — see
[How to use it](../index.md#how-to-use-it).
