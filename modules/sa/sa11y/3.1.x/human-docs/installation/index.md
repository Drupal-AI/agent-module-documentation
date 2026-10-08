# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no dependent modules, no submodules, and no third-party PHP or JavaScript
library requirements to add yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/sa11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sa11y -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sa11y -y
```

## Grant access

Sa11y provides a **use Sa11y** permission (`use_sa11y`) that controls who sees the
checker widget. Assign it to the roles that should have it — usually editors and
content authors — at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Log in as a user in a role that has the **use Sa11y** permission, then visit any
page of your site that uses the **front-end theme** (not the admin interface). The
Sa11y widget should appear in the bottom-right corner of the page. Open it to see
the accessibility issues it has flagged.
