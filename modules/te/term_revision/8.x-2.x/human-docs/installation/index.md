# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- No special requirements — the module needs only core's taxonomy system, which is
  part of standard Drupal. It declares no additional module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/term_revision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/term_revision`) matches
the module's machine name (`term_revision`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_revision -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_revision -y
drush cr
```

Clearing the cache (`drush cr`) is worth doing here — the module's own docs call
for it after enabling. Taxonomy terms will then have revision support.

## Grant the revision permissions

Term Revision adds its own permissions controlling who can view and revert term
revisions. Go to **People → Permissions** (`/admin/people/permissions`) and grant
them to the roles that should manage term history — keep these to trusted editors,
since reverting a term is an editorial action.

## Verify it worked

Edit an existing taxonomy term and save a change, then look for the revisions view
on that term. You should see the new revision recorded, with the ability to view,
delete, or revert revisions.
