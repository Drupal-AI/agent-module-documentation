<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anime.js library loading

Everything the `anime` module does lives in `anime.module`, `anime.libraries.yml` and
`anime.install`. There is no `src/`, no config, no routes and no permissions.

## Install / enable

1. `drush en anime` (or via the UI). Enabling triggers `anime_install()`, which shows a warning
   message if no local library copy is found.
2. Optionally place the library locally so it is served from your own domain:
   download `juliangarnier/anime` and put the minified build at
   **`/libraries/anime/lib/anime.min.js`** (the finder also accepts a `libraries/animejs` or
   `libraries/anime.js` directory). Without a local copy the module falls back to the CDN.
3. Confirm status at **Admin → Reports → Status report** (`/admin/reports/status`): the
   *Anime.js library* row shows `Installed (Version X.Y.Z)` (severity OK) when local, or
   `Not installed (CDN - Version 3.2.2)` (severity ERROR) when the CDN fallback is active.

## Two declared libraries (`anime.libraries.yml`)

- **`anime/anime.js`** — loads the local file `/libraries/anime/lib/anime.min.js`; declared
  `version: 3.2.2`, MIT, gpl-compatible.
- **`anime/anime.cdn`** — loads
  `//cdnjs.cloudflare.com/ajax/libs/animejs/3.2.2/anime.min.js` as an `external`, `minified` JS
  asset.

## How the library is attached (`anime_page_attachments()`)

Implements `hook_page_attachments`, so it runs on **every** rendered page (front-end and admin):

1. Returns early during Drupal installation (`InstallerKernel::installationAttempted()`).
2. If the **`anime_ui`** module is enabled (`module_handler->moduleExists('anime_ui')`), this
   module does **nothing** — `anime_ui` is expected to own library loading.
3. Otherwise: if `anime_check_installed()` is TRUE it attaches `anime/anime.js` (local);
   otherwise it attaches `anime/anime.cdn`. Result: the global `anime()` function is always
   present on the page.

Note `anime_ui` is a separate companion project — it is **not** shipped in this package.

## Detection helpers

- `anime_find_library($name = 'anime')` — builds a core `LibrariesDirectoryFileFinder` (root,
  site path, profile extension list, install profile) and returns the first matching path across
  `sites/<site>/libraries`, root `libraries`, and `profiles/<profile>/libraries`.
- `_anime_build_manual_file_path(bool $minimized = TRUE)` — resolves the library dir under names
  `anime` / `animejs` / `anime.js` and returns `<dir>/lib/anime[.min].js` (or FALSE).
- `anime_check_installed()` — TRUE when that path exists on disk.
- `anime_detect_version()` — reads the file and returns the version from
  `preg_match('/anime.js\s*v?(\d+\.\d+\.\d+)/i', ...)`, or `''` / `NULL` when absent/unparsable.
- `anime.install` defines `ANIME_DOWNLOAD_URL` = the anime GitHub `master.zip`, used in the
  requirement and install messages.

## Using it in your code

The module only makes the `anime` global available; you write the animation yourself, typically
in a `Drupal.behaviors` script attached by your theme/module:

```js
anime({
  targets: 'div',
  translateX: 250,
  rotate: '1turn',
  backgroundColor: '#FFF',
  duration: 800,
});
```

See the official docs at https://animejs.com/documentation/ for the full API (timelines,
staggering, SVG, callbacks).
