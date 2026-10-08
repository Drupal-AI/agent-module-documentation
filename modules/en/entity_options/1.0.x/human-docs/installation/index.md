# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **FormAlter as Plugin** (`pluginformalter`) — provides the form-alter mechanism
  Entity Options relies on. Composer installs it automatically when you require
  Entity Options.
- No third-party PHP or JavaScript libraries.

> **Heads-up:** this is an **alpha** release and is **not** covered by Drupal's
> security advisory policy. Currently **only the Node entity is supported.**

## Install with Composer

From the project root:

```bash
composer require drupal/entity_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install FormAlter as Plugin
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_options -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_options -y
```

Drupal enables FormAlter as Plugin at the same time if it isn't already on.

## Verify it worked

Confirm the module is enabled (`drush pml --status=enabled | grep entity_options`)
and that its permissions appear on **People → Permissions**. To see it in action a
developer defines an option plugin in a custom module; the option form then appears
on the relevant node edit pages, and the values become available on the entity as
`$entity->entity_options`.
