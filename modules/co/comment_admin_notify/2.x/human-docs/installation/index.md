# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module (`comment`) — enabled automatically as a dependency.
- The **Token** module (`token:token`) — a contributed dependency Composer will
  pull in for you.

There are no third‑party PHP library requirements. This release is marked *not
covered* by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_admin_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in the Token module automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_admin_notify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_admin_notify -y
```

Drupal will enable the Comment and Token dependencies alongside it if they aren't
already on.

## Verify it worked

Make sure your site can actually send mail (a working mail transport is required
for any email notification). Then post a test comment on a piece of content and
confirm the administrator inbox receives the notification. Remember the comment
text is included in the email, so route these notifications to an inbox that's
appropriate for that content.
