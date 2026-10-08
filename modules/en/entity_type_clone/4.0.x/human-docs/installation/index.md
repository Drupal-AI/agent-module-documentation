# Installation

## Requirements

Entity Type Clone needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block content** (`block_content`), **Node** (`node`) and **Taxonomy**
  (`taxonomy`) modules enabled — Drupal turns these on as dependencies.

There are no third-party Composer or PHP library requirements. Paragraph, Profile and
Storage types additionally become clonable when the **Paragraphs**, **Profile** or
**Storage** modules are installed, respectively.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_type_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_type_clone -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_type_clone -y
```

## Grant the permission

Both clone forms (and the *Clone* operation links) are gated by the **Access Entity Type
Clone** (`access entity type clone`) permission. Grant it to a trusted role at
**People → Permissions** (`/admin/people/permissions`), or with Drush:

```bash
drush role:perm:add site_manager 'access entity type clone'
```

> **Treat this as an administrative permission.** Anyone who holds it can create arbitrary
> bundles and — through the role-clone form — mint a role holding any permission an existing
> role holds, including *administer permissions*. Grant it only to trusted administrators.

## Next step

See [Configuration](../configuration/index.md) for a walk-through of both clone forms.
