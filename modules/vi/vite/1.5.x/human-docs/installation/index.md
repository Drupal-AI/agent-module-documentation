# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).

There are no PHP/Composer dependencies to worry about and no submodules — the
module ships as a self-contained Drupal integration.

> **The actual Vite tooling is separate.** This module is the *Drupal side* of the
> integration. The Vite build itself (the `vite` package, your `vite.config.*`,
> your `src/` files) is a **Node.js dev dependency of your theme or module**, not
> something Composer installs. You set that up in your frontend project the usual
> way (`npm install -D vite`, etc.). This module just teaches Drupal to serve what
> Vite builds.

## Install the module with Composer

From the project root:

```bash
composer require drupal/vite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/vite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. Node/npm commands for the
> Vite build likewise run as `ddev npm …` from the host.

## Enable the module

```bash
drush en vite -y
```

There is no configuration screen. Enabling the module does nothing visible on its
own — Vite only kicks in for libraries you explicitly opt in through your
`.info.yml` / `*.libraries.yml` (and optionally `settings.php`). See the "How to
use it" section on the [overview page](../index.md).

## Verify it worked

1. Opt a library into Vite (add `vite: true` and reference your `src/` files) and
   run your Vite production build so `dist/` and its `manifest.json` exist.
2. Rebuild Drupal's caches: `drush cr`.
3. Load a page that uses that library and view the page source — the asset URLs
   should now point at Vite's hashed `dist/` files (and JS should be loaded as
   `type="module"`).

To confirm HMR, start your Vite dev server, run `drush cr`, and reload — asset URLs
should point at `http://localhost:5173` (or your configured dev-server URL) and the
Vite client should be present. Remember to `drush cr` whenever you start or stop
the dev server, since Drupal caches library definitions.
