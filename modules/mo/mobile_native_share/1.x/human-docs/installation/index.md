# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No module dependencies and no third-party PHP libraries.
- The share button relies on the browser's **Web Share API**, which requires the
  site to be served over **HTTPS** and needs a user gesture (a tap/click) to open
  the share sheet. Where the API is unavailable, the button falls back to the
  Clipboard API or a prompt dialog.

## Install with Composer

From the project root:

```bash
composer require drupal/mobile_native_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mobile_native_share -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mobile_native_share -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Mobile Native Share**
(`/admin/config/search/mobile-native-share`) — the settings form should load.
Enable the button for a content type, save, then open a node of that type over
HTTPS and confirm the share button appears (and, on a supported mobile browser,
opens the native share sheet).
