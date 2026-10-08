# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8** or newer (`php: ^8`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency because the icon fields store uploaded images as file entities.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pwa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pwa -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pwa -y
```

A valid manifest is served immediately at `/manifest.json`, using the bundled
default icons until you upload your own. Remember to grant the **Access PWA**
permission to the roles that should receive the manifest link.

## Submodules — enable only what you need

PWA ships three optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Add to Home Screen** | `pwa_a2hs` | A block with an "Add to Home Screen" prompt/button you can place in a region to nudge visitors to install the app. |
| **PWA Extras** | `pwa_extras` | Apple/iOS‑specific meta tags, Apple touch icons, and splash screens for a more polished install on iPhone/iPad. |
| **Service Worker** | `pwa_service_worker` | An experimental service worker for offline caching and an offline fallback page. |

For example, to add offline support:

```bash
drush en pwa_service_worker -y
```

Each submodule requires the base PWA module, which is already present once you
have installed it above.
