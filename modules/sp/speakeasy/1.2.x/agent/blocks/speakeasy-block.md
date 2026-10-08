<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speakeasy — the `speakeasy_block` block plugin

`src/Plugin/Block/SpeakeasyBlock.php`, id `speakeasy_block`, admin label "Speakeasy Block".
Extends `BlockBase implements ContainerFactoryPluginInterface`. Place it (Block Layout) on the
regions/pages where you want a listen control. All speech happens in the browser — the plugin
only assembles text and playback options into a render array.

## Dependency injection (`create()`)
`config.factory` → `speakeasy.settings`, the `node` from `current_route_match` (nullable),
`current_user`, `user.data`, `language_manager`, `entity_type.bundle.info`,
`entity_field.manager`.

## Content compilation (`build()`)
1. Reads block config `fields` (chosen field machine names). Builds CSS/data selectors
   (`.field--name-*`, `[data-speakeasy-field="*"]`) for the highlighter.
2. If a `node` is in context, iterates its field definitions. For each field it: skips fields
   not in the selected set (when any were selected); **checks `$field->access('view', currentUser)`
   and skips fields the user cannot view**; includes only these types — `string`, `string_long`,
   `text`, `text_long`, `text_with_summary`, `text_plain`, `email`, `telephone`.
3. Each value is run through `Html::decodeEntities(strip_tags($text))` to plain text and
   concatenated.
4. If the compiled `$content` is empty, `build()` returns `[]` (block renders nothing).

## Resolved playback settings
- Voice: user `user.data` `voice_name` else config `default_voice_name`.
- Speed: user `user.data` `speed` else block `speed` else config `default_speed` else `1`.
- Language: node language else current interface language else default language.
- `show_voice_select` / `highlight`: block config AND the global `allow_voice_selection` /
  `allow_highlighting` gates (a global `false` forces the feature off; also enforced in
  `blockForm()`/`blockSubmit()`).

## Output payload
Attaches library `speakeasy/speakeasy` and `drupalSettings.speakeasy` with `content`,
`contentSelectors`, `fieldNames`, `voiceName`, `speed`, `outputStyle`, `language`, `highlight`,
`allowedVoices`, `allowedLanguages`, and `userPreferences`. When `highlight` is on, also attaches
`speakeasy/speakeasy.highlight`. The `theme` config maps to `speakeasy_theme_default` /
`speakeasy_theme_olivero` (or none). Cache: context `route`, tags `node:<nid>` (if a node) and
`config:speakeasy.settings`.

## Output styles (block config `output_style`)
- `simple_link` — an inline `#speakeasy-link` (role=button) plus a hidden-or-shown voice `<select>`.
- `media_player` — renders the `speakeasy_media_player` theme (play/pause/stop buttons, progress
  range, settings toggle; template in `templates/speakeasy-media-player.html.twig`).
- `default` — `#speakeasy-tts-button` (custom `button_text`), disabled `#speakeasy-stop-button`
  (custom `stop_button_text`), and a voice `<select>`.

## Block configuration form (`blockForm`/`blockSubmit`)
Keys in `defaultConfiguration()`: `output_style` (`default`), `button_text` ("Listen to this
page"), `stop_button_text` ("Stop"), `speed` (`1`), `show_voice_select` (`TRUE`),
`highlight` (`FALSE`), `fields` (`[]`). The form lists selectable text fields by scanning every
node bundle's field definitions (same type filter as above). Admins with
`administer speakeasy settings` see a link to the settings page (rendered via
`Xss::filter(..., ['p','a'])`). `blockSubmit()` saves each config key; `fields` is `array_filter`ed.

## Access
`blockAccess()` returns `AccessResult::allowedIfHasPermission($account, 'access content')` — a
read-only display control, no state change.

## Front-end libraries (browser-only, `speakeasy.libraries.yml`)
`speakeasy.tts` (main), `.voice` (loads/filters `speechSynthesis.getVoices()` against the
whitelist + locale), `.highlight` (sentence wrapping + auto-scroll), `.bus`/`.constants`/`.utils`
(shared plumbing), `.user_preferences`, `.admin`. No `fetch`/XHR to any server; the only
`innerHTML` writes clear the voice `<select>` (`= ''`). Keyboard: Space play/pause, S stop.
