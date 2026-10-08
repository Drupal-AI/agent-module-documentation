# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — this is the module's dependency,
  and Drupal enables it automatically.

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_replace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/taxonomy_term_replace -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_replace -y
```

## Grant access to the dashboard

The dashboard is protected by a single permission,
**`access Taxonomy Term Replace dashboard`**. Because the tool bulk-changes content,
grant it only to trusted roles. Via the UI, go to **People → Permissions**
(`/admin/people/permissions`) and enable it for the desired roles; or with Drush:

```bash
drush role:perm:add editor 'access Taxonomy Term Replace dashboard'
```

Once granted, the dashboard is available at
`/admin/structure/taxonomy/taxonomy-term-replace` (linked from the taxonomy
vocabulary list). See [the overview](../index.md#how-to-use-it) for the workflow.
