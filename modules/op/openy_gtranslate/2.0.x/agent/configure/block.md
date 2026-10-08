<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — place and theme the Google Translate block

The module ships exactly one thing to configure: the **`openy_gtranslate_block`** block. It has no
settings form of its own — you place it with the core Block Layout UI (or programmatically) and rely on
its render output plus the attached JS/CSS. Everything below is the real contract an agent needs.

## Place the block

- UI: `/admin/structure/block` → *Place block* → "Open Y Google Translate" (category **OpenY**) →
  choose region + visibility. Only the standard core block settings apply (label, label display,
  visibility conditions, region) — the plugin defines **no `blockForm()`/`blockSubmit()`**, so there are
  no widget-specific options.
- Plugin: id `openy_gtranslate_block`, class
  `Drupal\openy_gtranslate\Plugin\Block\OpenYGTranslateBlock` (`src/Plugin/Block/OpenYGTranslateBlock.php`).
  `build()` returns:
  ```php
  [
    '#theme' => 'openy_gtranslate',
    '#in_preview' => $this->inPreview,
    '#in_preview_placeholder' => $this->t('Open Y Google Translate block.'),
    '#attached' => ['library' => ['openy_gtranslate/translate']],
  ];
  ```

## What it renders

- Theme hook `openy_gtranslate` (`openy_gtranslate_theme()` in `openy_gtranslate.module`), template
  `templates/openy-gtranslate.html.twig`, variables `in_preview` (FALSE) and `in_preview_placeholder`
  (NULL).
- Live (non-preview) markup:
  ```html
  <a class="openy-gtranslate-placeholder">Select Language</a>
  <div class="openy-google-translate d-none"></div>
  ```
  In Layout Builder / preview it instead renders `<div class="container">{{ in_preview_placeholder }}</div>`.
  Both `Select Language` and the placeholder go through Twig `t()`/`#t`, so they are translatable and
  auto-escaped. The template emits **no configuration value** — nothing user- or admin-supplied is
  printed into the markup.

## JS / CSS / DOM contract

Library `openy_gtranslate/translate` (`openy_gtranslate.libraries.yml`) attaches
`css/openy_gtranslate.css` and `js/openy_gtranslate.js` with deps `core/drupal`, `core/drupalSettings`,
`core/once`. Behavior `Drupal.behaviors.googleTranslateSwap`:

1. Binds **one** delegated `click` listener on `document.body`, guarded by
   `once('google-translate-listener', document.body)` (works for blocks injected into popups/dynamic content).
2. On a click whose target is inside `.openy-gtranslate-placeholder`, it walks up to the block wrapper
   **`.block-openy-gtranslate-block`**, then to the child **`.openy-google-translate`** container,
   assigns it an id (`openy-gtranslate-widget-N`), hides the placeholder and reveals the container
   (toggling `.d-none`).
3. First activation injects `//translate.google.com/translate_a/element.js?cb=Drupal.googleTranslateElementInit`
   into `<head>` (once, tracked by `Drupal.googleTranslateState.isScriptInjected`); once the API is ready,
   `Drupal.googleTranslateElementInit` builds `new google.translate.TranslateElement({ pageLanguage:
   drupalSettings.path.currentLanguage, layout: …InlineLayout.VERTICAL }, widgetId)`.

Required classes if you theme this yourself: the block wrapper **must** carry
`.block-openy-gtranslate-block` (Open Y's block templates provide it) — the swap handler climbs to it
with `placeholder.closest('.block-openy-gtranslate-block')` and does nothing if it is absent. Style hooks
in `css/openy_gtranslate.css` target `.desktop-menu .openy-gtranslate-placeholder` and
`.mobile-sidebar .openy-gtranslate-placeholder`.

## Update hooks (distribution upgrade only — not runtime config)

- `openy_gtranslate_update_8001` — deletes an enabled "Language" menu link from the `main` menu (when the
  default theme is `openy_lily`) or otherwise the `account` menu.
- `openy_gtranslate_update_8002` — for each installed Open Y theme, imports the optional block config
  `block.block.openy_carnation_gtranslate_mobile` / `openy_lily_gtranslate_mobile` /
  `openy_rose_gtranslate_mobile` via the `openy_upgrade_tool.importer` service (available only inside the
  Open Y distribution). Outside Open Y these run only if that service and those theme configs exist.
