# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Font Awesome library itself**, which is not bundled with the module. You
  can either let the module fetch it with its Drush command, load it from a CDN
  (no local files needed), or install it yourself. This is covered below.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fontawesome_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fontawesome_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fontawesome_ui -y
```

## Install the Font Awesome library

The module gives you a choice for where Font Awesome comes from:

- **CDN** — pick the CDN method on the settings form and no local files are
  needed. This is the quickest way to get started.
- **Local copy** — download the library into `libraries/fontawesome`. The module
  ships a Drush command to do this for you:

  ```bash
  drush fa:download
  ```

  Aliases `fadl` and `fa-download` work too. The command downloads the Font
  Awesome release defined in the module, places the zip in
  `libraries/fontawesome`, and extracts it. It is a command‑line, admin‑only
  operation — the download URL is fixed in the module (not something a web
  request can influence), and the target directory is fixed to
  `libraries/fontawesome`. You can also install the library manually or via
  Composer if you prefer to manage it yourself.

## Verify it worked

1. Visit **Configuration → User interface → Font Awesome**
   (`/admin/config/user-interface/fontawesome`) and confirm the settings form
   loads.
2. Choose your method (CDN or local) and save.
3. Visit **Structure → Icon** (`/admin/structure/icon`) — you should see the
   (initially empty) icon list, ready for you to add icons.

Next, see [Configuration](../configuration/index.md) to tune how the library
loads and to build your icon library.
