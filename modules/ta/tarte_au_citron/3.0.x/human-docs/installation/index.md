# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **tarteaucitron.js library**, which the module does *not* bundle — you must
  download it separately (see below).

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/tarte_au_citron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tarte_au_citron -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tarte_au_citron -y
```

There are no submodules.

## Install the JavaScript library (required)

Until the library is present, the module's status report shows a warning ("version:
Missing") and the banner will not appear. Download
[tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) and place it so that these
files exist under your web root:

```
web/libraries/tarteaucitron/tarteaucitron.js
web/libraries/tarteaucitron/tarteaucitron.services.js
web/libraries/tarteaucitron/lang/tarteaucitron.<lang>.js
```

If you also drop in `tarteaucitron.min.js`, the module automatically loads the minified
version. The project README also documents a Composer-merge approach (using
`composer.libraries.json` and the `amauric/tarteaucitron` package) if you prefer to manage
the library through Composer.

After installing the library, clear caches (`drush cr`) — the module caches what it
discovers from the library files — and continue to
[Configuration](../configuration/index.md).
