# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Token](https://www.drupal.org/project/token)** module (`token`) — a
  required dependency, pulled in automatically by the command below.
- No PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_deep_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
Token dependency alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_deep_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_deep_token -y
```

Enabling this module also enables Token if it isn't already on.

## Verify it worked

In a token‑aware field with an entity context, enter a deep token that follows one
of your entity's reference fields — for example
`[entity-deep-token:field_department:entity:field_school:entity:label]` — and confirm
it resolves to the related entity's value.
