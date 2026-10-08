<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter third-party settings & field rendering

Everything is driven from two hooks in `animate_fields_aos.module`. There is no config entity, no
route, and no settings page — animation config is stored as **per-formatter third-party settings** on
each entity view display.

## Install / enable
`drush en animate_fields_aos`. Configure at Manage Display of any Content/Media/Block type: click a
field's gear icon → open the **AOS Animations** details → check **Display Animations** → pick options →
Save → clear cache. Grant `edit animate fields formatter settings` to roles allowed to configure this.

## The settings form — `animate_fields_aos_field_formatter_third_party_settings_form()`
Implements `hook_field_formatter_third_party_settings_form()`. It first returns early unless
`\Drupal::currentUser()->hasPermission('edit animate fields formatter settings')`, so the AOS controls
only appear for permitted users. It then builds a `#type => details` "AOS Animations" element whose
child fields are `#states`-gated to be visible only when **Display Animations** is checked
(`:input[id*="animate-fields-aos-display-animations"]`). Fields (stored via `getThirdPartySetting`):

| Key | Widget | Default | Notes |
|-----|--------|---------|-------|
| `display_animations` | checkbox | FALSE | master on/off |
| `animation` | select | `fade` | options from `getAnimationOptions()` |
| `anchor_placements` | select | `top-bottom` | options from `getAnchorPlacementOptions()` |
| `easing` | select | `ease` | options from `getEasingOptions()` |
| `offset` | number (min 0) | 120 | px from trigger point |
| `delay` | number (0–3000) | 0 | ms, step 50 |
| `duration` | number (0–3000) | 400 | ms, step 50 |
| `mirror` | checkbox | FALSE | animate out on scroll-past |

Select option lists are supplied by the `animate_fields_aos.attributes_manager` service (see
`../api/attributes-manager.md`); each list includes a `none` ("None") entry.

## Config schema — `config/schema/animate_fields_aos.schema.yml`
Type `field.formatter.third_party.animate_fields_aos` (mapping). `display_animations` and `mirror` are
`boolean`; `animation`, `anchor_placements`, `easing` are `string`; `offset`, `delay`, `duration` are
`integer`. Stored inline in each `core.entity_view_display.*` config export.

## Rendering — `animate_fields_aos_preprocess_field(&$vars)`
Implements `hook_preprocess_field()`. Reads
`$vars['element']['#third_party_settings']['animate_fields_aos']`. Only when `display_animations` is
truthy does it, for each non-empty setting, assign the corresponding attribute onto `$vars['attributes']`
(Drupal's Attribute object, which escapes values on render): `data-aos` (animation),
`data-aos-anchor-placement`, `data-aos-easing`, `data-aos-offset`, `data-aos-delay`,
`data-aos-duration`, `data-aos-mirror`. It then appends
`$vars['#attached']['library'][] = 'animate_fields_aos/animate_fields_aos'`.

## Library — `animate_fields_aos.libraries.yml`
`animate_fields_aos` loads AOS 3.0.0-beta.6 CSS and JS as **external** assets from
`//cdnjs.cloudflare.com/ajax/libs/aos/3.0.0-beta.6/`, plus local `js/script.js` (a Drupal behavior that
calls `AOS.init()` on attach), depending on `core/jquery` and `core/drupal`. The library is attached
only to fields that have animations enabled.

## Help — `animate_fields_aos_help()`
On `help.page.animate_fields_aos`, reads the module's own `README.md`; if the `markdown` module is
enabled it runs the built-in markdown filter, otherwise it wraps the file in `<pre>`.
