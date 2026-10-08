<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio CKEditor 5 plugin

Plugin id `ckeditor5_audio_plugin_audio`. Definition: `ckeditor5_audio_plugin.ckeditor5.yml`.
PHP: `src/Plugin/CKEditor5Plugin/Audio.php` (`Audio extends CKEditor5PluginDefault implements
CKEditor5PluginConfigurableInterface`, uses `CKEditor5PluginConfigurableTrait`). JS: `js/build/audio.js`.

## Install / enable
1. `drush en ckeditor5_audio_plugin` (core `ckeditor5` is pulled in).
2. At Admin » Configuration » Content authoring » Text formats and editors, edit a format that uses
   the CKEditor 5 editor and drag the **Insert Audio** button (id `audio`) into the toolbar.
3. Configure the button's settings (appears because the plugin is configurable), then save.

## Toolbar / elements
- `toolbar_items.audio.label`: "Insert Audio".
- Declared allowed HTML (`drupal.elements`): `<div>`, `<div class>`, `<audio>`, `<audio src class controls>`.
  The text format's filter must permit these for the markup to survive; the plugin does not add any
  other tags/attributes (no `<source>`, no `controlslist`, no event attributes).

## Configuration (per text format)
Config lives under the editor's plugin settings key `ckeditor5_audio`:

| key | type | default (`defaultConfiguration()`) | meaning |
|-----|------|-----------------------------------|---------|
| `status` | boolean | `FALSE` | TRUE = upload mode (file picker → upload route); FALSE = URL mode (dialog prompts for an audio URL). |
| `directory` | string | `inline-audio` | Subdirectory (under `public://`) uploads are written to. |
| `max_size` | string | `''` | Max upload size; empty means "PHP upload max". |

Schema: `config/schema/ckeditor5_audio_plugin.schema.yml`
(`ckeditor5.plugin.ckeditor5_audio_plugin_audio`, `FullyValidatable`).

Note the `ckeditor5_audio_plugin.ckeditor5.yml` `config` block seeds a default of `status: TRUE`,
but `defaultConfiguration()` returns `status: FALSE`; the effective value is whatever is saved per format.

### Form / config plumbing
- `buildConfigurationForm()` — renders `status` (checkbox `data-editor-audio-upload=status`),
  `directory` (textfield), `max_size` (textfield, `#states` visible only when uploads enabled).
- `validateConfigurationForm()` — empty (no validation).
- `submitConfigurationForm()` — copies `status`/`directory`/`max_size` into
  `configuration['ckeditor5_audio']`.
- `getDynamicPluginConfig()` — merges saved `ckeditor5_audio` config into the static plugin config so
  the JS (`editor.config.get('ckeditor5_audio')`) sees `{status, directory, max_size}`.

## JS behavior (`js/build/audio.js`)
- Model: registers `audioContainer` (object, `allowWhere:$block`) and `audio` (object,
  `allowIn:audioContainer`, `allowAttributes:['src','controls']`).
- Downcast: `<div class="audio-container">` wrapping `<audio class="audio-item" src="…" controls>`.
- `insertAudio` command builds that structure from a URL string.
- Button `execute`: if `config.ckeditor5_audio.status` is truthy → create `<input type=file accept="audio/*">`,
  on change call `uploadFile(file, directory, max_size)` → POST to `/ckeditor5-audio-upload` (see
  [../api/upload.md](../api/upload.md)) → `insertAudio(returnedUrl)`; else `showInsertAudioDialog()`
  (text input, placeholder `https://example.com/audio.mp3`) → `insertAudio(enteredUrl)`.
