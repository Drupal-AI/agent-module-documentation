# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Shortcut** module (`shortcut`) — the feature this module extends.
- The **Draggable Views** module (`draggableviews`) — what makes the shortcut list
  reorderable by dragging.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/shortcut_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Draggable Views if it is not already installed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shortcut_view -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shortcut_view -y
```

Drupal enables the core Shortcut and Draggable Views modules automatically as
dependencies.

## Verify it worked

Enabling the module creates a shortcuts view block. Go to
**Structure → Block layout** (`/admin/structure/block`), search for the **shortcuts**
block, and place it in a region. Once placed, it displays the current user's
shortcuts and lets them drag the links into order.
