# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Flag** module (`flag`), version **5.x**.
- The **Token** module (`token`) — used for the placeholders in email templates.
- Core's **Node** (`node`) and **User** (`user`) modules.
- A **regularly running cron**, since notifications are queued and sent on cron.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flagger_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag and Token
modules and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flagger_notify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flagger_notify -y
```

This also enables the Flag, Token, Node, and User modules if they aren't already
on.

## Make sure cron runs

Flagger Notify processes its email queue on cron. Confirm your site's cron is
running on a regular schedule (via a system cron job or an external scheduler) —
if cron doesn't run, queued notifications won't be sent.

## Verify it worked

Go to **Configuration → System → Flagger Notify**
(`/admin/config/system/flagger-notify`) and confirm the settings page loads. See
[Configuration](../configuration/index.md) to set up your templates and choose
which flags send notifications.
