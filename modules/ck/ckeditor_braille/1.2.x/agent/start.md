<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Braille (ckeditor_braille) — agent index

**Braille authoring for CKEditor 5.** Adds a toolbar toggle that lets editors type
Braille Unicode directly in CKEditor 5 (the classic `f d s j k l` keys, pressed
alone or in combination), plus transliteration between text and Braille, a
per-format settings form, a text-format output filter, a browser speech-synthesis
read-back, and an optional practice/quiz ("exercise") feature that can pull
challenge data from an external endpoint.

**Version:** 1.2.x (1.2.0). Core: `^10.5 || ^11 || ^12`. Depends on core `ckeditor5`.
Package `CKEditor`. No composer runtime deps beyond core. Provides config schema
(`config/schema/ckeditor_braille.schema.yml`). No permissions file, no services file,
no submodules, no Drush commands.

## Layout

- `ckeditor_braille.ckeditor5.yml` — declares the CKEditor 5 plugin
  `ckeditor_braille_braille` (JS plugin `braille.Braille`), toolbar item `braille`,
  runtime library `ckeditor_braille/braille`, admin library `ckeditor_braille/admin.braille`,
  and the GHS `elements` it may create (`<section>`, `<section class data-braille-id>`,
  `<p class>`, `<braille-font>`, `<braille-font class data-braille-id>`,
  `<braille-checker>`, `<braille-checker class>`).
- `src/Plugin/CKEditor5Plugin/Braille.php` — the configurable plugin
  (`CKEditor5PluginDefault` + `CKEditor5PluginConfigurableInterface`). Supplies
  `defaultConfiguration()`, the per-format settings form, and pushes config to JS via
  `getDynamicPluginConfig()`. Config has three groups:
  - `ckeditor_braille_api`: `apiMethod` (GET/POST), `apiUrl`, `adminRoute`
    (space-separated path(s) to skip challenge fetches on).
  - `ckeditor_braille_ui`: `brailleStrict` (balloon warning message for invalid input),
    `useSpecialChars`, `autoInsert` + `autoInsertSelector`, `clearButton`,
    `evaluateButton`, `preventEnter`, `preventDelete`.
  - `ckeditor_braille_speech`: `pitch` (default 1.5), `rate` (default 0.25), `voice`
    (accent+character blend; browser-resolved best-effort).
  Note: the actual letter→Braille key mapping is done in the JS plugin (fixed
  `f d s j k l` keys); the PHP form does NOT configure per-format letter maps —
  it configures API/UI/Speech behaviour. `validateConfigurationForm()` is empty.
- `src/Plugin/Filter/BraillePreview.php` — `@Filter` id `ckeditor_braille_braille_preview`,
  `TYPE_TRANSFORM_IRREVERSIBLE`, title "Braille preview". Renders stored/non-editable
  Braille strings for output: parses `<p>` containers via DOMDocument
  (`detectContainers()`) and returns text `strip_tags`'d to an allowlist
  (`em, strong, u, sup, sub, section, p`).
- `src/Controller/ExerciseController.php` — route `ckeditor_braille.exercise` at
  `/ckeditor-braille/exercise`, `_permission: 'access content'`. `__invoke` calls
  `moduleHandler()->invokeAll('ckeditor_braille_config', [$request])` to let other
  modules feed exercise data (no implementers ship with this module → returns `[]` by
  default), splits paragraphs, then XOR-obfuscates each JSON item with key `0x10` and
  returns an `AjaxResponse`. This XOR is display obfuscation for the quiz, not
  cryptography, and no request input is used in a dangerous server-side sink.
- `ckeditor_braille.libraries.yml` — `braille` (runtime: bridge shim
  `drupal-ckeditor5-bridge.js` loaded before the UMD bundle `ckeditorbraille.umd.js`,
  plus `ckeditorbraille.css`; deps core/ckeditor5, editorClassic, essentials);
  `admin.braille` (loaded on the text-format config form: `admin-braille.css`,
  `ckeditorbraille-speech.js` exposing `window.CKEditorBrailleSpeech`, and
  `js/admin-voice-demo.js` for a live voice-preview demo; deps core/once, core/drupal).
- `ckeditor_braille.module` — only `hook_help()`.
- `ckeditor_braille.install` — `hook_uninstall()` strips the `braille` toolbar item and
  `ckeditor_braille_braille_inputs` plugin settings from every editor on uninstall.
- Prebuilt JS/CSS in `js/build/` ship ready to use; TS source lives externally at
  `gitlab.com/nk-/ckeditor5-braille` (see README for the `npm run build:drupal` workflow).

## Usage / setup

1. `composer require drupal/ckeditor_braille`, enable the module.
2. Administration → Configuration → Content authoring → Text formats and editors; edit
   or create a CKEditor 5 format and drag the **Braille** toolbar button into the active
   toolbar. This reveals the "Braille Settings" (API / UI / Speech) fieldset.
3. Optionally add the **Braille preview** filter to a format for rendering stored Braille.
4. The exercise/quiz page lives at `/ckeditor-braille/exercise`.

## Security

Read-only exercise route (`access content`, returns only data other modules opt to feed,
empty by default; the `0x10` XOR is obfuscation, not encryption). The output filter is an
irreversible transform relying on the format's own tag-limiting for sanitisation; the only
network egress (challenge `apiUrl`) is admin-configured and fetched client-side. No PHP
upload route, no shell/exec, no SQL, no server-side SSRF/TLS surface. No security findings.
