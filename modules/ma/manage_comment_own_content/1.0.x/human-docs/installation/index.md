# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Comment** module (`comment`) and **Node** module (`node`), both
  enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/manage_comment_own_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/manage_comment_own_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en manage_comment_own_content -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`). You should see the
new per-comment-type permissions — *update / delete / view unpublished comments
on own content* — plus *View overview of comments on own content*. Grant the ones
you need to the appropriate roles (see the
[overview](../index.md#how-to-use-it)) and save. To confirm, log in as a user with
those permissions and check they can moderate comments on their own content but
not on content owned by someone else.
