# Installation

## Requirements

- **Drupal 8.8 or newer**, including 9, 10, and 11 (`core_version_requirement:
  >=8.8`).
- The **`spatie/ray`** Composer package, which provides the global `ray()`
  function — this is pulled in when you require the module.
- The **Ray desktop app** installed and running on your machine to receive the
  debug output.

> **Development only.** Ray Debugger must never run on production. See the note on
> the [overview page](../index.md).

## Install with Composer

Because this is a development tool, require it as a **dev-only** dependency so it
is never part of a production build:

```bash
composer require --dev drupal/ray_debugger
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require --dev drupal/ray_debugger`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and only the submodules you need

```bash
drush en ray_debugger -y
```

Then enable only the submodules for the layers you want to debug:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Twig** | `ray_debugger_twig` | A `ray()` function usable inside Twig templates. |
| **JavaScript** | `ray_debugger_js` | A client-side Ray library so you can call `ray()` from JS. **Loads an external CDN script (`cdn.jsdelivr.net/npm/node-ray`) on every page** when enabled. |
| **AlpineJS** | `ray_debugger_alpinejs` | The AlpineJS `$ray(...)` helper; also attaches on every page. |

For example, to debug only Twig templates:

```bash
drush en ray_debugger_twig -y
```

## Keep it out of production

Both `--require-dev` and excluding the module from exported config protect you:

```php
// settings.php (or a per-environment settings file)
$settings['config_exclude_modules'][] = 'ray_debugger';
```

## Add a ray.php config file

Create `ray.php` at your project root to point Ray at the desktop app and toggle
it on or off (see the [overview page](../index.md) for an example). On Docker or
DDEV, `host.docker.internal` reaches the Ray app running on your host.

## Verify it worked

With the Ray desktop app open, add a call such as `ray('hello from Drupal');` to
a code path you can trigger, then reload the page. The value should appear in the
Ray app window. Confirm the module is **not** enabled on production before
deploying.
