<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

## Install / enable
`drush en background_wallpaper -y`. Only core `system` and `config` are required. Nothing else is scaffolded — no default config ships (no `config/install/*`), so `background_wallpaper.settings` starts empty until the form is saved.

## Route & access
`background_wallpaper.routing.yml`:
- `background_wallpaper.settings` → path `/admin/config/background-wallpaper`, `_form: \Drupal\background_wallpaper\Form\BackgroundWallpaperSettingsForm`, title "Background Wallpaper Settings".
- Requirement: `_permission: 'administer site configuration'` (core permission; no custom permission is defined by the module). There is no admin menu link or `configure:` key in the info file, so reach the form by its path directly.

## Form: `BackgroundWallpaperSettingsForm`
`src/Form/BackgroundWallpaperSettingsForm.php`, extends `ConfigFormBase`.
- `getFormId()` → `background_wallpaper_settings_form`.
- `getEditableConfigNames()` → `['background_wallpaper.settings']`.
- `buildForm()` defines two elements:
  - `background_image` — `#type: managed_file`, `#upload_location: 'public://background_wallpaper/'`, default from `background_image` config. Extension restriction is expressed as `#constraints => ['File' => ['extensions' => ['jpg','jpeg','png','gif']]]`.
  - `background_target` — `#type: select`, `#multiple: TRUE`, options from `getContentTypeOptions()`: every `NodeType` (id ⇒ label) plus an extra `front ⇒ "Front Page"` entry.
- `submitForm()` calls `parent::submitForm()` then saves `background_image` = the raw form value (array of file IDs) and `background_target` = `array_filter($form_state->getValue('background_target'))` into `background_wallpaper.settings`.

## Config object `background_wallpaper.settings`
No config schema ships (`provides_config_schema` is false — there is no `config/schema/` directory), so the object is untyped for export/translation purposes.
- `background_image`: array of managed-file IDs (the module reads `[0]` at render time).
- `background_target`: array of selected values; each is a node-type machine name or the literal `front`.

## Operating it
1. Upload one image (jpg/jpeg/png/gif) — it is stored under `public://background_wallpaper/` as a managed file.
2. Select one or more targets (content types and/or "Front Page").
3. Save. The wallpaper appears on matching pages (see `../api/rendering.md`).
4. To disable: remove the image or deselect all targets and save.
