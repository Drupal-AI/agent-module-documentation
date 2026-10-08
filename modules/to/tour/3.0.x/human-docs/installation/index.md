# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`). This contrib
  Tour module is meant for the Drupal versions where core's own Tour module has
  been removed.
- **JavaScript enabled** in the browser — the tours are rendered with the
  Shepherd.js library, so a user needs JavaScript on to see them.

There are no other module dependencies and no third‑party Composer or PHP library
requirements. Two optional related projects are suggested for specific needs:
`drupal/tour_core` and `drupal/tour_core_language`.

## Install with Composer

From the project root:

```bash
composer require drupal/tour -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tour -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tour -y
```

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`):

- **Access tour** — lets a user see and run tours (the toolbar button, the tour
  block, the Navigation top‑bar item, and the recap page).
- **Administer tour** — lets a user create, edit, clone, delete and enable/disable
  tours and tips, and change the global settings. This is an administrative
  permission; grant it only to trusted users.

For example:

```bash
drush role:perm:add editor 'access tour'
drush role:perm:add site_manager 'administer tour'
```

## Optional submodule — tourauto

The module bundles one submodule, **tourauto** (`tourauto`), which automatically
opens a tour for users who have not seen it yet. Enable it only if you want that
behaviour — it adds no new permissions and reuses *Access tour*:

```bash
drush en tourauto -y
```

## Verify it worked

Visit **Configuration → User interface → Tours** — the tour list page should load.
Create a simple tour on a page you can reach, then visit that page as a user with
*Access tour* and confirm the **Tour** button appears and runs the walkthrough.
