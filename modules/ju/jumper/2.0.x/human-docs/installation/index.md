# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- Core's **Block** module (`block`), for placing the Jumper block.
- The **Blazy** module (`blazy`, 3.x or newer) — required only so Jumper can reuse
  Blazy's shared JavaScript helper utilities. No Blazy lazy‑load library or assets
  are loaded.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jumper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Blazy and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jumper -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jumper -y
```

Or enable **Jumper** on the **Extend** page (`/admin/modules`).

## Optional: the Jump.js library

Jumper works with the browser's native smooth scrolling and needs nothing extra.
If you want the Jump.js library's polyfilled scrolling instead, download it and
place it so the file lives at:

```
/libraries/jump/dist/jump.min.js
```

When that file is present, Jumper automatically adds it as a dependency; otherwise
it falls back to native scrolling. (The requestAnimationFrame polyfill is bundled
with recent versions of the library.)

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click *Place
block*. If the module is enabled, a **Jumper** block appears in the list. Place it
in a region, save, then scroll the front end past the activation point — the jump
button should appear and glide the page when clicked. See
[Configuration](../configuration/index.md) for the block's settings.
