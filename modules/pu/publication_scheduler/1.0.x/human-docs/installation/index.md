# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Publication Date** (`publication_date`) — records when a node was first
  published.
- **Scheduler** (`scheduler`) — schedules content to publish/unpublish
  automatically.

Both dependencies are what this module coordinates, so they must be present. The
`-W` flag below lets Composer install them for you. Note this module has
*not-covered* security advisory coverage, so review it against your own policy
before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/publication_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Publication Date and Scheduler dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/publication_scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en publication_scheduler -y
```

Drupal enables Publication Date and Scheduler at the same time if they aren't
already on. You'll also want to configure Scheduler on the content types you
schedule (that's done in Scheduler's own settings and each content type's
*Scheduler* options).

## Verify it worked

Add or edit a node of a content type that has Scheduler enabled. On the form you
should notice the improvements: the **Authored on** field hidden, the
**Published** control shown as clearer radio buttons, and the **Publish on**
scheduling field appearing only when you keep the content unpublished. To adjust
this behavior, see [Configuration](../configuration/index.md).
