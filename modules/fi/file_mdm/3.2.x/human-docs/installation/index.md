# Installation

## Requirements

File Metadata Manager needs **Drupal core `^11.2`** and two PHP libraries, which
Composer pulls in automatically when you require the module:

- **`dompdf/php-font-lib`** (`^1.0.1`) — used to parse TTF/OTF/WOFF font
  metadata (consumed by the `file_mdm_font` submodule).
- **`fileeye/pel`** (`^0.12`) — the PHP EXIF Library, used to read and write
  EXIF data (consumed by the `file_mdm_exif` submodule).

The base module has no contrib module dependencies of its own. It ships one
built-in metadata plugin, **Getimagesize**, which reads image width, height, and
MIME type using PHP's native `getimagesize()` — no extra library required.

### Optional submodules

File Metadata Manager ships two submodules you can enable when you need richer
metadata:

- **`file_mdm_exif`** — adds an **EXIF** metadata plugin (via the `fileeye/pel`
  library) for reading EXIF/IPTC tags such as camera, orientation, GPS, and
  timestamps, and writing modified EXIF back to a file.
- **`file_mdm_font`** — adds a **font** metadata plugin (via
  `dompdf/php-font-lib`) for reading TTF/OTF/WOFF font information such as family
  and style.

You do not have to enable either one for the base module to work. Enable them
only if a module you use, or your own code, asks for EXIF or font metadata.

## Install with Composer

From the project root:

```bash
composer require drupal/file_mdm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`dompdf/php-font-lib` and `fileeye/pel` libraries and update anything else that
needs it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/file_mdm -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_mdm -y
```

To also turn on the EXIF and/or font metadata plugins, enable the submodules:

```bash
drush en file_mdm_exif -y     # adds the EXIF plugin
drush en file_mdm_font -y     # adds the font plugin
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → File metadata
manager** (`/admin/config/system/file_mdm`). You should see the settings page
with a **Missing file logging** selector, a **Metadata caching** section, and a
**Getimagesize** plugin section:

![The File metadata manager settings page](../images/settings.png)

If the page loads and those sections are present, the module is installed
correctly. Next, review the [configuration](../configuration/index.md).
