# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Views** module (`views`) — it ships with core and is enabled
  automatically as a dependency; notes are displayed through Views.
- No third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_notes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_notes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_notes -y
```

Drupal enables Views at the same time if it isn't already on.

## Verify it worked

Go to **People → Permissions** and confirm the Entity Notes permissions are
present, then grant them to an appropriate role. Attach a note to an entity (for
example a user account or a node) and confirm it appears against that entity.

> **Reminder:** if you edit the Entity Note views, keep the three required
> contextual filters — *Note: Entity Type*, *Note: Bundle*, *Note: Entity ID* — in
> place and in that order, or notes won't display correctly.
