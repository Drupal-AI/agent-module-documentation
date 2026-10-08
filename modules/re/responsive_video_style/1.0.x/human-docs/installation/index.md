# Installation

## Requirements

Responsive video style needs:

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- The **Video Style** module (`video_style`) — the base module this one extends.
  Install it **first**.
- Core's **Breakpoint** (`breakpoint`) and **File** (`file`) modules, enabled
  automatically as dependencies.

There are no third‑party PHP library requirements.

## Install with Composer

Install the base Video Style module first, then this module. From the project
root:

```bash
composer require drupal/video_style -W
composer require drupal/responsive_video_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_video_style -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en video_style responsive_video_style -y
```

## Verify it worked

Go to **Configuration → Media → Video styles → Responsive**
(`/admin/config/media/video-styles/responsive`). You should see the responsive
video styles listing, ready for you to add a new responsive video style. You
should also find a bundled **Responsive Video** breakpoint group (Mobile, Tablet,
Desktop) available when creating one.
