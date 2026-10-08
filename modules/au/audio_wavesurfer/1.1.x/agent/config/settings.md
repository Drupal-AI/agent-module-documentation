<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & library loading

## Install / enable

```
composer require drupal/audio_wavesurfer
drush en audio_wavesurfer -y
```

Requires core **`media`**. No config schema/install ships — the config object
`audio_wavesurfer.settings` is created only when you save the settings form (defaults are read with
`->get()` and are `NULL` until then, so the form's `#default_value`s start empty). FFmpeg (the
`ffprobe`/`ffmpeg` binaries) is required **only** for the optional Waveform Storage feature.

## Settings form

`AudioWavesurferForm` (`src/Form/AudioWavesurferForm.php`, extends `ConfigFormBase`),
form id `audio_wavesurfer_settings`.

- Route **`audio_wavesurfer.settings`** → `/admin/config/audio_wavesurfer/settings`
  (`audio_wavesurfer.routing.yml`), requirement `_permission: 'administer site configuration'`.
- Menu link `audio_wavesurfer.overview_types` under `system.admin_config_media`
  (`audio_wavesurfer.links.menu.yml`).
- Editable config: `audio_wavesurfer.settings` (`getEditableConfigNames()`).

The form is grouped in vertical tabs and writes these keys on submit:

| Config key (nested) | Form element | Notes |
|---|---|---|
| `color_options.waveform_color` | `#type => color` | waveform bar color |
| `color_options.progress_color` | `#type => color` | played-portion + play button bg |
| `color_options.cursor_color` | `#type => color` | hover cursor line |
| `bar_options.bar_width` | `#type => number` (px) | wavesurfer `barWidth` |
| `bar_options.bar_gap` | `#type => number` (px) | wavesurfer `barGap` |
| `bar_options.bar_radius` | `#type => number` (px) | wavesurfer `barRadius` |
| `waveform_options.waveform_storage` | `#type => checkbox` | pre-generate peaks on media save (needs FFmpeg) |
| `waveform_options.waveform_points` | `#type => number`, `#max => 2000` | sample points for stored peaks |
| `waveform_options.waveform_usage` | `#type => checkbox` | front end uses the stored peaks |
| `library_path` | `#type => textfield` | local wavesurfer dist path; blank = CDN |

`submitForm()` re-groups the flat form values into the three nested arrays (`color_options`,
`bar_options`, `waveform_options`) plus `library_path`, then `->save()`.

## Library loading (CDN vs local)

`hook_library_info_build()` in `audio_wavesurfer.module` builds the `wavesurfer` library at runtime:

- `$library_path = config('audio_wavesurfer.settings').library_path` or, when empty, the default
  **`https://cdn.jsdelivr.net/npm/wavesurfer.js@7/dist`**.
- It registers `js/wavesurfer_library.js` plus two **external** ES modules:
  `$library_path/wavesurfer.esm.js` and `$library_path/plugins/hover.esm.js` (`type: external`,
  `attributes: {type: module}`).
- `hook_page_attachments()` also exposes `drupalSettings.audio_wavesurfer.library_path`, which
  `js/wavesurfer_library.js` uses to `import()` the ESM build dynamically.

To self-host: `npm install --save wavesurfer.js`, then set `library_path` to the directory that
contains `wavesurfer.esm.js` and `plugins/regions.esm.js` (README example). Leave blank to use the CDN.

## Waveform Storage prerequisites

Waveform Storage calls `ffprobe`/`ffmpeg` via `shell_exec` (see [../api/waveform-service.md](../api/waveform-service.md)).
Install FFmpeg on the host (e.g. Alpine: `apk add --no-cache ffmpeg`). Without it, peak generation
produces empty output.
