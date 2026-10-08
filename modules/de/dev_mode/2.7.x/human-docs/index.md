# Development Mode — manual setup guide

**Development Mode** (`dev_mode`) turns a Drupal site into a development
environment simply by being enabled. Instead of asking you to hand-edit
`settings.php` and `services.yml` every time you want Twig debugging, disabled
caches and verbose errors, the module makes those changes for you the moment you
turn it on — and puts everything back the way it was when you uninstall it.

When you enable it, the module first takes a snapshot of your current
performance settings (CSS/JS aggregation and page cache) and your logging level,
storing them safely in Drupal's state system. It then switches CSS/JS
aggregation off, sets the page cache lifetime to zero and turns error reporting
up to *verbose*. It also tries to append a small include to your `settings.php`
that enables Twig debugging and auto-reload, disables the Twig cache, swaps in a
null cache backend and turns on cacheability debug headers. At runtime it injects
`no-cache` meta tags so your browser stops caching pages while you work on the
front end.

This is emphatically **not** a production tool. It exposes backtraces to visitors,
disables caching, and writes to your site's settings files — and if `settings.php`
is not writable it will temporarily loosen the permissions on `sites/default` to
edit `services.yml` directly. Use it only on local, CI or review environments.

This guide is written for a **human** setting the module up by hand. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and understand what it changes on your site.

## How to use it

There is **no configuration UI** — that is by design. The whole feature set is
"enabled = development mode on":

- **Turn development mode on:** enable the module (`drush en dev_mode -y`). Twig
  debugging, disabled caches, verbose errors and no-cache meta tags all switch on
  immediately.
- **Turn development mode off:** uninstall the module (`drush pmu dev_mode -y`).
  The module restores your original performance and logging settings from the
  snapshot it saved, strips the include it added to `settings.php`, and reverses
  any `services.yml` edits.

A couple of things worth knowing while it is enabled:

- The saved snapshot in state (`dev_mode.config`) is the *only* record of your
  previous settings. Don't delete it while the module is on, or uninstall won't be
  able to restore. You can inspect it with `drush sget dev_mode.config`.
- If the module had to fall back to editing `services.yml`, it leaves
  `sites/default` at permissions `0555` afterwards. If your directory was `0755`
  or `0750` before, check and reset the permissions after install or uninstall.

## Where it lives in the admin menu

Nowhere — Development Mode adds no admin pages, permissions or menu items. Its
entire behaviour is triggered by enabling and disabling the module.
