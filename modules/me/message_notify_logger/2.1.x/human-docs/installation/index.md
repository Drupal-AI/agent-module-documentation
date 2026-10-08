# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [Message Notify](https://www.drupal.org/project/message_notify) module
  (`message_notify`), which builds on the
  [Message](https://www.drupal.org/project/message) module.
- **Important:** the verbose logging depends on specific **forks** of the Message
  Notify / Message Subscribe stack that add the "logger delegation" and "origin"
  hooks. The standard released versions may not include these. Check the module's
  project page for the current fork/patch requirements before relying on it — without
  the required hooks, no log entries are captured.

There are no external PHP library requirements. This project is minimally maintained
and not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/message_notify_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_notify_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_notify_logger -y
```

Drupal enables the `message_notify` dependency automatically if it is present.

## Verify it worked

Send a Message Notify notification, then check **Reports → Recent log messages**
(`/admin/reports/dblog`) for a corresponding delivery entry. If nothing appears,
confirm that your Message stack includes the forked hooks noted under Requirements —
those are what feed this logger.
