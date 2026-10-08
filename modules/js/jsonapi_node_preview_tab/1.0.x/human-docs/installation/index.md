# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **JSON:API** (`jsonapi`) modules.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_node_preview_tab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_node_preview_tab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_node_preview_tab -y
```

Drupal enables JSON:API as a dependency if it is not already on.

## Grant the permission

The tab is hidden until you grant **`access jsonapi preview tab`**. At **People →
Permissions** (`/admin/people/permissions`), grant it to the editor and developer
roles that should see the JSON:API preview.

## Verify it worked

Log in as a user with the permission, open any node, and confirm a **JSON:API** tab
appears alongside View/Edit. Clicking it should show the node's JSON:API document in
an embedded frame. Because the frame uses the standard JSON:API endpoint, an
unpublished node still respects JSON:API's own access rules inside the frame.
