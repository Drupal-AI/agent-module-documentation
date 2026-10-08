<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap (drowl_paragraphs_bs) — agent index

Paragraphs UX/UI enhancement toolkit for the DROWL / Radix Bootstrap 5 ecosystem. Version **4.2.51**
(version dir **4.2.x**). Core `^10.3 || ^11`. License GPL-2.0-or-later. Package *Paragraphs*.

The base module provides a shared per-Paragraph **settings field**, the **shared field storages** that its
23 bundle sub-modules reuse, one **admin settings form**, theme/preprocess glue, and a **Drush** installer.
Each pre-defined Paragraph bundle lives in its own sub-module (enable only what you need).

## Dependencies (info.yml)
`field`, `link`, `paragraphs`, `field_group`, `fences`, `layout_paragraphs`, `twig_tweak`,
`drowl_layouts_bs`, `drowl_media`, `ui_styles_paragraphs`, `media`, `micon`, `responsive_image`,
`entity_reference_display`. Composer also pulls `webksde/drowl_base` and `drupal/photoswipe`.
Suggested npm assets: `verge`, `drowl-admin-iconset`, `flipdown`, `progressbar.js`.

## What the base module provides
- **Field type/widget/formatter** `drowl_paragraphs_bs_settings` (+ `_default` widget/formatter) — per-Paragraph
  animations (4 slots), equal-height group, additional classes, custom id. See
  [fields/settings-field.md](fields/settings-field.md).
- **Config**: settings form `\Drupal\drowl_paragraphs_bs\Form\DrowlParagraphsBsSettingsForm` at
  `/admin/config/system/drowl-paragraphs-bs/settings`, config object `drowl_paragraphs_bs.settings`
  (slideshow defaults + breakpoint px). See [config/settings.md](config/settings.md).
- **Shared field storages** in `config/install/field.storage.paragraph.*` reused by bundle sub-modules
  (field_anchor_id, field_background_media, field_icon, field_image, field_image_zoomable, field_link,
  field_nodeentityrefvm, field_paragraphs, field_resp_imagestyle, field_settings, field_subtitle,
  field_text, field_title). See [fields/settings-field.md](fields/settings-field.md).
- **Behaviors** (`.module`): theme suggestions + preprocess for paragraphs/forms, attaches `drowl_paragraphs_bs/global`
  and `/admin` libraries, applies stored settings as HTML attributes, `hook_entity_extra_field_info()`
  preview placeholder, UI-Styles details tweaks, and a Drush command. See [api/behaviors.md](api/behaviors.md).

## Routes & permissions
- One route: `drowl_paragraphs_bs.settings` (settings form), guarded by permission
  `access drowl_paragraphs_bs settings` (`restrict access: TRUE`). No anonymous/callback/AJAX routes.

## Sub-modules (23 Paragraph bundles)
`anchor`, `attachments`, `block_content`, `button`, `card`, `countdown`, `entity_reference`, `gallery`,
`icon`, `image`, `image_text`, `layout`, `layout_restricted_access`, `layout_slideshow`, `markup`,
`score`, `simple_map`, `slideshow`, `tabs_accordion`, `text`, `video`, `view`, `webform` (each prefixed
`drowl_paragraphs_bs_type_`). Documented bundles have their own nested tree under `modules/<name>/4.2.x/`.

## Drush
- `drowl_paragraphs_bs:install-submodules` (alias `dpbs-install-sub`), option `--exclude=a,b` — bulk-installs
  every bundle sub-module found under `modules/`. See [api/behaviors.md](api/behaviors.md).
