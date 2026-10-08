# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Content Moderation** (`content_moderation`) and **Node** (`node`) modules —
  enabled automatically as dependencies.
- [**Smart Date**](https://www.drupal.org/project/smart_date) (`smart_date`) for event
  date handling. Composer pulls it in when you require the module with `-W`.

The module is designed to work within a wider event-platform build (it also integrates
with Config Pages, Content Moderation Link, and Storage where present); see the
module's `event_platform_helper.info.yml` for the complete dependency list.

## Install with Composer

From the project root:

```bash
composer require drupal/event_platform_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
supporting modules (such as Smart Date) at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/event_platform_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en event_platform_helper -y
```

Drupal enables Content Moderation, Node, and Smart Date automatically as
dependencies. On install, the module also grants schedule-flagging permissions to
authenticated users (and extends the "My Schedule" flag to BOF sessions if both are
present).

## Verify it worked

Log in as an administrator and confirm the **Session Scheduler** interface is
available and that the module's blocks (Home Hero, Header CTA, Copyright, Session
Submission Confirmation) appear when you click **Place block** on **Structure → Block
layout**. See [How to use it](../index.md#how-to-use-it) for putting the pieces
together.
