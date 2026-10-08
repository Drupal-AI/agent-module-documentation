# Installation

## Requirements

Scheduler runs on **Drupal 9, 10, or 11** (`^9 || ^10 || ^11`). It relies only on
modules that ship with Drupal core, which are enabled automatically as
dependencies:

- **System** (`system`)
- **Datetime** (`datetime`) — provides the date/time field widget used for the
  **Publish on** and **Unpublish on** fields.
- **Field** (`field`)
- **Node** (`node`) — Scheduler supports core content nodes out of the box.
- **Views** (`views`) — used for the bundled "Scheduled content" listings.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduler -y
```

Once enabled, the settings page appears under **Configuration → Content
authoring → Scheduler** (`/admin/config/content/scheduler`).

## Make sure cron runs regularly

Scheduler does its work **on cron**. When cron runs, it finds any content whose
**Publish on** or **Unpublish on** time has passed and performs the action. This
means a scheduled change only happens as promptly as your cron runs — if cron
runs once an hour, a piece of content scheduled for 9:00 might not actually go
live until the next cron run after 9:00.

So make sure Drupal's cron is running on a regular schedule. If you need tighter
timing than full site cron provides, Scheduler also offers a **lightweight cron**
you can trigger more frequently — see the
[Configuration](../configuration/index.md) page.

## Verify it worked

Log in as an administrator and go to `/admin/config/content/scheduler`. You
should see the **Scheduler** settings page with **Settings** and **Lightweight
cron** tabs:

![The Scheduler settings page after installation](../images/settings.png)

If that page loads, the module is installed correctly. Next, review the
[configuration](../configuration/index.md) and switch scheduling on for a content
type.
