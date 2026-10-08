# Installation

## Requirements

- **Drupal 11.1+** (`core_version_requirement: ^11.1`).
- **PHP 8.3+** with the `zip`, `dom` and `libxml` extensions (standard on almost
  every host).
- **`andileco/php-epub`** — the pure-PHP ePub library. Composer installs it
  automatically when you require the module.

Individual submodules add their own requirements:

- **Book Integration** needs core's **Book** module.
- **Markdown** needs the `league/commonmark` library (Composer pulls it in when the
  submodule is installed).
- **Viewer** needs the `epub.js` and `JSZip` JavaScript libraries. Sites with a
  strict Content Security Policy also need `frame-src blob:; child-src blob:` so the
  in-browser reader can render.

## Install with Composer

From the project root:

```bash
composer require drupal/epub_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including `andileco/php-epub`) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/epub_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en epub_generator -y
```

Then set who may generate and download ebooks at **People → Permissions** — the
module provides its own permissions for these operations.

## Submodules — enable only what you need

ePub Generator ships several optional submodules. Enable them from **Extend**
(tick the box and save) or with `drush en`:

- **Book Integration** — turns Book outlines into multi-chapter ebooks and adds the
  metadata field mapping and the *Download ePub* tab on book nodes. Requires the
  core **Book** module.
- **Viewer** — adds the *Read online* tab and the inline reader for uploaded
  `.epub` files. Requires the `epub.js` and `JSZip` libraries (see Requirements).
- **Markdown** — offers `.md` files attached to file fields as ePub downloads.
  Requires `league/commonmark`.

## Verify it worked

Visit a node and look for the **Download ePub** tab (once Book Integration is on it
appears on every node in a Book). Click it — you should get a valid `.epub` file.
If you enabled the Viewer submodule, you should also see a **Read online** tab that
opens the ebook in the browser.
