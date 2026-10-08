<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Video Viewer (audio_video_viewer) — agent index

A single field formatter that renders a core **File** field's items with the browser's native
HTML5 `<audio>` / `<video>` player. Package *San Diego Supercomputer Center (SDSC)*. Needs core
**`file`** (targets `field_types = { "file" }`). Core requirement `^10 || ^11`. License
GPL-2.0-or-later. Version 1.1.0-beta1. No permissions of its own, no Drush, no config schema.

- **The formatter — every setting, the type-detection logic, the two Twig templates** →
  [fields/formatter.md](fields/formatter.md)
- **The site-wide extension settings form + `audio_video_viewer.settings` config** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `AudioVideoViewer` (id **`audio_video_viewer`**, label *"Audio Video Viewer"*), in
  `src/Plugin/Field/FieldFormatter/AudioVideoViewer.php`, extending core's `FileFormatterBase`.
  Injects `config.factory`, `messenger`, `file_system`, `file_url_generator`.
- One config form: `AudioVideoViewerSettingsForm` (`src/Form/…`) at
  **`/admin/config/user-interface/audio_video_viewer`** (route
  `audio_video_viewer.admin_settings`, permission **`administer site configuration`**; menu link
  under *Configuration → User interface*).
- Two theme hooks (`audio_video_viewer_theme()` in the `.module`): **`audio_tag`** and
  **`video_tag`**, templates `templates/audio-tag.html.twig` / `templates/video-tag.html.twig`.
- One CSS library `audio_video_viewer/audio_video_viewer.libraries` (`css/audio_video_viewer.css`),
  attached to **every admin/site form** via `hook_form_alter()` — it only styles the two labelled
  `<div>` boxes on the formatter settings form.
- Config object **`audio_video_viewer.settings`** (install defaults in `config/install/`): the
  supported-extension lists and the two "allow all" flags. No `config/schema/` ships.

## Mechanism (from source, `viewElements()`)

- Iterates `getEntitiesToView($items, $langcode)` (so core file access / display flags are
  honored). Resolves `file_system->realpath($file->getFileUri())` (only to check the file exists —
  a `FALSE` becomes a "server error" message) and builds the player `src` from
  `file_url_generator->generateAbsoluteString($file->getFileUri())` — i.e. the **managed file's own
  URI**, never a request- or config-supplied path.
- Type detection: the file's extension is matched against the site's `supported_audio_extensions`
  / `supported_video_extensions` lists (or bypassed by the `allow_all_*` flags); if an extension
  qualifies as **both**, the `audio`/`video` MIME-type prefix decides. Unknown type, over
  `max_file_size`, or an invalid configured width/height all fall back to a plain
  `<a href>` download link (or `return []` when *return_empty* is on).
- Recognised audio → `#theme => 'audio_tag'`; recognised video → `#theme => 'video_tag'`; the
  templates auto-escape all variables and emit `<source src=… type=…>` inside the player.

## Formatter settings (`defaultSettings()`)

`show_file_link` (0), `show_file_size` (0), `max_file_size` (0 = unlimited, validated ≥ 0 by
`validateSize()`), `return_empty` (0), `video_original` (1 = autofit), `video_width` (`320px`),
`video_height` (`240px`), `video_preload` (`metadata`), `audio_original` (1), `audio_width`
(`320px`), `audio_preload` (`metadata`). Width/height must match `\d+px` or `\d+%`
(`isValidWidthOrHeight()`). Full table in [fields/formatter.md](fields/formatter.md).

## Notes

- Version is `1.1.0-beta1`; `security_advisory_coverage: not-covered`.
- The settings form's **"Restore default supported extensions"** button reads from a config object
  `audio_video_viewer.settings.default` that the module does **not** ship, so reset writes empty
  values — see [config/settings.md](config/settings.md).
