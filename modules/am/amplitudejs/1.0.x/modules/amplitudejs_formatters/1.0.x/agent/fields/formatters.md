<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AmplitudeJS field formatters

Seven formatter plugins in `src/Plugin/Field/FieldFormatter/`, all `field_types = { entity_reference, file }`,
all extending abstract **`PlayerBase`** (which extends core `EntityReferenceFormatterBase`).

## The plugins

| Formatter id | Class | Theme / template | Extra |
| --- | --- | --- | --- |
| `amplitudejs_single_song_player` | `SingleSongPlayer` | `amplitudejs_single_song_player` | click handler on progress bar |
| `amplitudejs_multiple_songs` | `MultipleSongs` | `amplitudejs_multiple_songs` | click handler; placeholder album art |
| `amplitudejs_blue_playlist` | `BluePlaylist` | `amplitudejs_blue_playlist` | — |
| `amplitudejs_white_playlist` | `WhitePlaylist` | `amplitudejs_white_playlist` | — |
| `amplitudejs_flat_black_playlist` | `FlatBlackPlaylist` | `amplitudejs_flat_black_playlist` | — |
| `amplitudejs_simple_black_playlist` | `SimpleBlackPlaylist` | `amplitudejs_simple_black_playlist` | placeholder album art |
| `amplitudejs_visualization_player` | `VisualizationPlayer` | `amplitudejs_visualization_player` | external visualization JS |

Subclasses override only: `getHtmlId()` (unique DOM id, `'<skin>-' . Crypt::randomBytesBase64(8)`),
`getTheme()`, `isAddJsClickHandlerToPlayer()` (progress-bar seek: TRUE for single-song & multiple-songs,
FALSE otherwise), `getAttachedLibraries()`. `MultipleSongs` and `SimpleBlackPlaylist` also override
`processAlbumArtUrl()` to substitute a hard-coded transparent 1×1 PNG data URI when album art is empty.
`VisualizationPlayer` overrides `getVisualizations()` (returns `visualization => 'michaelbromley_visualization'`,
`visualizations => ['MichaelBromleyVisualization']`).

## Enable / select

1. Enable `amplitudejs` + `amplitudejs_formatters` and install the AmplitudeJS JS asset (see the
   parent module's library doc).
2. On an entity's **Manage display**, pick one of the seven players as the formatter for an
   entity-reference (media) field or a core file field.
3. Open the formatter settings gear and set the token patterns below.

Typical setup: a Media reference field to an `audio` media type carrying an MP3 file field plus
optional text fields for name/artist/album and an image field for art. File fields work too — set
the audio field to `[file:url]`.

## Settings (`PlayerBase::defaultSettings()` + `settingsForm()`)

Five plain textfields, each a token pattern:

| Setting key | Form label | Default |
| --- | --- | --- |
| `audio_field` | Audio file field name | `[media:field_media_audio_file]` |
| `title_field` | Title field name | `[media:name]` |
| `artist_field` | Artist field name | `''` |
| `album_art_field` | Album Art field name | `''` |
| `album_field` | Album field name | `''` |

If the `token` module is enabled, the form adds a `token_tree_link` (`#theme`) browser scoped to the
reference target type and the parent entity type. `settingsSummary()` echoes the five values.
There is **no** `config/schema` in the module; these live as standard formatter settings.

Example patterns (from README): audio `[media:field_audio:entity:url]`, title `[media:name]`,
album art original `[media:field_image:entity:url]` or styled `[media:field_image:STYLE:url]`.

## Rendering (`PlayerBase::viewElements()`)

1. `getEntitiesToView($items, $langcode)` — so **core entity/field access is honored** (unpublished
   / inaccessible referenced entities are dropped).
2. For each referenced entity, `replaceTokenWithValues()` calls `token->replace()` with token type =
   the field's target type and the parent entity type, `clear => TRUE`, and a **callback**
   `PlayerBase::editTitleToken`. That callback runs every resolved token value through
   `Xss::filter(Html::decodeEntities($value))` before it is used.
3. Builds a `$song` stdClass per entity (`name`, `artist`, `album`, `url`, `cover_art_url`; plus
   `visualization` for the Visualization Player). Entities whose resolved audio url is `''` are
   skipped. `cover_art_url` passes through `processAlbumArtUrl()` (placeholder for two skins).
4. Emits a render array `#theme => <skin>`, with `#has_songs`, `#html_id`, `#songs`, `#module_path`
   (`extension.list.module`→getPath). Cacheability: a `BubbleableMetadata` collects the parent and
   each referenced entity as cache dependencies and is applied to the render array.
5. Attaches the songs and player metadata to **`drupalSettings.amplitudejs_formatters[<html_id>]`**
   (`songsObject`, `addClickHandler`, `theme`, `visualization`, `visualizations`) and the skin's CSS
   library via `#attached`.

## Templates & output safety

Twig templates in `templates/` emit static player scaffolding keyed by `html_id`; AmplitudeJS fills
values at runtime from `drupalSettings` via `data-amplitude-song-info="name|artist|album|cover_art_url"`
attributes. Where a template prints a value directly (e.g. `blue-playlist.html.twig`'s
`{{ song.name }}` / `{{ song.artist }}` in the right-hand list) it relies on Twig autoescaping; the
value was additionally `Xss::filter`ed in step 2. No template uses `|raw`. `module_path` is used only
to build image `src` paths to the module's own `img/` assets.

## Init JavaScript (`js/amplitudejs-players-init.js`)

`Drupal.behaviors.amplitudejs_formatters` iterates `drupalSettings.amplitudejs_formatters`. For each
player id it builds an AmplitudeJS config (`songs`, one `playlists` entry keyed by the player id,
`waveforms.sample_rate: 50`, `volume: 100`) and calls `Amplitude.init()` the first time, or
`Amplitude.addPlaylist()` + `Amplitude.bindNewElements()` for subsequent players. It wires a global
`window.onkeydown` so spacebar toggles the active player (suppressed while focus is in an
`input`/`textarea`), an optional progress-bar seek click handler when `addClickHandler` is set, and
per-skin UI event handlers (blue hover styling, flat-black/white slide panels, visualization toggle).
For the Visualization Player it maps each configured visualization name to `window[<name>]`, which is
provided by the external `michaelbromley_visualizations` library.

## Visualization Player note

Its `amplitudejs_visualization_player` library depends on library `michaelbromley_visualizations`,
declared in `amplitudejs_formatters.libraries.yml` as an **external** script loaded from
`https://521dimensions.com/img/open-source/amplitudejs/visualizations/michaelbromley.js`
(`type: external`). It is only attached by this one skin. The URL is hard-coded in the module (not
configurable and not request-derived).
