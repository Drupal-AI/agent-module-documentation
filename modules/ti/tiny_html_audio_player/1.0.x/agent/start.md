<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tiny-player HTML audio player (tiny_html_audio_player) — agent index

Renders `file` fields as a compact custom HTML5 audio player driven by the Howler JavaScript library.
The whole module is one **field formatter** plus the plumbing it needs: a formatter plugin
(`TinyHtmlAudioPlayerFormatter`, id `tiny_html_audio_player`) that extends core's
`FileMediaFormatterBase` (media type `audio`), a render element (`#type` =>
`tiny_html_audio_player`), a theme hook + Twig template that emits an `<audio><source></audio>`
markup block, and two asset libraries. There is **no settings page, no route, no service, no
permission, and no drush command** — you configure it entirely from a field's "Manage display" tab
(or the equivalent display-config API).

The formatter's `viewElements()` (`src/Plugin/Field/FieldFormatter/TinyHtmlAudioPlayerFormatter.php`)
turns each audio file into a `#type => tiny_html_audio_player` render array whose `#src` is the
managed file's absolute URL (`file_url_generator::generateAbsoluteString($file->getFileUri())`),
`#src-type` is the file's MIME type, and `#title` is the parent entity's label. The render element
(`src/Element/TinyHtmlAudioPlayer.php`) attaches the `tiny_html_audio_player/tiny_html_audio_player`
and `tiny_html_audio_player/fa_css` libraries; the template
(`templates/tiny-html-audio-player.html.twig`) prints `<source src="{{ src }}" type="{{ src_type }}">`
— all values pass through Drupal's default Twig HTML auto-escaping.

- **Depends on:** `howlerjs:howlerjs` (the Howler.js wrapper module) — hard dependency in info.yml.
- **Suggests:** `drupal/fontawesome` (^2) — for local Font Awesome icons; otherwise `fa_css` loads FA from a cdnjs CDN.
- **Core:** `^9.3 || ^10 || ^11`. **Package:** `Fields`.
- **Settings page / configure route:** none (`configure` = null). Configured per-field on Manage display.
- **Permissions:** none. **Drush:** none. **Services:** none of its own. **Routes:** none.
- **Plugin types provided:** none. It *provides* one field-formatter plugin and one render-element plugin, but defines no new plugin type.
- **Config schema:** `field.formatter.settings.tiny_html_audio_player` (formatter settings only).

## What you'd do → where
- Enable the player on an audio/file field, list the formatter settings, set it from code → [`agent/fields/formatter.md`](fields/formatter.md)
- Reuse the render element / theme hook to output a player from arbitrary code → [`agent/fields/formatter.md`](fields/formatter.md)

## Key facts (real machine names)
- **Field formatter id:** `tiny_html_audio_player` — class `TinyHtmlAudioPlayerFormatter`, field type `file`, media type `audio`.
- **Formatter settings:** `controls`, `autoplay`, `loop`, `multiple_file_display_type` (inherited from `FileMediaFormatterBase`; schema `field.formatter.settings.tiny_html_audio_player`).
- **Render element:** `#type => tiny_html_audio_player` — class `Drupal\tiny_html_audio_player\Element\TinyHtmlAudioPlayer`; props `#title`, `#src`, `#src_type` (element info uses `#src_type`; the formatter sets `#src-type`), `#attributes`.
- **Theme hook:** `tiny_html_audio_player` — variables `title`, `src`, `src_type`, `attributes`; template `tiny-html-audio-player.html.twig`.
- **Hooks implemented:** `hook_theme()`, `hook_library_info_alter()` (swaps in local `libraries/` copies of tinyPlayer JS/CSS and Font Awesome when present).
- **Libraries:** `tiny_html_audio_player/tiny_html_audio_player` (js `js/tinyPlayer.js`, css `css/tinyPlayer.css`; deps `core/jquery`, `howlerjs/howler`) and `tiny_html_audio_player/fa_css` (Font Awesome, external cdnjs by default).
