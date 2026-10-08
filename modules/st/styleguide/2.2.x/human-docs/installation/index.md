# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

That's it — Style guide has **no module dependencies**, no third-party Composer
libraries, and no PHP extension requirements. It's a developer/theming tool, so
you'd typically enable it only on development or staging environments, or restrict
it by permission on production.

## Install with Composer

From the project root:

```bash
composer require drupal/styleguide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/styleguide -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en styleguide -y
```

No submodules ship with this project.

## Grant the permission

Access to every style guide page is controlled by a single permission:

- **View style guides** (`view style guides`) — grants access to
  `/admin/appearance/styleguide`, the maintenance-page previews, and every
  per-theme route. It's *not* marked restricted, because the pages only show themed
  sample markup, not real data — but you'll still want to grant it deliberately to
  your front-end developer / themer roles.

Assign it at **People → Permissions** (`/admin/people/permissions`), or in code:

```php
use Drupal\user\Entity\Role;
$role = Role::load('developer');
$role->grantPermission('view style guides')->save();
```

There are no other permissions — the module performs no data-changing operations.

## Verify it worked

As a user with the permission, visit **Appearance → Style guide**
(`/admin/appearance/styleguide`). You should see a page full of themed sample
elements, with a tab for each enabled theme. If a newly enabled theme's tab is
missing, run `drush cr` to rebuild the router.
