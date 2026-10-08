<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, route, permission & FieldValuesProvider

## Route & permission

- Route `drowl_media_types.settings` (`drowl_media_types.routing.yml`):
  `GET /admin/config/media/drowl-media-types-settings`, `_form:
  Drupal\drowl_media_types\Form\DrowlMediaTypesSettingsForm`, requirement
  `_permission: 'administer drowl media types settings'`.
- Permission `administer drowl media types settings` (`drowl_media_types.permissions.yml`) —
  `restrict access: TRUE` (admin-level). Menu link under *Configuration → Media*
  (`drowl_media_types.links.menu.yml`). This is the module's only route.

## Config object `drowl_media_types.settings`

Schema `config/schema/drowl_media_types.schema.yml` (a `config_object`). Install defaults in
`config/install/drowl_media_types.settings.yml`:

```yaml
defaults:
  slide:
    image_animation: NULL          # ken-burns | (none)
    overlay_button_color: dark     # light | dark
    overlay_button_style: regular  # regular | hollow
    overlay_display: light         # light|dark|light-glass|dark-glass|transparent-light|transparent-dark|primary|secondary
    overlay_position(_md/_lg): disabled   # disabled|top-left…bottom-right
    overlay_sizing(_md/_lg): seperate-box # seperate-box | full-size (small default full-size)
  slideshow:
    slide_arrows: default          # default | 1 | 0
    slide_autoplay: default
    slide_dots: default
    slide_height: auto             # limited | auto | viewport
    slide_infinite: default
```

## Settings form

`DrowlMediaTypesSettingsForm` (`src/Form/DrowlMediaTypesSettingsForm.php`), a `ConfigFormBase`
editing only `drowl_media_types.settings` (form id `drowl_media_types_drowl_media_types_settings`).
It renders `select` elements grouped as *Slide* (image animation; overlay display/button color/
button style; small/medium/large device overlay position + sizing in vertical tabs) and *Slideshow*
(height, autoplay, arrows, dots, infinite), each populated from `DrowlMediaTypesFieldValuesProvider`.
`submitForm()` writes the chosen values back into the `defaults.slide.*` / `defaults.slideshow.*`
keys. Note the small-device values map from form keys `overlay_position_small` /
`overlay_sizing_small` to config keys `overlay_position` / `overlay_sizing`.

## DrowlMediaTypesFieldValuesProvider

`src/DrowlMediaTypesFieldValuesProvider.php` — a static utility referenced both by the form and by
the slide/slideshow field storage/config (wired by update hook `drowl_media_types_update_8007`).

- **allowed-values callbacks** (`settings.allowed_values_function`): `getImageAnimationValues`,
  `getOverlayButtonColorValues`, `getOverlayButtonStyleValues`, `getOverlayDisplayValues`,
  `getOverlayPositionValues`, `getOverlaySizingValues`, `getSlideYesNoValues`,
  `getSlideHeightValues`. Each returns a fixed map of machine value → `TranslatableMarkup` label.
- **default-value callbacks** (`default_value_callback`): `get*DefaultValue()` — each simply reads
  the matching `drowl_media_types.settings:defaults.slide|slideshow.*` value, so a new slide/
  slideshow field pre-fills with the site default configured in the form.

All values are fixed enum strings defined in code; there is no free-text or user-supplied value
handling here.
