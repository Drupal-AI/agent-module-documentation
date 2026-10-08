# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [DraggableViews](https://www.drupal.org/project/draggableviews) module
  (`draggableviews`) — this is a required dependency and provides the drag‑and‑drop
  handlers and the storage for the manual order.
- Core's Views is used to render the bundled listing (enabled by default).

## Install with Composer

From the project root:

```bash
composer require drupal/content_draggable -W
```

The `-W` (`--with-all-dependencies`) flag pulls in DraggableViews and any other
shared dependencies at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_draggable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_draggable -y
```

Enabling Content Draggable also enables DraggableViews as its dependency, and
automatically creates the bundled view for the reorderable listing.

## Verify it worked

Look for the **Content Draggable** link in the admin menu, or go to
`/admin/admin-content-draggable`. You should see a drag‑and‑drop content listing.
There is no configuration step — the view is created automatically, and you can add
fields or adjust filters in the Views UI to suit your needs.
