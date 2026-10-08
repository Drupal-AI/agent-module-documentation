<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confetti (confetti) — agent index

`.info.yml` name **Confetti**, description literally `Confetti`. Shows a client-side **confetti
animation** on any page whose path an admin lists in config. The effect plays automatically on
**page load** for those paths — there is no event/form-submission/JS-API trigger. Built on the
external [canvas-confetti](https://github.com/catdad/canvas-confetti) library, loaded at runtime
from a CDN (not bundled). Installed **2.0.1** (version dir `2.0.x`). Package `confetti`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. No module or Composer dependencies.

## What it provides (from source)

- **`hook_page_attachments`** (`confetti.module`) — the entire trigger mechanism. On every request
  it reads `confetti.settings:confetti_urls` (an array of path strings), gets the current internal
  path (`path.current`) and its alias (`path_alias.manager`), and if either matches a value in the
  list via `in_array()`, attaches the `confetti/confetti` library. Match is **exact string
  equality** against the stored path — no wildcards, no prefix matching. The stored values are only
  ever compared, never printed to the page.
- **Library `confetti/confetti`** (`confetti.libraries.yml`) — loads two JS files: the local
  `js/confetti.js` and the **external** `//cdn.jsdelivr.net/npm/canvas-confetti@1.9.2/dist/confetti.browser.min.js`
  (`type: external`). Depends on `core/jquery`, `core/jquery.once`, `core/drupal`.
- **`js/confetti.js`** — a `Drupal.behaviors.Confetti` that, 500 ms after attach, fires
  `window.confetti(...)` bursts from both screen edges for ~6 s (4 s under 742 px wide). All
  parameters (colors `#81386d`/`#a5c200`, particle count, angles) are **hardcoded** in this file;
  the README's "customization" means editing this JS. No `drupalSettings` are read or written.
- **Settings form** `Drupal\confetti\Form\ConfettiSettingsForm` (a `ConfigFormBase`,
  `src/Form/ConfettiSettingsForm.php`) at route `confetti.settings` → `/admin/confetti`, guarded by
  the module permission **`edit confetti configuration`**. A dynamic table of textfields (AJAX
  "Add another" button) collecting one or more `confetti_url` paths. `validateForm` requires each
  value to pass `Url::fromUserInput()` (must start with `/`) and requires at least one non-empty
  value. `submitForm` saves the list to `confetti.settings:confetti_urls` and invalidates the cache
  tags of any node the paths resolve to (so the page re-renders with/without the library).
- **Permission** `edit confetti configuration` (`confetti.permissions.yml`) — gates the settings
  form only. No `restrict access` flag.
- **Admin menu link** (`confetti.links.menu.yml`) — *Configuration › System* → the settings form.
  `.info.yml` `configure:` points at `confetti.settings`.

## What it does NOT have

No controllers or non-form routes, no `_access: TRUE` routes, no REST/JSON endpoints, no blocks, no
plugin types, no Drush commands, no install/update hooks, no config schema file (config is written
untyped as a plain array of path strings), no templates, no CSS. The confetti visuals are not
configurable through the UI — only *which paths* show them.

## Usage

Enable, visit `/admin/confetti`, enter one or more paths (e.g. `/node/1` or an alias like
`/thank-you`), Save. Loading a matching page plays the animation. See
[usage.md](../usage.md) and [human-docs](../human-docs/index.md).
