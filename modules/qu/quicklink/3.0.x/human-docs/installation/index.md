# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** module (`node`) — enabled automatically as a dependency.

There are no third-party Composer requirements. The Quicklink JavaScript library
loads from a public CDN by default, so nothing extra is needed to get started —
though you can host it locally (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/quicklink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/quicklink -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quicklink -y
```

There are no submodules. Prefetching is active immediately with sensible
defaults.

## Optional: host the Quicklink library locally

By default the module loads the Quicklink library from the unpkg CDN. To avoid
the external request, download the library and place it so that the file
`libraries/quicklink/dist/quicklink.umd.js` exists in your web root. The module
detects that file automatically and serves the local copy instead of the CDN —
there is no config toggle to flip.

## Verify it worked

Visit **Configuration → Development → Performance → Quicklink**
(`/admin/config/development/performance/quicklink`); the settings form should
load. To confirm prefetching is happening, turn on **debug mode** on that form and
watch your browser's console as you scroll — it logs which links Quicklink is (and
isn't) prefetching and why.
