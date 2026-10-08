<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Google Translate (openy_gtranslate) — agent index

A single block plugin that drops the **Google Translate** widget onto a site, packaged for the Open Y
/ YMCA Website Services distribution. The block (`openy_gtranslate_block`) renders a themed
"Select Language" link plus an empty container; a delegated click handler in `js/openy_gtranslate.js`
lazily injects Google's `translate_a/element.js` on first click and builds a
`google.translate.TranslateElement` (vertical inline layout) inside the container, using
`drupalSettings.path.currentLanguage` as the source language. There is **no settings page, no route,
no service, no permission, no config schema and no block-specific form** — the module's entire surface
is: place the block (core Block Layout), the theme hook/template it renders, and the JS/CSS behavior.

- Depends on: nothing (info.yml lists no `dependencies`). The `.install` update hooks reference the
  distribution-only service `openy_upgrade_tool.importer`, but that is upgrade-time only, not a runtime dep.
- Core: `^9 || ^10 || ^11`. Package: `YMCA Website Services`. Version `2.0.0` (installed/enabled, verified).
- No `configure` route (settings `null`). No permissions, no drush commands, no config schema, no plugin
  types defined. Provides one **block plugin** and one **theme hook**.

## What you'd do → where

- **Place / theme the widget, understand the block, template, JS and CSS class contract, and the two
  update hooks** → [configure/block.md](configure/block.md)

## Key facts (real machine names)

- Block plugin: `openy_gtranslate_block` (`src/Plugin/Block/OpenYGTranslateBlock.php`, extends
  `BlockBase`), admin label "Open Y Google Translate", category `OpenY`. No `blockForm()` — only core
  block config (label/visibility/region).
- Theme hook: `openy_gtranslate` (`openy_gtranslate_theme()` in `openy_gtranslate.module`), variables
  `in_preview` (FALSE), `in_preview_placeholder` (NULL). Template `templates/openy-gtranslate.html.twig`.
- Library: `openy_gtranslate/translate` (`openy_gtranslate.libraries.yml`) → `css/openy_gtranslate.css`,
  `js/openy_gtranslate.js`; deps `core/drupal`, `core/drupalSettings`, `core/once`.
- JS globals: `Drupal.behaviors.googleTranslateSwap`, `Drupal.googleTranslateElementInit`,
  `Drupal.googleTranslateState`. External script: `//translate.google.com/translate_a/element.js`.
- CSS/DOM contract: wrapper `.block-openy-gtranslate-block`, link `.openy-gtranslate-placeholder`,
  container `.openy-google-translate`, toggle class `.d-none`; style hooks `.desktop-menu` / `.mobile-sidebar`.
- Update hooks: `openy_gtranslate_update_8001` (delete a "Language" menu link), `openy_gtranslate_update_8002`
  (import `block.block.openy_{carnation,lily,rose}_gtranslate_mobile` via `openy_upgrade_tool.importer`).
- Caveats (properties of the widget, not the module): machine translation is unreviewed and not indexed
  as real translations; page content is sent to Google (privacy/consent); Drupal's own multilingual
  system is unaffected — this is a display overlay.
