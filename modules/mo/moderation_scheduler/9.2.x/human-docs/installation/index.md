# Installation

## Requirements

Moderation Scheduler needs only Drupal core modules:

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- Core **Datetime**, **Field**, **Node**, and **Views** modules — all part of a
  standard Drupal install and enabled automatically as dependencies if needed.

There are no third‑party Composer or PHP library requirements. It is designed to
work with or without Content Moderation and with or without multilingual
translation, and it shines on multilingual sites where each language revision can
be scheduled independently.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_scheduler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_scheduler -y
```

> **What enabling does:** the install step adds a `field_scheduled_time`
> (datetime) field to **every node type** on the site. This is expected — it is
> how editors set the publish time on the node form.

## Verify it worked

1. Edit any node and confirm a **Scheduled time** datetime field now appears on
   the form.
2. Visit **Configuration → Content authoring → Moderation Scheduler**
   (`/admin/moderation-scheduler`) and confirm the settings form loads.
3. Grant editors the **edit moderation scheduler field** permission, then set a
   scheduled time on a node and run cron to confirm it publishes. See
   [Configuration](../configuration/index.md) for the details.
