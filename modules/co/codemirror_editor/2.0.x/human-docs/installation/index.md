# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 7.1 or newer**, with the JSON extension (`ext-json`).
- Core's **Editor** (`editor`) module, plus the **js_cookie** module
  (`drupal/js_cookie`, `^1.0 || ^2`) — both are pulled in as dependencies.
- The **CodeMirror JavaScript/CSS library**. By default the module loads it from a
  **CDN**, so there is nothing to download. If you choose to self‑host (CDN off),
  the library must live under `libraries/codemirror` — see *Self‑hosting the
  library* below.

## Install with Composer

From the project root:

```bash
composer require drupal/codemirror_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including js_cookie.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/codemirror_editor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en codemirror_editor -y
```

Out of the box the module loads CodeMirror from a CDN, so it works immediately —
you can go straight to [Configuration](../configuration/index.md).

## Self-hosting the library (optional)

If you'd rather not depend on a CDN (for offline or locked‑down sites), turn the
**Load from CDN** option off on the settings form and download the library
locally. The module ships a Drush command that fetches it into
`libraries/codemirror` for you:

```bash
drush codemirror:download
```

When the CDN option is off and the files are missing, the site's **Status
report** warns that the CodeMirror library is not found. If you keep the CDN
option on (the default), you do not need to download anything.
