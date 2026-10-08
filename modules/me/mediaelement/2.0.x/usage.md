MediaElement.js integrates the [MediaElement.js](https://www.mediaelementjs.com/) player as Drupal video and audio field formatters (extending core's file media formatters), with a global settings form for the library source and default player dimensions.

---

The module adds two field formatters for `file` fields — `mediaelement_file_video` (extends core
`FileVideoFormatter`) and `mediaelement_file_audio` (extends core `FileAudioFormatter`) — via a shared
`MediaElementFieldFormatterTrait` that adds `preload` (auto/metadata/none), a `download_link` toggle and
`download_text`, and attaches the `mediaelement/mediaelement_<source>` library plus the `mediaelementjs`
class. The video formatter additionally offers a **poster image** built from another image field on the
same bundle, rendered at a chosen image style. A global config form (`mediaelement.config`,
`/admin/config/media/mediaelement/config`, permission *administer mediaelement*) chooses the **library
source** — `local` (self-hosted at `/libraries/mediaelement/build`) or `cdnjs` (CDN, with a version
picker whose options are fetched live from the CDNJS API) — and sets an *attach sitewide* switch, a
class prefix, and default/override width & height for video and audio. `hook_library_info_build()`
builds the CDN library dynamically for the selected version; `hook_preprocess_html()` flattens and
camel-cases the global settings into `drupalSettings.mediaelement`, wires the `iconSprite` URL, and —
when *attach sitewide* is on — loads the player globally so every `<audio>`/`<video>` tag is upgraded.
Ships a config schema and a D7→D8 formatter migration map (`hook_field_migration_field_formatter_info`).
The default config sets `library_source: local` and `attach_sitewide: 0`, so you must supply the
library locally or switch to the CDN before players work.

---

- Play a local video `file` field with the MediaElement.js player.
- Play a local audio `file` field with the MediaElement.js player.
- Serve the player library from a self-hosted `/libraries/mediaelement/build` copy (default).
- Serve the player library from the CDNJS CDN, choosing a specific version from the live version list.
- Enable the player sitewide so any raw `<audio>`/`<video>` HTML tag is upgraded automatically.
- Set the `preload` behavior (auto / metadata / none) per field to control initial loading.
- Add a download link (with custom link text) beneath a video or audio player.
- Show a poster/thumbnail image on a video, sourced from another image field on the same bundle.
- Render the poster at a chosen image style (or the original image).
- Set default player width/height used when the media tag omits dimensions.
- Force override width/height for video or audio players.
- Apply a CSS class prefix to player elements (e.g. `mejs__`).
- Set dimensions via JS instead of CSS where needed.
- Provide consistent HTML5 audio/video playback with a skinned player across browsers.
- Add a download button for accessible/offline access to media files.
- Configure separate player settings per view mode of the same file field.
- Migrate Drupal 7 `mediaelement_video`/`mediaelement_audio` formatters to their D8+ equivalents.
- Restrict player configuration to trusted users via the *administer mediaelement* permission.
- Use the player as a lightweight alternative to the full Media module for simple file fields.
- Pin the CDN library to a known-good version for reproducible deployments.
