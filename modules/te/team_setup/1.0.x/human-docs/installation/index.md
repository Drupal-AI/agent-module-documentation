# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11`, and the
  project supports Drupal 12).
- Drupal core only — no contributed modules or external libraries are required.

The module uses core's Form API, Database API, routing system, permissions system,
AJAX framework and library system, all of which ship with Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/team_setup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/team_setup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en team_setup -y
```

## Assign permissions (required first step)

Team Setup does the real work through permissions, so this is the one thing you
must do after enabling it. Go to **People → Permissions**, find the Team Setup
permissions, and grant them to the appropriate roles. The module separates
*accessing* team setup from *administering* it — give full management access only
to trusted administrative roles.

## Verify it worked

With the permissions assigned, open the team setup listing page. You should be
able to add a new team, enter its name and description, and assign users as members
using autocomplete.
