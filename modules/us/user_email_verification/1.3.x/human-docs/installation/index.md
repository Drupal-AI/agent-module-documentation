# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present.
- A working **cron** — the module blocks, reminds, and deletes on cron runs, so
  cron must run regularly for enforcement to happen.

Two optional modules make it much more useful:

- **Token** (`drupal/token`) — provides the `[user:verify-email]` token you place
  in the welcome email to deliver the verification link. In practice you'll want
  this.
- **Rules** (`drupal/rules`) — unlocks the module's Rules events, conditions, and
  actions for building custom reactions.

## Install with Composer

From the project root:

```bash
composer require drupal/user_email_verification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the recommended Token module too:

```bash
composer require drupal/user_email_verification drupal/token -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/user_email_verification -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_email_verification -y
```

To also enable Token (recommended) and, if you want it, Rules:

```bash
drush en token -y
# and optionally:
drush en rules -y
```

When the module is enabled, `hook_install` seeds every existing account (uid > 0)
as **already verified**, so turning it on will not block current users.

## Permission

The module defines one permission, **Manage user email verification settings**,
which gates its settings form. It's marked *restricted* because it controls the
site's whole verification, blocking, and deletion policy — grant it only to trusted
administrators at **People → Permissions**.

## Next step — required configuration

Unlike most modules, this one does **not** work on install alone: you must change
core's account settings so users are logged in at registration and the verification
link is emailed. Follow [Configuration](../configuration/index.md) next.
