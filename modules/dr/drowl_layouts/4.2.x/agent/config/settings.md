<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings page, permission, libraries & hooks

## Install / enable

`composer require drupal/drowl_layouts` (pulls `drupal/twig_real_content`), then
`drush en drowl_layouts -y`. Core `layout_discovery` + `layout_builder` are hard dependencies.
`hook_update_8401` (`drowl_layouts.install`) throws an `UpdateException` if `twig_real_content`
is not enabled when running database updates. Use a ZURB Foundation 6 theme (suggested
`drupal/foundation_sites`) for the shipped grid classes to render.

## Route, permission, menu

- Route `drowl_layouts_settings` (`drowl_layouts.routing.yml`): `GET /admin/config/system/drowl-layouts`,
  `_form: \Drupal\drowl_layouts\Form\DrowlLayoutsSettingsForm`, title "DROWL Layouts".
  Requirement: `_permission: 'access drowl_layouts settings'`.
- Permission `access drowl_layouts settings` (`drowl_layouts.permissions.yml`): title "Access DROWL
  Layouts settings", `restrict access: TRUE`.
- Menu link `drowl_layouts_settings` (`drowl_layouts.links.menu.yml`) under
  `system.admin_config_content`. Also referenced as the `configure` route in `.info.yml`.
- **The form is a placeholder.** `DrowlLayoutsSettingsForm extends ConfigFormBase`,
  `getEditableConfigNames()` returns `[]`, `buildForm()` only sets `#tree = TRUE` and calls parent —
  it renders just the core "Save configuration" button and writes **no config**. All real
  configuration is per-section, on the layout plugins (see [../plugins/layouts.md](../plugins/layouts.md)).

## Libraries (`drowl_layouts.libraries.yml`)

- `global` — `css/drowl_layouts.global.min.css` (front-end base).
- `dynamic_grid` — `css/drowl_layouts.dynamic_grid.min.css`; attached automatically by
  `hook_preprocess_layout` only for the `drowl_layouts_dynamic_content_grid` layout.
- `admin` — grid + settings CSS and `js/drowl_layouts_settings.js`; deps `core/drupal`, `core/jquery`,
  `drowl_layouts/admin_preview_styles`. Attached to `entity_view_display_layout_builder_form` and
  `layout_builder_configure_section` forms via `hook_form_alter`.
- `admin_preview_styles` — the settings-preview CSS.
- `layout_paragraphs_admin` — Layout Paragraphs UI CSS (assumes `layout_paragraphs:^2`); dep on `admin`.

## Hooks (`drowl_layouts.module`)

- `hook_form_alter` — attaches `drowl_layouts/admin` to the two Layout Builder config forms above.
- `hook_library_info_alter` — if a `layout_paragraphs_admin` library exists, looks up
  `<default_theme>/drowl_layouts_layout_paragraphs_additions` via the `library.discovery` service and, if
  present, adds it as a dependency. This is the documented theme hook: define that library in your theme
  to inject preview CSS/JS into the Layout Paragraphs widget.
- `hook_theme` — registers the four `drowl_layouts_settings_preview_*` templates
  (cell_width, section_width, cell_alignment, grid_gutter) with a `module_images_dir_url` variable built
  from `\Drupal::request()->getSchemeAndHttpHost()` + module path + `/img/`.
- `hook_preprocess_paragraph` — for a Layout Paragraphs component in builder mode, sets
  `content.regions['#drowl_layouts_force_render'] = TRUE` (forces empty regions to render so editors see
  drop targets) and passes the paragraph `#view_mode` down to the contained layout.
- `hook_preprocess_layout` — attaches `drowl_layouts/dynamic_grid` for the dynamic-grid layout.

No services, no Drush, no config schema, no content/config entities of its own.
