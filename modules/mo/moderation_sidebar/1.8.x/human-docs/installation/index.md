# Installation

## Requirements

Moderation Sidebar builds on Drupal core's content workflow tools:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) — this is the only
  dependency, and Drupal enables it (along with its own dependency, Workflows) as
  a dependency when you turn on Moderation Sidebar.

There are no third‑party Composer or PHP library requirements. To actually see the
sidebar you will also need a workflow configured in Content Moderation and applied
to at least one content type — that is core functionality, not part of this module.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_sidebar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/moderation_sidebar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_sidebar -y
```

Enabling it also enables Content Moderation and Workflows if they are not already
on.

## Grant the permission

The sidebar is hidden until you grant access. At **People → Permissions**
(`/admin/people/permissions`), give the roles that should moderate content the
**Use moderation sidebar** permission. If you want certain administrators to be
able to hide transitions from the sidebar, also grant them **Administer
moderation sidebar**. From the command line:

```bash
drush role:perm:add editor 'use moderation sidebar'
```

## Verify it worked

Log in as a user with the permission, set up (or confirm) a workflow on a content
type, then view a piece of that content on the front end. A **Tasks** button
should appear in the toolbar; clicking it opens the off‑canvas moderation panel.
