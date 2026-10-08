<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BaguetteBox (baguettebox) — agent index

A single **field formatter** (`baguettebox`, label "BaguetteBox", field type `image`) that renders each
image as `<a href="{lightbox url}">{thumbnail}</a>` and initialises the **baguetteBox.js** swipe/touch
lightbox over a CSS selector. Class
`Drupal\baguettebox\Plugin\Field\FieldFormatter\BaguetteboxFormatter` **extends core `ImageFormatter`**.
Depends only on core `image`. Core requirement `^11.3 || ^12`. Version 4.0.0.

Mechanism in one line: formatter builds per-image `<a>` links (with `data-at-{width}` responsive source
URLs) → attaches all settings to `drupalSettings.baguettebox` + library `baguettebox/formatter` + class
`baguettebox` on the wrapper → `js/baguettebox.js` (a `Drupal.behaviors` attach) calls
`baguetteBox.run(selector, {…})`.

**External library (required, not bundled):** `feimosi/baguetteBox.js` **v1.11.1** (MIT) must be placed at
`/libraries/baguettebox.js/baguetteBox.min.js` and `/libraries/baguettebox.js/baguetteBox.min.css`
(library id `baguettebox/baguettebox`, `remote:` GitHub). `baguettebox_requirements()` raises a runtime
**error** if the JS file is missing. README documents a Composer `package` repository or manual download.

## What you'd do → where

- **Use / configure the formatter (all settings, responsive breakpoints, selector, rendering,
  drupalSettings, theme hook, JS behavior)** → [fields/formatter.md](fields/formatter.md)

## Key facts (real machine names)

- Formatter plugin id `baguettebox`, field type `image`, extends core `image` `ImageFormatter`.
- Settings keys (defaults from `defaultSettings()`): `image_style`=`''` (thumbnail),
  `baguette_image_style`=`''` (default lightbox derivative), `baguette_image_style_responsive`=5 empty
  `{width,image_style}` rows, `animation`=`slideIn` (`none`|`slideIn`|`fadeIn`), `captions_source`=`image_alt`
  (`none`|`image_title`|`image_alt`), `buttons`=TRUE, `fullscreen`=FALSE, `hide_scrollbars`=FALSE,
  `inline`=FALSE, `selector`=`.baguettebox`.
- Config schema: `field.formatter.settings.baguettebox` (`config/schema/baguettebox.schema.yml`).
- Theme hook `baguettebox_formatter` (template `templates/baguettebox-formatter.html.twig`, vars `item`,
  `item_attributes`, `link_attributes`, `url`, `image_style`); registered in
  `src/Hook/BaguetteboxHooks.php` (attribute-based `#[Hook]` class, autowired via `baguettebox.services.yml`,
  injects `\Drupal\image\Hook\ImageThemeHooks` and reuses `preprocessImageFormatter()`).
- Library `baguettebox/formatter` = `css/baguettebox.css` + `js/baguettebox.js`, depends on
  `baguettebox/baguettebox` (external) and `core/drupal`.
- Hooks: `hook_theme`, `hook_help` (route `help.page.baguettebox`), `hook_preprocess_baguettebox_formatter`.
- No admin route (`configure` = none), no permissions, no Drush, no submodules, no `.module` procedural code.
- `baguettebox_post_update_add_selector_option()` backfills `selector`=`.baguettebox` onto existing displays.

## Notes / gotchas

- The formatter dumps the **entire settings array** into `drupalSettings.baguettebox` — a single per-page
  bag, so multiple baguettebox formatters on one page share one settings object; distinguish galleries via
  the **selector** setting, not per-formatter JS config.
- Captions come from the image `alt`/`title` and are passed through `Drupal.checkPlain()` in JS before
  rendering into the overlay caption.
- For **Views**-rendered image fields, enable "Use field template" or add the `baguettebox` class in the
  field style settings so the default `.baguettebox` selector matches.
