# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`) — notification content is built from Paragraphs.
- Core's **Datetime Range** module (`datetime_range`) — provides the start/end
  date-range field that schedules when a bar shows.

Paragraphs is a contrib module, so Composer needs to fetch it; Datetime Range
ships with core and Drupal will enable it as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/dismissible_message_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Paragraphs (and its
own dependencies such as Entity Reference Revisions) and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dismissible_message_bar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drupal will offer to enable Paragraphs
and Datetime Range automatically):

```bash
drush en dismissible_message_bar -y
```

Enabling the module creates a **DMB Notification** content entity type with a
`default` bundle (pre-loaded with all the targeting/cookie/date fields), a
`dmb_notification_type` taxonomy vocabulary for categorizing notifications, and
an admin listing view.

## What to do next

Nothing shows yet — you need to create at least one notification and place the
block. See [Configuration](../configuration/index.md) for the full walkthrough.
