<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base configuration: settings form, config object, schema

## Install & enable

```bash
composer require drupal/drowl_paragraphs_bs
drush en drowl_paragraphs_bs -y
```

The base module has many hard dependencies (Paragraphs, Layout Paragraphs, `ui_styles_paragraphs`,
Field Group, Fences, `twig_tweak`, `drowl_layouts_bs`, `drowl_media`, `micon`, `entity_reference_display`,
core `media`/`responsive_image`) plus the composer-only `webksde/drowl_base` theme package and
`photoswipe`. Enabling the base module alone provides no Paragraph bundles — enable the bundle
sub-modules you need (see [../api/behaviors.md](../api/behaviors.md) for the bulk Drush installer).

## Settings form

- Route `drowl_paragraphs_bs.settings` → `/admin/config/system/drowl-paragraphs-bs/settings`
  (`drowl_paragraphs_bs.routing.yml`), title "DROWL Paragraphs for Bootstrap".
- Permission: **`access drowl_paragraphs_bs settings`** (`drowl_paragraphs_bs.permissions.yml`,
  `restrict access: TRUE`).
- Menu link under *Configuration → Content* (`drowl_paragraphs_bs.links.menu.yml`, parent
  `system.admin_config_content`).
- Form class `\Drupal\drowl_paragraphs_bs\Form\DrowlParagraphsBsSettingsForm` (extends `ConfigFormBase`).
  `getEditableConfigNames()` returns `[]`; the form nevertheless writes the whole `defaults` tree to the
  config object in `submitForm()` via `configFactory->getEditable('drowl_paragraphs_bs.settings')`.

## Config object `drowl_paragraphs_bs.settings`

Install defaults (`config/install/drowl_paragraphs_bs.settings.yml`), schema
`config/schema/drowl_paragraphs_bs.schema.yml` (type `config_object`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `defaults.layout_slideshow.layout_section_width` | string | `viewport-width-cp` | Section width: `page-width`, `viewport-width`, or `viewport-width-cp` (background only). Required. |
| `defaults.layout_slideshow.autoplay` | bool | `true` | Auto-advance the slideshow. |
| `defaults.layout_slideshow.auto_height` | bool | `true` | Adjust height per slide on scroll. |
| `defaults.layout_slideshow.navigation_arrows` | bool | `true` | Show prev/next arrows. |
| `defaults.layout_slideshow.navigation_dots` | bool | `true` | Show dot navigation. |
| `defaults.layout_slideshow.infinite` | bool | `true` | Loop back to the first slide. |
| `defaults.layout_slideshow.center_mode` | bool | `true` | Centered view with cropped neighbors (use an odd visible count). |
| `defaults.layout_slideshow.controls_outside` | bool | `true` | Render controls outside the slider. |
| `defaults.layout_slideshow.visible_elements_sm` | int | `1` | Visible slides on small devices (1–10). |
| `defaults.layout_slideshow.visible_elements_md` | int | `2` | Visible slides on medium devices. |
| `defaults.layout_slideshow.visible_elements_lg` | int | `3` | Visible slides on large devices. |
| `defaults.breakpoint_sizes.md` | int | `768` | Pixel value at which "medium" applies. |
| `defaults.breakpoint_sizes.lg` | int | `1024` | Pixel value at which "large" applies. |

These are site-wide defaults for the Layout Slideshow bundle and the breakpoint pixel values used by the
frontend behavior. Per-Paragraph styling (animations, classes, id, equal-height) is stored on the
`field_settings` field instead — see [../fields/settings-field.md](../fields/settings-field.md).

The schema file also declares `field.value.drowl_paragraphs_bs_settings` (the 23 stored properties of the
settings field) and `field.widget.settings.drowl_paragraphs_bs_settings_default` (the widget's single `open`
boolean).
