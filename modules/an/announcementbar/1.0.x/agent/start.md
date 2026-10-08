<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Announcement Bar (announcementbar) — agent index

A single **block plugin** that renders a dismissible site announcement banner. No package set in
info.yml. Depends only on core **`block`**. Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.1.

- **The block plugin, every setting, the template, the dismiss JS, and how to operate it** →
  [blocks/announcementbar.md](blocks/announcementbar.md)

## What it actually is

- One plugin: `AnnouncementbarBlock` (id **`announcementbar`**, admin label *"Announcementbar"*), in
  `src/Plugin/Block/AnnouncementbarBlock.php`, extending core `BlockBase`. **No** routes, **no**
  `*.permissions.yml`, **no** services, **no** config schema, **no** Drush, **no** config/install.
- Placement and configuration use **core Block** (permission `administer blocks`). Settings live on
  the block config entity (e.g. `block.block.<id>`), not in a module-owned config object.

## Mechanism (from source)

- `blockForm()` builds a fieldset with `message` (textarea, required), `button` (textfield,
  required), `position` (select top/bottom), `background` + `color` (`#type => color`), and a nested
  fieldset with `interval` (number, required) and `period` (select Minutes/Hours/Days).
  `blockSubmit()` copies each into block configuration.
- `build()` returns `#theme => 'announcementbar_template'` with `#message`, `#button`, `#position`,
  `#background`, `#color`, `#interval`, `#period` from config.
- `templates/announcementbar-template.html.twig` prints `{{ message }}` (Twig **autoescaped**) and
  `{{ button|t }}`, with inline `background-color` / `color` styles from config.
- `.module` hooks: `announcementbar_theme()` declares the template; `announcementbar_page_attachments()`
  attaches the `announcementbar/announcementbar` library and pushes `interval`/`period` into
  `drupalSettings` (read from `block.block.announcementbar`); `announcementbar_preprocess_block()`
  adds a `position:fixed` style + `announcement-bar-wrapper` class when `plugin_id == 'announcementbar'`;
  `announcementbar_help()` provides a help page.
- `js/announcementbar.js` (`Drupal.behaviors.announcementbar`): shows the bar unless the
  `announcement-bar` cookie is set; the button click writes that cookie with an expiry derived from
  `interval`/`period` and slides the bar closed.
- `.install`: `announcementbar_uninstall()` deletes `block.block.announcementbar`.

## Settings (block configuration)

`message`, `button`, `position` (`top`|`bottom`|''), `background` (hex color), `color` (hex color),
`interval` (integer), `period` (`Minutes`|`Hours`|`Days`). Details + the hardcoded-id caveat in
[blocks/announcementbar.md](blocks/announcementbar.md).

## Notes / caveats

- `page_attachments`, `preprocess_block`, and `uninstall` all hardcode the block id
  **`announcementbar`** (config `block.block.announcementbar`). The `interval`/`period` drupalSettings
  and the fixed-position style therefore only take effect when the placed block's machine id is
  exactly `announcementbar`; a block placed with an auto-generated id (e.g. `<theme>_announcementbar`)
  still renders the banner via `build()` but the JS receives `undefined` interval/period.
- `js/announcementbar.js` contains leftover `console.log(interval)` / `console.log(period)` debug
  output and an unused `iCookieLength`/`sCookieName` note; harmless but noisy in production.
- There is **no** config schema, so block config validation on this plugin's settings is minimal.
