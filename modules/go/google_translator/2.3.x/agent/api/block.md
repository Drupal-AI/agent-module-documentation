<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Google Translator block

## Plugin

`\Drupal\google_translator\Plugin\Block\GoogleTranslator`

```
@Block(
  id = "google_translator",
  admin_label = @Translation("Google Translator"),
  category = @Translation("Google Translator")
)
```

Place it like any block: **Structure → Block layout**, choose a region, "Place block", pick
"Google Translator". Or via a `block.block.*` config entity / `drush` with plugin id
`google_translator`. The block forces its own title on (`label_display` is overridden to a
`value`/FALSE element in `buildConfigurationForm()`); the visible link text comes from the block
`label` (default `"Translate this page"`).

## What `build()` produces

- A `<a href="#" class="notranslate google-translator-switch">` link carrying the block label —
  this is the click target the disclaimer JS binds to.
- `#cache.tags` = the cache tags of `google_translator.settings` (so editing settings invalidates
  the block).
- Attaches library `google_translator/disclaimer` and a `drupalSettings.googleTranslatorDisclaimer`
  payload: `selector`, `displayMode`, `disclaimerTitle`, `disclaimer` (XSS-admin-filtered),
  `acceptText`, `dontAcceptText`, and a pre-rendered `element` (the actual Google widget markup).

## The Google widget element

Built by `getElement()`:
- Reads `google_translator_active_languages`; if **empty**, logs a warning ("Specify some
  languages in the Google Translator settings…") and renders "No languages available for
  translation" instead of the widget.
- Emits a `<span id="google_translator_element">` placeholder plus a `<script
  src="//translate.google.com/translate_a/element.js?cb=Drupal.behaviors.googleTranslatorElement.init">`.
- Attaches library `google_translator/element` with `drupalSettings.googleTranslatorElement`:
  `id`, `langcode` (current UI language), `languages` (comma-joined active codes), `displayMode`.

## Disclaimer flow

If disclaimer text is set, clicking the selector opens a jQuery UI dialog (Accept / Do Not
Accept) before the Google widget activates. Styling can be reset by overriding `core/drupal.dialog`
in a theme's `libraries-override` (see README). No server call is made — Google's script does the
translation in-browser, so there is no API key and nothing is persisted.
