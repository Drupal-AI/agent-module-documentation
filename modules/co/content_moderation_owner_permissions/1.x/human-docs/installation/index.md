# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) — its only dependency —
  with a workflow applied to the content you want owner-scoped moderation for.

Drupal will enable Content Moderation automatically as a dependency. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_owner_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_owner_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_owner_permissions -y
```

## Assign the owner-scoped permissions

The module just adds a new set of permissions — it changes nothing until you assign
them. Go to **People → Permissions** (`/admin/people/permissions`) and:

- Keep the **global** Content Moderation transition permissions (for example
  "publish any") restricted for the roles that should only self-moderate.
- Grant those roles the matching **owner-scoped** transition permission (transition
  *own* content) added by this module.
- Make sure the roles also have the **node edit** permissions they need to edit the
  content they'll moderate.

## Verify it worked

Log in as a user in the configured role. They should be able to move **their own**
content through the workflow (for example, publish it), but should **not** be able to
apply that same transition to content created by another user. If they can transition
others' content, check that the global transition permission is still restricted for
that role.
