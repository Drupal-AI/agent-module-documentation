# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- Core's **Node** (`node`) and **Taxonomy** (`taxonomy`) modules enabled — both
  ship with Drupal core, and Drupal enables them automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_term -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_term -y
```

## Permissions

The module provides a **Filter vocabulary and terms** permission. Assign it under
**People → Permissions** (`/admin/people/permissions`) to the roles that should be
able to use the filter form. Note that the results page itself (`/allcontent`) is
reachable by anyone with the core **Access content** permission — see the note in
the [main guide](../index.md#a-note-on-visibility).

## Verify it worked

Visit `/admin/config/filter_term/vocab`. You should see the filter form with a
vocabulary selector. Choose a vocabulary and submit — you should land on
`/allcontent` with a table of matching nodes. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough.
