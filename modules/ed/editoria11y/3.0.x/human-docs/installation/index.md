# Installation

## Requirements

Editoria11y needs **Drupal 10.3+ or 11** and four core modules, which are enabled
automatically as dependencies:

- **Node** (`node`) — the content the checker scans.
- **Taxonomy** (`taxonomy`) — used by the reporting data model.
- **User** (`user`) — ties dismissals and permissions to accounts.
- **Views** (`views`) — powers the site-wide results dashboard.

Optional, for the companion submodules:

- **Key** (`key`) — required only by the `editoria11y_csa` submodule for secure
  license-key storage. You do not need it for the core checker.

The module also ships two optional submodules you can enable later:
`editoria11y_csa` (extra developer test suites and a contrast checker) and
`editoria11y_export` (filtered CSV exports of results).

## Install with Composer

From the project root:

```bash
composer require drupal/editoria11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editoria11y -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editoria11y -y
```

This also enables the `node`, `taxonomy`, `user`, and `views` dependencies. Once
enabled, the settings screen appears under **Configuration → Content authoring →
Editoria11y** (`/admin/config/content/editoria11y`).

## Grant the "view editoria11y checker" permission

By design, the checker only loads for users who hold the **View Editoria11y
checker** permission (`view editoria11y checker`) — this is what keeps it hidden
from anonymous visitors and shown only to the people editing content.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the **Editoria11y** section.
3. Tick **View Editoria11y checker** for every role that should see the checks —
   typically your content editor and author roles.
4. Click **Save permissions**.

You can do the same from the command line:

```bash
drush role:perm:add editor 'view editoria11y checker'
```

There are additional, more privileged permissions you may want to assign to
accessibility leads and administrators (for example **Mark as OK**, **Manage
Editoria11y results**, and **Administer Editoria11y checker**). See the
[Configuration](../configuration/index.md) guide.

## Verify it worked

Log in as a user who has the **View Editoria11y checker** permission and open any
content page on the front end. A small checker toggle should appear pinned to the
edge of the page. Then, as an administrator, visit
`/admin/config/content/editoria11y` — the **Core settings** form should load,
confirming the module is installed correctly. Next, review the
[configuration](../configuration/index.md).
