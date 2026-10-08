<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "DLF AIM 3D Viewer" field formatter

Two formatter plugins in `src/Plugin/Field/FieldFormatter/`:

- **`DlfAim3DViewerFormatter`** — id `dlf_aim_3d_viewer`, label *"DLF AIM 3D Viewer"*,
  `field_types = { "file" }`, extends core `FileFormatterBase`. Renders the interactive viewer.
- **`DlfAim3DDerivativeLinkFormatter`** — companion formatter that exposes the converted
  derivative as a link (same `file` field type).

## Install & enable

```bash
composer require drupal/dlf_aim_3d_viewer
drush en dlf_aim_3d_viewer -y
```

Then install the viewer JS library to `web/libraries/dlf_aim_3d_viewer/` (the module's
`.libraries.yml` points `dlf_aim_3d_viewer.viewer` at
`/libraries/dlf_aim_3d_viewer/dist/drupal/main/dlf_aim_3d_viewer.min.js`, loaded as an ES module).
Only core `field` is a hard dependency.

## Enable it on a field

Add/choose a **File** field on a bundle, then *Structure → (bundle) → Manage display* → set that
field's format to **DLF AIM 3D Viewer**. `defaultSettings()`/`settingsForm()`/`settingsSummary()`
only defer to `FileFormatterBase` — the formatter itself has **no per-formatter settings**; all
behavior comes from the `dlf_aim_3d_viewer.settings` config object (see
[../config/settings.md](../config/settings.md)).

## How `viewElements()` resolves the model path

For each rendered item the formatter picks the model source in this order:

1. **Derivative field first.** It reads the config key
   `dlf_aim_3d_viewer_viewer_file_name` (the "viewer file name" / converted-model field). If the
   entity has that field and it holds values, `extractViewerPathsFromFieldValues()` produces the
   viewer paths (the converted GLB). This is the normal path once conversion has run.
2. **Fallback to the field's own uploaded files.** If no derivative values, it calls
   `getEntitiesToView($items, $langcode)` (so **core file access / the display flag are honored**)
   and, per file, builds a URL from `file_url_generator` (`generateString` / `generateAbsoluteString`).
   A configured `dlf_aim_3d_viewer_basenamespace` (must be an absolute URL with a real host) can
   prefix the relative path; otherwise it uses the absolute URL, except when the host looks like a
   container placeholder (`_` in host or host `default`), in which case it falls back to the
   relative path. `resolveViewerPath()` applies the same host-sanity logic to stream-wrapper URIs.

If nothing resolves, `viewElements()` returns an empty render array.

## What it emits

When there is at least one path, the formatter:

- attaches the library `dlf_aim_3d_viewer/dlf_aim_3d_viewer.viewer` (via
  `dlf_aim_3d_viewer_get_library()`),
- calls `dlf_aim_3d_viewer_attach_settings($elements)` which puts the full JS settings object
  (`dlf_aim_3d_viewer_build_js_settings()`) into `drupalSettings.dlf_aim_3d_viewer` and adds a REST
  CSRF token (`\Drupal::csrfToken()->get('rest')`) both into settings and as a `window.CSRF_TOKEN`
  inline script,
- renders one `html_tag` `<p>` per delta with `id = <container>` (config
  `dlf_aim_3d_viewer_container`, default `DLF_AIM_3DViewer`) and a custom attribute `3d` holding the
  resolved path. The JS library reads those to mount the scene.

## Notes

- The model path is put into an HTML attribute via Drupal's render array, so it is attribute-escaped
  by the renderer.
- The formatter logs (notice level) which field it used per entity — expect chatty `dlf_aim_3d_viewer`
  channel logging.
- It uses `getEditable()` merely to read config; it does not write. Displaying the viewer does not
  require conversion — in lightweight mode you simply serve the uploaded model directly.
