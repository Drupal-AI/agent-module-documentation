# Installation

## Requirements

Group Media Library Extra builds on the Group Media Library module:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Group Media Library** module (`group_media_library`) — which in turn
  requires core Media Library, the Group module, and Group Finder.
- Some source plugins (**Group's media items**, **Media without group**)
  additionally require the **Group Media** (`groupmedia`) module. Install it if you
  intend to use those options.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_media_library_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Group Media Library) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_media_library_extra -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_media_library_extra -y
```

Group Media Library (and its dependencies) are enabled automatically if they are
not already on.

## Submodules

Group Media Library Extra ships a `group_media_library_extra_groupmedia`
submodule, which adds Group Media (`groupmedia`) integration. Enable it if you use
the Group Media module and want the group-aware source plugins:

```bash
drush en group_media_library_extra_groupmedia -y
```

## Verify it worked

Go to a group type and confirm a **Media library** tab now appears (**Groups →
Group types → *(your group type)*** → *Media library*), and that **Groups →
Settings → Media Library Extra Settings** exists. Then follow
[Configuration](../configuration/index.md) to choose your media sources.
