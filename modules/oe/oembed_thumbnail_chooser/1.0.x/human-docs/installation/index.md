# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 ||
  ^11`).
- Core's **Media** module (`media`) enabled — this is the module's only dependency,
  with at least one **Remote video** media type for YouTube/Vimeo.
- The module notes a dependency on the **core patch from issue [#3042423]** to
  function. Check the project page for the current status before relying on it in
  production.

> **Note:** This release is a beta (`1.0.0-beta2`) with a "maintenance fixes only"
> status and, at the time of writing, is **not covered by Drupal's security
> advisory policy**. Review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/oembed_thumbnail_chooser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oembed_thumbnail_chooser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oembed_thumbnail_chooser -y
```

There is nothing to configure — the module has no settings page.

## Verify it worked

Add a **new** YouTube or Vimeo video as a Remote video media item, then look at the
stored thumbnail. For a YouTube video that has a high‑resolution poster, the
thumbnail should now be the sharper `maxresdefault` (or `sddefault`) image rather
than the soft `hqdefault`. For existing media, re‑save the item to trigger the
upgrade. Because each fetch makes up to two extra outbound HTTP requests, watch the
time on large bulk imports (see the [overview](../index.md) for details).
