<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Back-2-Top — settings, route & JS wiring

Everything the module does is driven by one config object and one page-attachments hook. No blocks, plugins, services, or entities are involved.

## Install / enable
- `drush en back_2_top -y`. Default config (`config/install/back_2_top.settings.yml`) ships the button **already enabled** (`enabled: true`, `show_on_admin: true`, `position: bottom-right`, `color: '#007cba'`, `opacity: 0.8`, `size: 50`, `image_type: triangle`, `custom_image: null`).
- Uninstall deletes any uploaded custom image: `back_2_top_uninstall()` in `back_2_top.install` loads `custom_image` fid and calls `$file->delete()`. Drupal removes the config object itself.

## Route & permission
- `back_2_top.routing.yml`: route `back_2_top.settings`, path `/admin/config/user-interface/back-2-top`, `_form: '\Drupal\back_2_top\Form\Back2TopSettingsForm'`, requirement `_permission: 'administer site configuration'`.
- Menu link `back_2_top_settings` (`back_2_top.links.menu.yml`) under parent `system.admin_config_ui`; local task in `back_2_top.links.task.yml`.
- The module declares **no** `*.permissions.yml` — it reuses the core `administer site configuration` permission only.

## Config object `back_2_top.settings`
Schema: `config/schema/back_2_top.schema.yml` (`type: config_object`). Keys:

| key | type | notes |
|-----|------|-------|
| `enabled` | boolean | master on/off; when false the hook returns early and nothing is attached |
| `position` | string | `bottom-left` \| `bottom-center` \| `bottom-right` — becomes a CSS class on the button |
| `color` | string | hex color; form uses a `#type => color` picker; applied as `button.style.backgroundColor` |
| `opacity` | float | form range 0.1–1.0 (used by CSS/theme) |
| `size` | integer | form range 20–100; applied as `button.style.width`/`height` in px |
| `image_type` | string | `triangle` \| `chevron` \| `arrow` \| `custom` |
| `custom_image` | integer | managed-file fid, or null |
| `show_on_admin` | boolean | when false, the button is suppressed on admin routes |

## Settings form — `Back2TopSettingsForm`
`src/Form/Back2TopSettingsForm.php`, extends `ConfigFormBase`; `getFormId()` = `back_2_top_settings`; `getEditableConfigNames()` = `['back_2_top.settings']` (so it is CSRF-protected and permission-gated like any core config form).

- `buildForm()` renders the checkbox/select/color/number widgets above, plus a `managed_file` element `custom_image` (`#upload_location => 'public://back_2_top/'`, validators `file_validate_extensions => ['png jpg jpeg gif svg']` and `file_validate_size => [2MB]`), shown only when `image_type == custom` via `#states`.
- `submitForm()`: when `image_type === 'custom'` and a file was uploaded, it loads the file, marks it permanent (`$file->setPermanent(); $file->save();`) and stores its fid in `custom_image`; then saves all values to config.

## How the JS receives config
- `back_2_top_page_attachments(array &$attachments)` in `back_2_top.module`:
  1. returns early if `!enabled`;
  2. returns early on admin routes (`router.admin_context`->`isAdminRoute()`) unless `show_on_admin`;
  3. attaches library `back_2_top/back_to_top`;
  4. sets `$attachments['#attached']['drupalSettings']['back2Top']` = `{ position, color, opacity, size, image_type, custom_image }` (each with a hardcoded fallback).
- `back_2_top.libraries.yml` defines `back_to_top` → `js/back_2_top.js` + `css/back_2_top.css`.
- `js/back_2_top.js` (`Drupal.behaviors.back2Top`): initialises once (only when `context === document` and no existing `.back-2-top`), builds a `<button class="back-2-top {position}">` with `aria-label`/`title` "Back to top", applies size/color via element `.style`, and appends a glyph `<div>` (`triangle`/`chevron`/`arrow`) or, for `custom`, an `<img>` whose `src` is `'/sites/default/files/back_2_top/' + fileId`. A passive scroll/resize listener toggles the `.visible` class once `documentHeight > innerHeight` and scrollTop exceeds one viewport; click runs a 500 ms ease-out `window.scrollTo` animation.

## Operating notes
- To theme the button, target `.back-2-top` (and child `.arrow` / `.chevron` / `.triangle` / `.custom-image`) in your theme CSS; the module's own CSS is low-specificity.
- The custom-image URL in JS assumes the public files path `sites/default/files/…`; sites with a non-default file scheme/path may need the built-in glyphs instead.
