<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_image block type, fields, displays & templates

## Install / enable
`drush en ebt_image`. Deps pulled in: `ebt_core`, `media`, `link`, `glightbox`.
`ebt_image_requirements($phase)` (`ebt_image.install`) returns a `RequirementSeverity::Error` at the `install` phase if the `media` module is enabled but no `image` media type exists — create Structure » Media types » Add media type ("Image") first. (On this documenting site enable failed because the ebt_core field-storage dependency chain was absent; the analysis below is from on-disk source.)

## Block type
`config/install/block_content.type.ebt_image.yml`: bundle id `ebt_image`, label "EBT Image". Standard `block_content` custom block — placeable via Block layout (Add custom block) or as an inline block in Layout Builder.

## Fields (config/install/field.*.yml)
| Field | Type | Notes |
|-------|------|-------|
| `field_ebt_image` | entity_reference → `media` | Required, cardinality 1, `target_bundles: image`, handler `default:media`. |
| `field_ebt_image_caption` | `text_long` | Optional rich-text caption; also used as GLightbox slide title. |
| `field_ebt_image_link` | `link` | Optional; wraps the image in an anchor. `link_type: 17` (internal+external). |
| `field_ebt_settings` | `ebt_settings` | Shared EBT design settings (schema/widget base from ebt_core); translatable; carries `image_style`, `image_lightbox`, `lightbox_image_style`, `greyscale`, `colorful_on_hover` plus ebt_core design options. |

There is **no** `config/schema/` in this module — the `ebt_settings` schema is owned by ebt_core, so `provides_config_schema` is false here.

## Default displays
- **Form** (`core.entity_form_display…default`): field_group `tabs` → "Content" tab (image, caption, link) and "Settings" tab (`field_ebt_settings` via the `ebt_settings_image` widget). Image uses `media_library_widget`; caption `text_textarea`; link `link_default`.
- **View** (`core.entity_view_display…default`): `field_ebt_image` → `media_thumbnail` (label hidden, `image_loading: lazy`, no image_link/style set — the style is injected at preprocess time); `field_ebt_image_link` → `link` formatter; `field_ebt_image_caption` → `text_default`; `field_ebt_settings` → `ebt_settings_default`.

## Preprocess behavior (`ebt_image.module` + `src/Hook/EbtImageHooks.php`)
`EbtImageHooks::preprocessBlock()` is registered with `#[Hook('preprocess_block')]`; `ebt_image_preprocess_block()` is the `#[LegacyHook]` shim delegating to the autowired service. It runs two helpers, both early-returning unless the block is bundle `ebt_image`:

- `_ebt_image_apply_image_style(&$variables)` — only when the image renders as `image_formatter`; sets `$variables['content']['field_ebt_image'][0]['#image_style']` from the block's `image_style` setting (skipped when unset or `none`). This overrides the view-display style per block.
- `_ebt_image_apply_lightbox_image_style(&$variables)` — when `image_lightbox` is on: loads the referenced `Media` (`field_ebt_image.target_id`), resolves the media type's source field to a `File`, sets `$variables['show_lightbox'] = TRUE` and `$variables['lightbox_url']` to either the absolute file URL (`file_url_generator->generateAbsoluteString()`) or `ImageStyle::load(lightbox_image_style)->buildUrl($uri)` when a lightbox style is chosen.

## Templates (templates/)
- `block--block-content--ebt-image.html.twig` and `block--inline-block--ebt-image.html.twig` — near-identical block markup. Add classes `ebt-block ebt-block-image` plus `greyscale` / `colorful-on-hover` from the settings; attach `ebt_image/ebt_image`. When `show_lightbox`, wrap the image in `<a class="glightbox" href="{{ lightbox_url }}">` (with `data-glightbox` title from the rendered caption, `|striptags|trim`) and attach `ebt_image/ebt_image_lightbox`. Else, if a link is set, wrap in an anchor built from `field_ebt_image_link.0['#url']` with optional `target`/`rel`/`class` from the link's `#options.attributes`. Then render `content.field_ebt_image` and the remaining content via `without(...)`. Both end with `{{ styles|raw }}` (the CSS blob is generated and escaped by ebt_core, not this module).
- `field--block-content--field-ebt-image--ebt-image.html.twig` — standard field wrapper that prints each `item.content` (the core media_thumbnail formatter output). No raw/unescaped user data.

## Libraries (`ebt_image.libraries.yml`)
- `ebt_image` → `css/ebt_image.css`.
- `ebt_image_lightbox` → `css/ebt_image_lightbox.css` + deps `glightbox/glightbox`, `glightbox/init` (from the glightbox module).

## Operate it
1. Ensure an `image` media type exists; enable the module.
2. Add a custom block of type "EBT Image" (or add it as an inline block in Layout Builder).
3. On the Content tab pick a media image, optional caption, optional link. On the Settings tab choose Image Style, toggle Lightbox (+ Lightbox Image Style), Greyscale / Colorful on hover, and the ebt_core design options.
4. Place/save. Per-block image style and lightbox are applied at render.
