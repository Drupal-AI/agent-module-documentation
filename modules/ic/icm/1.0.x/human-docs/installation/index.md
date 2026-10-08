# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled with Drupal's standard profile.
- The contrib **jQuery UI** module (`jquery_ui`), which Composer installs for you.
- No PHP library requirements. Note the front‑end assets are loaded from a
  third‑party CDN at render time — see the supply‑chain note below.

## Install with Composer

From the project root:

```bash
composer require drupal/icm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including jQuery UI — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/icm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en icm -y
```

This enables the Image and jQuery UI dependencies at the same time.

## Verify it worked

Go to any image field's **Manage display** (for example
`admin/structure/types/manage/page/display`). In the formatter dropdown for that
field you should now see **Image Compare Viewer**. Select it, add two images to a
piece of content, and view the page — the images should render as a draggable
comparison slider. See [How to use it](../index.md#how-to-use-it) for the
formatter options.

> **Supply‑chain note.** The slider's JavaScript/CSS are loaded from an *unpinned*
> third‑party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/icm/...`). Before relying on
> this in production, vendor those assets locally or pin them to a specific commit
> so upstream changes can't inject unexpected code into your pages.
