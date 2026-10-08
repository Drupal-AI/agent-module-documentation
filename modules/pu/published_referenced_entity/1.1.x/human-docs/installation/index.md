# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — part of a standard install and the only
  dependency.

There are no third‑party Composer or PHP library requirements. Note this module
has *not-covered* security advisory coverage, and it is a display filter rather
than an access‑control mechanism — see the caveat on the
[overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/published_referenced_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/published_referenced_entity -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en published_referenced_entity -y
```

## Verify it worked

Go to the **Manage display** page of a content type that has an entity reference
field (**Structure → Content types → *(your type)* → Manage display**). In that
field's **Format** dropdown you should now see **Published Entity ID**,
**Published Entity Label**, and **Published Rendered Entity**. Pick one, save,
and confirm that unpublished referenced items no longer render on the entity's
display.
