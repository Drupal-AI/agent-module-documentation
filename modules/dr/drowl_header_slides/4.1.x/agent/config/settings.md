<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object, hooks & update path

## Install / enable

```bash
composer require drupal/drowl_header_slides   # pulls fences, slick, drowl_media, menu_item_extras, views_linkarea
drush en drowl_header_slides -y
```

The module cannot enable unless the DROWL media stack is present: its config install references
`media.type.slideshow` and `media.type.slide` (the "Slide" media bundle from
`drowl_media` / `drowl_media_types`). Enabling installs three fields, three views and the settings
object below.

## Settings form

`src/Form/DrowlHeaderSlidesSettingsForm.php` (`DrowlHeaderSlidesSettingsForm extends ConfigFormBase`),
form id `drowl_header_slides_settings`.

- Route `drowl_header_slides_settings` (`.routing.yml`): path `/admin/config/system/drowl-header-slides`,
  `_form` = the class, `_permission: 'access drowl_header_slides settings'`.
- Menu link `drowl_header_slides_settings` (`.links.menu.yml`) under `system.admin_config_content`
  (Configuration → Content). `info.yml` sets `configure: drowl_header_slides_settings`.
- The form has one field: **`menus`** — a required multi-select of all `Menu` entities
  (`Menu::loadMultiple()`), default `['main']`. Its `#description`: "Select the menus to watch for
  header images."
- Note: `getEditableConfigNames()` returns `[]`; `submitForm()` writes with
  `$this->configFactory->getEditable('drowl_header_slides.settings')->set('menus', ...)`. A source
  `@todo` warns that with several selected menus the "wrong" menu's trail may win (see the block doc).

## Config object

`config/install/drowl_header_slides.settings.yml`:

```yaml
menus:
  main: main
```

Single key `menus` (array of menu machine names). There is **no `config/schema/`** in this module
(`provides_config_schema` = false), so strict config-schema tooling may flag this object.

## Permission

`.permissions.yml` — `access drowl_header_slides settings` (`restrict access: TRUE`), title
"Access DROWL Header Slides settings". Gates only the settings route above.

## Hooks (`drowl_header_slides.module`)

- `hook_views_pre_render()` — when the rendered view id is `admin_media_slideshow_overview`
  (the pre-4.x admin view id), attaches library `drowl_media/admin_media_library` so media
  previews render. (The current admin view id is `drowl_header_slides_admin_media_slideshow`, so on
  4.x sites this is effectively a legacy no-op.)
- `hook_block_build_alter()` — for the four views blocks
  `views_block:drowl_header_slideshow_fallback-block_{viewport,page}_width` and
  `views_block:drowl_headerslides_slideshow_ref-block_{viewport,page}_width`, sets
  `$build['#create_placeholder'] = FALSE`. This disables lazy/placeholder rendering so the module
  can tell whether a slideshow is empty and fall back (issue #3534195).

## Update hooks (`drowl_header_slides.install`)

- `update_8001` — set `drowl_header_slides.settings:menus` to `['main']`.
- `update_8002` — remove the `status` (published) filter from the `default` display of view
  `drowl_headerslides_slideshow_ref`.
- `update_8003` — delete legacy view `admin_media_slideshow_overview` and import
  `drowl_header_slides_admin_media_slideshow` from `config/install`.

## Features

`drowl_header_slides.features.yml` marks the module `required: true` for Features and excludes a
set of metatag/block/menu-display configs from being managed by it.
