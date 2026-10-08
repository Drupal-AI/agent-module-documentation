# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Editor** module (`editor`) enabled — the only module dependency, and Drupal
  enables it automatically.
- **The Ace ("ace‑builds") JavaScript library**, downloaded into your site's
  `libraries/` directory. This is not bundled with the module and is required — see
  "Download the Ace library" below.

## Install with Composer

From the project root:

```bash
composer require drupal/ace_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ace_editor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ace_editor -y
```

## Download the Ace library (required)

The Ace JavaScript is **not shipped** with the module. Until it is present, the editor
falls back to a plain textarea and the Status Report (`/admin/reports/status`) shows an
error. Place the library so that `libraries/ace/ace.js` exists (the module also accepts
`libraries/ace-builds`). From the Drupal docroot:

```bash
cd libraries
git clone --depth 1 https://github.com/ajaxorg/ace-builds.git ace
```

Alternatively, download an [ace‑builds release](https://github.com/ajaxorg/ace-builds)
ZIP and unpack it into `libraries/ace` so that `libraries/ace/ace.js` is present.

The module automatically registers each theme (`theme-*.js`) and mode (`mode-*.js`) file
it finds in that directory, so the full Ace theme and language catalogue becomes
available once the library is in place.

## Verify it worked

Open the Status Report at **Reports → Status report** (`/admin/reports/status`) — the
Ace Editor entry should no longer show a "library missing" error. Then assign the Ace
editor to a text format and confirm a textarea using that format renders as the code
editor. Configuration and day‑to‑day use are covered in the
[overview guide](../index.md#how-to-use-it).
