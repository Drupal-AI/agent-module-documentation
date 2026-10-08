<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alt Text Generator (alt_text_generator) — agent index

Adds an **AI "Generate Alt Text" button** to core image-field widgets. On click, the browser
POSTs a file id to a module route; the controller base64-encodes that managed image and calls the
external **Alt Text Generator** service (`alttextgeneratorai.com`) with the site's API key, then
writes the returned description into the field's `alt` input. Package `Content`. Depends on core
**`image`**. Core requirement `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.3.

- **Settings form, config object/schema, API key & language, credit check** →
  [config/settings.md](config/settings.md)
- **The generate route, controller, widget hook, and JS flow** →
  [api/generate.md](api/generate.md)

## What it actually is

- **No permissions, no entities, no plugins, no Drush.** It provides one config object, one hook,
  one form, one controller, and a JS behavior.
- **Hook** `alt_text_generator_field_widget_single_element_form_alter()` (in
  `alt_text_generator.module`) — fires only when `$context['widget']` is a core `ImageWidget` and
  the alt field is enabled; attaches the `alt_text_generator/alt_text_generator` library and, when
  an image is already uploaded, adds a `#type => button` "Generate Alt Text" with a `data-file-id`.
- **Routes** (`alt_text_generator.routing.yml`):
  - `alt_text_generator.generate` — `POST /api/alt-text-generator/generate`,
    `_controller: AltTextGeneratorController::generate`, `_permission: 'access content'`,
    `no_cache: TRUE`.
  - `alt_text_generator.settings` — `/admin/config/content/alt-text-generator`, the config form,
    `_permission: 'administer site configuration'` (menu link under Configuration → Content).
- **Controller** `src/Controller/AltTextGeneratorController.php` — injects `http_client`
  (Guzzle), `file_system`, `config.factory`. Reads `fid`+`language` from the request, `File::load`s
  it, base64-encodes the real file, and POSTs `{image, wpkey, language}` to
  `https://alttextgeneratorai.com/api/drupal`; returns `{success, altText}` JSON.
- **Settings form** `src/Form/AltTextGeneratorSettingsForm.php` (`ConfigFormBase`) — `api_key`
  (required textfield) + `default_language` (select, 34-language `LANGUAGES` const, default
  `english`); on build it POSTs the key to `…/api/verify` and shows `freeRewritesLeft` credits.
- **Config** object `alt_text_generator.settings` — keys `api_key`, `default_language`
  (schema in `config/schema/alt_text_generator.schema.yml`; install defaults in
  `config/install/`, which ship `api_key: ''` and `language: 'en'`).
- **Dead code:** `src/Form/AltTextGenerator.php` is in namespace `Drupal\simple_alt_text\Form` and
  its `generateAltText()` only sets a hardcoded placeholder; it is **not wired to any route or
  form** in this module.

## Transport

- The outbound calls (`/api/drupal`, `/api/verify`) use the injected Guzzle client over HTTPS.
- The image sent to the vendor is a **local managed file** loaded by numeric `fid`.
- Generated `altText` is returned as JSON and set via jQuery `.val()` into an `<input>` value
  (`js/alt_text_generator.js`); it is not rendered as raw HTML.
