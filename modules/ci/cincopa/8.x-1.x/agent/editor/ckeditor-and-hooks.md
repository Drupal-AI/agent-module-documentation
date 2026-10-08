<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editor buttons, route & hooks (legacy)

Everything here targets Drupal 9's CKEditor 4 and is **inert on Drupal 10/11** (CKEditor 5;
the D7-era `ckeditor` module that defined the `CKEditorPlugin` plugin type is not present).
The `filters/cincopa-filter.md` tag filter is the working path on modern core.

## CKEditor 4 plugins

- `Drupal\cincopa\Plugin\CKEditorPlugin\Cincopagallery` (`@CKEditorPlugin` id
  `cincopagallery`, label "Cincopa New Gallery") — toolbar button `Cincopagallery`; JS at
  `js/plugins/cincopagallery/plugin.js`; empty config/libraries.
- `Drupal\cincopa\Plugin\CKEditorPlugin\Cincopaselgallery` (id `cincopaselgallery`,
  label "Cincopa Gallery") — dropdown-style button `Cincopaselgallery`; JS at
  `js/plugins/cincopaselgallery/plugin.js`.
- Both extend `CKEditorPluginBase` / `CKEditorPluginConfigurableInterface` with no-op
  `settingsForm()`, `isInternal()` returning FALSE, `getFile()` returning the plugin.js path.
- `cincopa_ckeditor_plugin_info_alter()` in `cincopa.module` also registers the two plugins.

## Route

`cincopa.gallery_dialog` (`cincopa.routing.yml`):
- Path `/cincopa/dialog/gallery/{filter_format}`, controller
  `Drupal\cincopa\Controller\CincopaGallery::content`, title "Insert Media from Cincopa",
  option `_theme: ajax_base_page`, requirement `_permission: 'access content'`.
- The controller returns a render array `['#theme' => 'cincopa', '#url' =>
  'https://www.cincopa.com/media-platform/start.aspx']` — a read-only info dialog that
  surfaces a link to Cincopa's "start" page. It performs no data mutation and takes no
  user-supplied input.

## Hooks (`cincopa.module`)

- `cincopa_theme()` — defines the `cincopa` theme hook (`variables: url, login_url, data`).
- `cincopa_element_info_alter()` — attaches `cincopa/cincopa.gallery` library to the
  `toolbar` element.
- `cincopa_theme_registry_alter()` — sets `status_messages`' `function` to
  `_custom_cincopa_messages`, which (for users with "View the administration theme" on an
  admin route, absent the `cincopa_help_close` cookie) renders a one-time welcome/help
  banner linking to `https://www.cincopa.com/drupal/welcome`. On Drupal 10/11 the renderer
  ignores the deprecated `function` implementation and uses the core `status-messages`
  template, so normal status/error messages render unaffected and the banner does not show.

## Dead code

`src/Form/EditorCincopagalleryDialog.php` is **not** referenced by any route or service. Its
`submitForm()` calls an undefined `ImagePopup::render()` (copied from the image_popup
module) and would fatal if ever invoked; it is not reachable in this project.
