# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5||^11`).
- Core's **File** module (`file`) — required, and enabled by default on standard
  sites.
- **CKEditor 5** — optional, needed only if you want the in-editor toolbar button.
  The field formatter works without it.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/soundcite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soundcite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en soundcite -y
```

## Set it up where you need it

Enabling the module does not change any content by itself. Depending on how you
want to use SoundCite:

- **CKEditor 5 button** — add the **Soundcite** button to the toolbar of a
  CKEditor 5 text format at **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`). Confirm the format's allowed HTML
  permits the SoundCite markup, and only enable it on trusted formats.
- **Field formatter** — set **"Soundcite Audio Player"** as the display formatter
  for an audio file field on the relevant content type's **Manage display** page.

## Verify it worked

Edit a piece of content on a format where you added the button and confirm the
Soundcite toolbar button appears; insert a clip with an audio URL and start/end
times, save, and check that the text becomes a click-to-play inline clip. For the
formatter, view an entity whose audio file field uses the Soundcite formatter and
confirm the inline player renders.
