# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Several contrib modules that the bundle's submodules depend on:
  **Add Content By Bundle**, **Auto Entity Label**, **Config Pages**, **Field Group**,
  **Field Permissions**, **Hide Revision Field**, **Smart Date**, and **ECA**. Composer
  resolves and installs these for you when you require the bundle with `-W`.

## Install with Composer

From the project root:

```bash
composer require drupal/event_platform -W
```

The `-W` (`--with-all-dependencies`) flag is important here — the bundle brings in a
number of contrib dependencies, and `-W` lets Composer install and update them
together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/event_platform -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling the top-level module installs the full stack of submodules in one step:

```bash
drush en event_platform -y
```

## Submodules — enable only what you need

The bundle is made of focused submodules. Enabling `event_platform` pulls them all in,
but you can instead enable just the ones you want (for example only Sessions and
Speakers) with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Details** | `event_platform_details` | A central *Event details* admin section, hero/CTA/copyright blocks, metatag defaults, and the Session Schedule interface. |
| **Sessions** | `event_platform_sessions` | Visitor-suggested sessions with an approval workflow, accept/reject notifications, and rooms/tracks/time slots. |
| **Speakers** | `event_platform_speakers` | Structured speaker content for featuring speakers. |
| **Sponsors** | `event_platform_sponsors` | Sponsors grouped by sponsorship tier (bronze/silver/gold). |
| **Scheduler** | `event_platform_scheduler` | The drag-and-drop scheduler UI, time-slot generator, and its settings form. |
| **Ratings** | `event_platform_ratings` | Collect ratings on sessions or content. |
| **Job Listings** | `event_platform_job_listings` | Job openings, optionally tied to sponsors. |

An `event_platform_olivero` submodule (not in the required set) automatically places
the provided blocks into Olivero theme regions — enable it if your site uses Olivero.

For example, to enable just the scheduler:

```bash
drush en event_platform_scheduler -y
```

## Verify it worked

Log in as an administrator. You should see a new **Event details** section in the admin
area, and the Sessions/Speakers/Sponsors content types under **Structure → Content
types**. Visit **/admin/event-details/scheduler** to confirm the Scheduler is
available. Then see [Configuration](../configuration/index.md) to tune the scheduler.
