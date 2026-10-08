# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

There are no module dependencies and no third‑party PHP libraries. This is a
development / content aid, usually enabled on build and staging sites.

## Install with Composer

From the project root:

```bash
composer require drupal/loremipsum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/loremipsum -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en loremipsum -y
```

After enabling, grant the module's permission to the roles that should be able to
generate placeholder text, at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Confirm the module appears as enabled (**Extend**, or `drush pml | grep
loremipsum`) and that its permission is listed at **People → Permissions**. Grant
it to your developer/site‑builder role and generate some placeholder text to
confirm it works.
