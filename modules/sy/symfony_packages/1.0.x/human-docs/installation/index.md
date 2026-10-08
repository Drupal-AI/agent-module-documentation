# Installation

## Requirements

Symfony Packages needs:

- **Drupal 11** (`core_version_requirement: ^11`).
- A **Composer-managed** Drupal installation — the module reads package
  information via Composer, so it needs a site that was built and is maintained
  with Composer.
- Core's **System** module (`system`), which is always present.

There are no additional third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_packages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_packages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_packages -y
```

## Verify it worked

After enabling, grant the **`view symfony packages`** permission to an
appropriate role at **People → Permissions** (`/admin/people/permissions`), then
open the Symfony Packages report as a user who holds that permission. You should
see the list of installed Symfony components with their current versions and any
available updates.
