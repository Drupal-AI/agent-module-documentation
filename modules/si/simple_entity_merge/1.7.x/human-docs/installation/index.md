# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib module dependencies and no extra PHP libraries.

Because a merge permanently rewrites references, make sure you have a working
**backup/rollback** process before you use it in earnest — see the note below.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_entity_merge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_entity_merge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_entity_merge -y
```

## Grant permissions

Under **People → Permissions**, assign the module's two permissions — both are
marked security‑sensitive, and rightly so, because merging is a destructive,
site‑wide rewrite of references. Keep them limited to trusted roles:

- **Administer simple_entity_merge** — configure which entity types can be merged.
- **Execute simple_entity_merge** — actually perform a merge.

## After enabling

1. Choose which entity types the merge tool applies to — see
   [Configuration](../configuration/index.md).
2. Before your first real merge, **take a backup** and rehearse on a copy of the
   site if the entity has many references, since a merge cannot be undone.

## Verify it worked

Open an entity of a type you enabled (for example a taxonomy term). It should now
show a **Merge** tab, from which you can select another term of the same type to
merge into.
