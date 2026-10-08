# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`). Check
  compatibility before using it on Drupal 11.
- Core's **Node** module (`node`) — always present on a content site and enabled as a
  dependency.

There are no third-party Composer or PHP library requirements. Note the project is
**not covered** by Drupal's security advisory policy, which is worth weighing for an
access-control module.

## Install with Composer

From the project root:

```bash
composer require drupal/restrict_node_view_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restrict_node_view_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restrict_node_view_page -y
```

## Grant the permissions

The module takes effect through permissions, so after enabling it:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. For each content type, grant the roles that should be able to open the full page
   either the per-type permission (**View full node pages of _(type)_**) or the
   blanket **View full node pages of all content types**.
3. Save permissions.

Any role left without the relevant permission will get a `403` on the full
`/node/{nid}` page for that content type.

## Verify it worked

1. As a user in a role that was **not** granted the permission, open a full node page
   of a restricted content type — you should get a `403`.
2. As a user in a role that **was** granted it, the same page should load normally.
3. Confirm the content does not leak through other outputs you care about (Views
   listings, blocks, REST/JSON:API) — this module only governs the full node page, so
   restrict those separately if the content must stay private.
