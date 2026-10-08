<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The audio-player field formatter

One field formatter is the entire module surface.

| Formatter id | For field type | Media type | Class | Config schema |
|---|---|---|---|---|
| `tiny_html_audio_player` | `file` | `audio` | `TinyHtmlAudioPlayerFormatter` | `field.formatter.settings.tiny_html_audio_player` |

`TinyHtmlAudioPlayerFormatter` extends core `Drupal\file\Plugin\Field\FieldFormatter\FileMediaFormatterBase`
and overrides `getMediaType()` (returns `'audio'`) and `viewElements()`. Because it extends
`FileMediaFormatterBase`, the formatter is offered on any **`file`** field and its settings form,
default settings, and file-filtering behaviour come from that base class — it only shows up for files
whose MIME type matches the `audio` media type.

## Settings

Inherited from `FileMediaFormatterBase` (schema `field.formatter.settings.tiny_html_audio_player`):

| Setting | Type | Meaning |
|---|---|---|
| `controls` | boolean | Emit the `controls` attribute on `<audio>` (show playback controls). |
| `autoplay` | boolean | Emit `autoplay`. |
| `loop` | boolean | Emit `loop`. |
| `multiple_file_display_type` | string | `tags` (one `<audio>` per file) or `sources` (one `<audio>` with multiple `<source>`), per the base class. |

These booleans are turned into HTML attributes by the base class's `prepareAttributes()`, which
`viewElements()` calls and passes to the render element as `#attributes`; the template then does
`{{ attributes.addClass("iru-tiny-player") }}` on the `<audio>` tag.

## What `viewElements()` builds

`src/Plugin/Field/FieldFormatter/TinyHtmlAudioPlayerFormatter.php:31` — for each source file it emits:

```php
$elements[$delta][$file['file']->uuid()] = [
  '#type'      => 'tiny_html_audio_player',
  '#title'     => $items->getParent()->getValue()->label() ?? '',
  '#src'       => \Drupal::service('file_url_generator')
                    ->generateAbsoluteString($file['file']->getFileUri()),
  '#src-type'  => $file['file']->getMimeType(),
  '#attributes'=> $attributes,
  '#cache'     => ['tags' => $file['file']->getCacheTags()],
];
```

`#src` is the **managed file's** absolute URL (built from its stream-wrapper URI, not from any
request input); `#src-type` is the stored MIME type; `#title` is the parent entity's label. Source
files come from `FileMediaFormatterBase::getSourceFiles()`.

## Render element, theme hook, template

- **Render element** `#type => tiny_html_audio_player` — `src/Element/TinyHtmlAudioPlayer.php`. Its
  `getInfo()` sets `#theme => tiny_html_audio_player`, nulls `#title/#src_type/#src/#attributes`, and
  `#attached`es the `tiny_html_audio_player/tiny_html_audio_player` and `tiny_html_audio_player/fa_css`
  libraries. Note the element declares `#src_type` (underscore) while the formatter sets `#src-type`
  (hyphen); the template reads the `src_type` **theme variable**, which the theme hook populates.
- **Theme hook** `tiny_html_audio_player` (`hook_theme()` in the `.module`) — variables `title`,
  `src`, `src_type`, `attributes`.
- **Template** `templates/tiny-html-audio-player.html.twig`:

  ```twig
  <audio data-title="{{ title }}" {{ attributes.addClass("iru-tiny-player") }}>
    <source src="{{ src }}" type="{{ src_type }}" {{ file.source_attributes }} />
  </audio>
  ```

  All printed values go through Drupal's default Twig HTML auto-escaping. (`file.source_attributes`
  references an undefined `file` variable — the theme hook defines no `file` variable — so it renders
  as nothing; it is a harmless leftover.)

## Assets

`hook_library_info_alter()` in the `.module` swaps the CDN/bundled asset paths for local copies under
a `libraries/` directory when `library.libraries_directory_file_finder` finds
`tiny_html_audio_player/tinyPlayer.js`, `tiny_html_audio_player/tinyPlayer.css`, or
`fontawesome/css/all.min.css`. Otherwise `js/tinyPlayer.js` + `css/tinyPlayer.css` (bundled) and Font
Awesome from cdnjs (external) are used.

## Set the formatter from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_audio', [
    'type' => 'tiny_html_audio_player',
    'settings' => [
      'controls' => TRUE,
      'autoplay' => FALSE,
      'loop' => FALSE,
      'multiple_file_display_type' => 'tags',
    ],
  ])->save();
```

`field_audio` must be a **`file`** field configured to accept audio files. The Howler-based JS
(`js/tinyPlayer.js`) enhances the emitted `<audio class="iru-tiny-player">` on the client.
