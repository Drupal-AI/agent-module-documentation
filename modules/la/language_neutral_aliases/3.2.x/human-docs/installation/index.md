# Installation

## Requirements

Language Neutral URL Aliases is lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Path alias** module (`path_alias`), which is its only dependency and
  is part of Drupal core. Drupal enables it automatically when you turn this
  module on.

There are no third‑party Composer or PHP library requirements.

This module only makes sense on a **multilingual** site (two or more languages).
On a single‑language site it changes nothing you would notice.

## Install with Composer

From the project root:

```bash
composer require drupal/language_neutral_aliases -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/language_neutral_aliases -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_neutral_aliases -y
```

That is the whole setup. From now on every new alias is stored language‑neutral
and lookups ignore the active language. There is no configuration form.

## Converting an existing site (recommended)

If your site already has language‑specific aliases, they will be hidden but not
removed once the module is enabled. To make them work again as neutral aliases,
bulk‑convert them once:

```sql
UPDATE path_alias SET langcode = 'und' WHERE langcode <> 'und';
```

You can run this through your database client or with
`drush sql:query "UPDATE path_alias SET langcode = 'und' WHERE langcode <> 'und';"`.
Take a database backup first, as with any direct SQL change.

Finally, if you have translatable content, open the field settings for the
**URL alias** field and make sure it is **not** marked translatable.
