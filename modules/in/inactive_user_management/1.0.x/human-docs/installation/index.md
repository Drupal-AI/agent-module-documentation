# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **User** module (`user`), always present.
- The **Ultimate Cron** module (`ultimate_cron`) — used to schedule how often the
  module's job runs (default: once a day).
- The **Symfony Mailer** module (`symfony_mailer`) — used to send the notification
  emails.

Composer pulls in Ultimate Cron and Symfony Mailer for you. Note this release is
**1.0.0‑beta4** (a beta), and the module is **not covered by Drupal's security
advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/inactive_user_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Ultimate Cron and Symfony Mailer.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inactive_user_management -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inactive_user_management -y
```

Drupal enables User, Ultimate Cron, and Symfony Mailer automatically if they are
not already on.

## Verify it worked

After enabling, go to the module's settings form (see
[Configuration](../configuration/index.md)) and confirm you can enable the inactive‑
user notification and edit the message. Because notifications are sent on cron, the
end‑to‑end confirmation is seeing a notification email go out to a dormant test
account on the next scheduled run.
