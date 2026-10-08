# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Content Moderation** module (`content_moderation`), with at least one
  workflow defined — the bypass permission is generated per workflow, so there's
  nothing to grant until a workflow exists.

Drupal will enable Content Moderation automatically as a dependency. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_bypass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_bypass -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_bypass -y
```

## Grant the bypass permission — deliberately

Enabling the module adds a **`bypass {workflow} transition restrictions`**
permission for each workflow, but grants nothing by itself. Go to **People →
Permissions** (`/admin/people/permissions`) and assign it only to a narrow
administrative role, per workflow where possible. Because it lets a holder set any
moderation state directly — bypassing the workflow's integrity — never give it to
general editors, and audit who holds it over time.

## Verify it worked

As a user in the role you granted, edit a moderated content item. You should be able
to set its moderation state to any state in that workflow, regardless of the current
state, instead of only the transitions the workflow normally allows. As a user
*without* the permission, the usual transition restrictions should still apply.
