<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site-wide settings: which extensions are audio vs video

## The form & route

- Form class `AudioVideoViewerSettingsForm` (`src/Form/AudioVideoViewerSettingsForm.php`,
  extends `ConfigFormBase`, injects `config.factory` + `messenger`). `getFormId()` =
  `audio_video_viewer_admin_settings`.
- Route **`audio_video_viewer.admin_settings`** → path
  **`/admin/config/user-interface/audio_video_viewer`**, title *"Audio Video Viewer Config"*,
  requirement `_permission: 'administer site configuration'`.
- Menu link `audio_video_viewer.admin_settings` (title *"Audio Video Viewer"*) under
  `system.admin_config_ui` (*Configuration → User interface*).

It is a normal Drupal `ConfigFormBase`, so it carries CSRF protection and is admin-gated.

## Config object `audio_video_viewer.settings`

`getEditableConfigNames()` = `['audio_video_viewer.settings']`. Install defaults
(`config/install/audio_video_viewer.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `supported_audio_extensions` | `"mp3 ogg wav"` | Space-separated extensions treated as audio. |
| `supported_video_extensions` | `"mp4 webm ogg"` | Space-separated extensions treated as video. |
| `allow_all_audio_extensions` | `false` | If TRUE, **every** file is eligible as audio (extension list bypassed). |
| `allow_all_video_extensions` | `false` | If TRUE, every file is eligible as video. |
| `use_cdn` | `cdn` | Present in install config but **not read** by any PHP in this module. |

The formatter (`AudioVideoViewer::viewElements()`) reads exactly these four extension/flag keys to
decide a file's type. The install file also declares `dependencies.enforced.module:
[audio_video_viewer]`. No `config/schema/` ships, so this object is schema-less.

## Form fields (`buildForm()`)

- `allow_all_video_extensions` (checkbox) — "render all files as video".
- `supported_video_extensions` (textarea) — visible only when *allow all video* is unchecked
  (`#states`).
- `allow_all_audio_extensions` (checkbox) — "render all files as audio".
- `supported_audio_extensions` (textarea) — visible only when *allow all audio* is unchecked.
- `reset` (submit, `#value` "Restore default supported extensions", `#submit` `::resetSubmit`).

`submitForm()` saves the four values into `audio_video_viewer.settings`. There is **no validation**
that the textareas contain sensible extensions (any text is stored and later `explode(" ", …)`d).

## Known bug: the "Restore defaults" button

`resetSubmit()` copies values from a config object **`audio_video_viewer.settings.default`**:

```php
$this->config('audio_video_viewer.settings')
  ->set('supported_video_extensions',
        $this->config('audio_video_viewer.settings.default')->get('supported_video_extensions'))
  … // and the other three keys
  ->save();
```

The module ships **no** `audio_video_viewer.settings.default` config, so
`->get(...)` returns `NULL` and the reset writes empty/undefined values rather than the documented
`mp3 ogg wav` / `mp4 webm ogg` defaults. To truly restore defaults, re-enter the values by hand or
reinstall the config, e.g.:

```bash
drush cset audio_video_viewer.settings supported_audio_extensions "mp3 ogg wav" -y
drush cset audio_video_viewer.settings supported_video_extensions "mp4 webm ogg" -y
drush cset audio_video_viewer.settings allow_all_audio_extensions 0 -y
drush cset audio_video_viewer.settings allow_all_video_extensions 0 -y
```

## Interaction with the formatter

- With both `allow_all_*` on, a file that matches both lists is disambiguated by its MIME-type
  prefix (`audio/…` vs `video/…`); a non-media MIME type degrades to a download link.
- Turning on "allow all" for **both** audio and video means every file is forced through MIME-type
  detection, so a PDF or image becomes a download link with a messenger error rather than a player.
