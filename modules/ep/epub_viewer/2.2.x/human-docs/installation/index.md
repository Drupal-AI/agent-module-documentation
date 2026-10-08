# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other module dependencies — the reader library is bundled with the module.
- *Optional:* the **jQuery Colorpicker** module, if you'd like the colour settings
  to appear as colour pickers rather than plain text fields.

## Install with Composer

From the project root:

```bash
composer require drupal/epub_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/epub_viewer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The project directory is `epub_viewer`, but the module's **machine name is
`epub_module`** — that is the name you enable:

```bash
drush en epub_module -y
```

(From the **Extend** page, look for **Epub Viewer** and tick it.)

## Verify it worked

1. Add a file field to a content type and set its display format to **Epub
   Formatter** (Structure → Content types → *Manage display*).
2. Create content with an `.epub` file attached and view it — you should see a link
   that opens the in-browser reader.
3. Visit **Configuration → EPUB → Epub settings**
   (`/admin/config/epub/epubsettings`) to confirm the settings form loads. See
   [Configuration](../configuration/index.md) to adjust the reader's appearance.
