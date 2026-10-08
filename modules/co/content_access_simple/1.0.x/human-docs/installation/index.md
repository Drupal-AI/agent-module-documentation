# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- The **[Content Access](https://www.drupal.org/project/content_access)** module
  (`content_access`) — a hard dependency, since this module is a UI layer over
  Content Access's node grants. Composer pulls it in automatically.

There are no additional PHP libraries or third‑party Composer requirements. Note
that this project is **not covered** by Drupal's security advisory policy (and the
current release is a beta), so review it before using it on a high‑stakes site.

## Install with Composer

From the project root:

```bash
composer require drupal/content_access_simple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Content Access and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_access_simple -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_access_simple -y
```

This enables Content Access too if it isn't already on.

## Verify it worked

The widget doesn't appear until you configure it. Follow
[Configuration](../configuration/index.md): turn on per‑node access for a content
type, enable the form component in Manage form display, and grant the permission.
Then edit a node of that type and confirm the **Access and Permissions** section with
its "Visibility" role checkboxes is shown.
