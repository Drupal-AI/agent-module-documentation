# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Path** module (`path`), which provides the URL alias field. Drupal
  enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/url_alias_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/url_alias_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en url_alias_permissions -y
```

If core's Path module isn't already on, Drupal enables it at the same time.

## Assign the permissions

There is no settings form. Go to **People → Permissions**
(`/admin/people/permissions`) and grant the generated per‑type / per‑bundle URL
alias permissions to the roles that should be able to edit aliases. See the
[overview page](../index.md#how-to-use-it) for the step‑by‑step.

> **Note:** If you're upgrading from an older release, the module's update hook
> renames legacy node permissions (`edit <type> url alias`) to the current
> `edit <type> node url alias` naming — run database updates (`drush updb`) after
> updating so your existing grants carry over.

## Verify it worked

After enabling and clearing caches, open **People → Permissions** and confirm you
see the URL Alias Permissions section with a row for each of your content types
(and other path‑bearing entity types).
