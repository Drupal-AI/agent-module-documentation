# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Two contributed modules from the **Entity Reference Integrity** project, which do
  the actual "what references what" bookkeeping:
  - **Entity Reference Integrity** (`entity_reference_integrity`)
  - **Entity Reference Integrity Enforce** (`entity_reference_integrity_enforce`)

Install those first (or let Composer pull them in), because the protection logic
delegates to them.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_entity_unpublished -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
Entity Reference Integrity dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevent_entity_unpublished -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Note that the **machine name differs from the project name** — the project
directory is `prevent_entity_unpublished`, but the module you enable is
`prevent_entity_unpublish` (no trailing *ed*):

```bash
drush en entity_reference_integrity entity_reference_integrity_enforce prevent_entity_unpublish -y
```

## Verify it worked

After enabling, go to **Configuration → Content authoring → Prevent entity
unpublish** (`/admin/config/content/prevent-entity-unpublish`) and tick at least
one entity type to protect — see [Configuration](../configuration/index.md). Then
try to unpublish a node (or term/user) that you know is referenced elsewhere: the
save should be blocked with a message listing the referencing entities.
