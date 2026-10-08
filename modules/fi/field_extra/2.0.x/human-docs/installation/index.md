# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The private‑field feature only applies to entity types that are **fieldable and
  have an owner** — for example Node, Media, Comment, Paragraph, Group, and
  Commerce Product. Entity types without an owner field cannot participate.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_extra -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_extra -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Content authoring →
Private settings** (`/admin/config/content/private-settings`). You should see a
form listing the owner‑bearing entity types on your site. Once you enable one and
mark a field as private‑capable (see [Configuration](../configuration/index.md)),
a **Private** checkbox will appear next to that field on the content edit form.
