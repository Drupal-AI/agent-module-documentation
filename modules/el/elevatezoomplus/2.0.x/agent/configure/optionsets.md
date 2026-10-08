<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — optionsets & attaching zoom

## Optionset config entity
- Type: `ConfigEntityType` id `elevatezoomplus`, config prefix `elevatezoomplus.optionset`
  (`src/Entity/ElevateZoomPlus.php`). Files: `elevatezoomplus.optionset.<id>.yml`.
- Ships three (disabled, `status: false`): `default`, `inner`, `responsive`
  (`config/install/elevatezoomplus.optionset.*.yml`).
- Shape:
  ```yaml
  id: default
  label: Default
  weight: 10
  options:
    misc:
      lightbox: ''            # optional lightbox integration
    settings:                 # ez-plus library options (subset)
      responsive: false
      zoomType: window        # window | lens | inner
      zoomWindowWidth: 400
      zoomWindowHeight: 400
      zoomWindowOffsetX: 0
      zoomWindowOffsetY: 0
      zoomWindowPosition: '1'
      scrollZoom: false
      easing: false
      easingDuration: 2000
      showLens: true
      lensSize: 200
      lensShape: square
      lensBorder: 1
      lensColour: white
      lensOpacity: 0.4
      borderSize: 4
      # ...fade/tint flags, etc.
  ```
  Schema: `config/schema/elevatezoomplus.schema.yml`.

## Library
Install the third-party JS to `/libraries/elevatezoom-plus/src/jquery.ez-plus.js` (or the Composer
layout `/libraries/ez-plus/src/jquery.ez-plus.js`) — both are detected via
`hook_library_info_alter` (`ElevateZoomPlusManager::libraryInfoAlter`).

## How zoom is attached (no custom formatter)
ElevateZoom Plus does not add field formatters. You attach it on an existing **Blazy / Slick / Splide /
GridStack** formatter (Manage display) by choosing a lightbox/media-switcher plus an ElevateZoomPlus
optionset. The module injects that choice via Blazy hooks (see `api/integration.md`). Two patterns:
- **Slick/Splide with asNavFor** (main + thumbnail nav): works with any lightbox.
- **Without asNavFor, or Blazy Grid / GridStack**: use the **Image to ElevateZoomPlus** media switcher.

At render time `ElevateZoomPlusManager::getOptions()` builds the JS options and
`template_preprocess_elevatezoomplus()` (`elevatezoomplus.theme.inc`) writes them as
`data-elevatezoomplus="<json>"` on the element; the module JS reads that attribute to start ez-plus.

## Editing optionsets
There is no config form in this module — enable `elevatezoomplus_ui` for the list/add/edit/delete UI at
`/admin/config/media/elevatezoomplus`, or edit the `elevatezoomplus.optionset.*` config directly
(`drush cget/cset`, config import).
