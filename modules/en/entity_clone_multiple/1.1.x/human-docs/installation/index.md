# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- No third‑party Composer library requirements.

> **Note:** This project is not covered by Drupal's security advisory policy. The
> **administer entity clone settings** permission is marked *restricted* — grant it
> only to trusted administrative roles.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_clone_multiple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_clone_multiple -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_clone_multiple -y
```

## Grant the permissions

Under **People → Permissions** (`/admin/people/permissions`):

- **Administer entity clone settings** — required to create, edit, and delete the
  per-entity-type clone settings; this is a restricted permission, so grant it to
  trusted administrators only.
- The **general settings** form additionally requires **Administer site
  configuration**.
- A **per-entity-type clone permission** is generated for each entity type — grant
  these to the editorial roles that should be allowed to clone that type of content.

## Verify it worked

Log in as a user with **Administer entity clone settings** and go to **Configuration
→ Content authoring → Entity clone** (`/admin/config/content/entity-clone`). You
should see the clone settings list with an **Add** action. Next, see
[Configuration](../configuration/index.md) to set up cloning for an entity type.
