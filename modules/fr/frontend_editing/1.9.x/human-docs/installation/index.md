# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Paragraphs Edit** module (`drupal/paragraphs_edit` `^3.0`) — a hard
  dependency that provides the access-checked paragraph operations. Composer
  installs it automatically (and it in turn requires the Paragraphs module).

The **All Entity Preview** module (`drupal/all_entity_preview`) is an optional
suggestion — it lets editors preview unsaved entities in the sidebar, but is not
required.

## Install with Composer

From the project root:

```bash
composer require drupal/frontend_editing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`paragraphs_edit` dependency alongside it and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontend_editing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontend_editing -y
```

This enables Frontend Editing together with its `paragraphs_edit` dependency.

## Grant the permissions

Frontend Editing defines five permissions. At minimum, editors need **Access
frontend editing**; to work with Paragraphs they also need the add/move/delete
permissions:

```bash
drush role:perm:add editor 'access frontend editing'
drush role:perm:add editor 'move paragraphs'
drush role:perm:add editor 'add paragraphs'
drush role:perm:add editor 'delete paragraphs'
```

Give site builders/administrators **Administer frontend editing** as well, so they
can reach the settings forms. Next, choose which bundles are editable and tune the
UI — see [Configuration](../configuration/index.md).
