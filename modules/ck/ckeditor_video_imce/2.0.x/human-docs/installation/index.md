# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled.
- The contrib **IMCE** module (`imce`) — required for the file browser. If it is
  not already on your site, Composer will pull it in as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_video_imce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including IMCE if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_video_imce -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_video_imce -y
```

This also enables IMCE if it was not already on.

## Configure IMCE

Because file selection runs through IMCE, make sure an IMCE profile exists for the
roles that will use the video button. Visit **Configuration → Media → IMCE File
Manager** (`/admin/config/media/imce`) and confirm the relevant roles have a
profile that grants access to the directories and file types (your video files)
they need. Without this, the browser will open but show nothing selectable.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format, and drag the video button into the toolbar. Save, then edit
content: click the video button, browse to a video file via IMCE, set any
attributes, and confirm the `<video>` element is inserted and plays on the saved
page.
