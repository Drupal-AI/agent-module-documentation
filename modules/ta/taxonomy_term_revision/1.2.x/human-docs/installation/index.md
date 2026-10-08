# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **System** (8.8 or newer) and **Taxonomy** (`taxonomy`) modules —
  Taxonomy is the obvious one, and it must be enabled.
- For the content moderation feature, core's **Content Moderation** module and a
  workflow that targets taxonomy terms (only needed if you want moderated terms).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_revision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_revision -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_revision -y
```

From this point on, **every taxonomy term save creates a new revision** — there
is no configuration step to switch that on, and no per-vocabulary opt-out.

## Grant the permissions

The revision operations are gated by four permissions. Assign them to your
editorial roles at **People → Permissions**
(`/admin/people/permissions`), or from the command line:

```bash
drush role:perm:add content_editor 'view term revision list'
drush role:perm:add content_editor 'revert term revision'
```

Keep **Delete term revision** (and usually **Revert term revision**) restricted to
trusted roles. There are no submodules.
