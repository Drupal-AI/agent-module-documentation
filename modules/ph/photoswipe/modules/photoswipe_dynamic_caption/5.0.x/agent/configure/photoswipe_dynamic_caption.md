# Configure PhotoSwipe Dynamic Caption

## Requirements

- Enable the **photoswipe** module first (this is a submodule, dependency
  `photoswipe:photoswipe`).
- Provide the caption JS library: `composer require npm-asset/photoswipe-dynamic-caption-plugin:^1.2`
  into `/libraries/photoswipe-dynamic-caption-plugin`, or enable the **CDN** option on the
  main PhotoSwipe settings form (`/admin/config/media/photoswipe`, key `enable_cdn`). A
  `hook_requirements()` runtime check reports an error if the library is missing/incompatible
  (major version must be `1`).

## Choose the caption source (per field display)

Enabling this module adds a **"Photoswipe image caption"** select to the third-party settings
of the `photoswipe_field_formatter` and `photoswipe_responsive_field_formatter` formatters,
on the field's **Manage display** page (added via
`hook_field_formatter_third_party_settings_form()`). Stored under third-party settings
`photoswipe_dynamic_caption` (schema `field.formatter.third_party.photoswipe_dynamic_caption`):

| Third-party key | Meaning |
|---|---|
| `photoswipe_caption` | The caption source (see options below). Default `title`. |
| `photoswipe_caption_custom` | Textarea used when the source is `custom` (supports tokens). |

Caption source options:

| Value | Caption text |
|---|---|
| `title` | Image **title** tag |
| `alt` | Image **alt** tag |
| `entity_label` | Parent **entity label** (e.g. node title); falls back to alt. (`node_title` kept for back-compat) |
| `media_name` | **Media entity name** — only offered when the field targets media |
| `custom` | **Custom (with tokens)** — uses `photoswipe_caption_custom`, resolved with the Token service; a token browser shows when the **token** module is installed |
| *(a field name)* | Another field of the parent entity, or of a referenced entity (`photoswipe_dynamic_caption_referenced_entity_<field>`); value is XSS-filtered |

At render time the module preprocesses the `photoswipe_image_formatter` /
`photoswipe_responsive_image_formatter` theme hooks and writes the resolved caption to the
`data-overlay-title` attribute that the JS plugin reads
(`photoswipe_dynamic_caption_get_caption()`).

> **Note:** because of Drupal core issue
> [#2686145](https://www.drupal.org/project/drupal/issues/2686145) the caption third-party
> setting appears on the entity display page but **not** in the Views UI unless you patch core.

## Global caption behavior — `photoswipe_dynamic_caption.settings`

Route `photoswipe_dynamic_caption.settings` at
**`/admin/config/media/photoswipe_dynamic_caption`** (permission
`administer site configuration`; form `PhotoswipeDynamicCaptionSettings`). Defaults from
`config/install/photoswipe_dynamic_caption.settings.yml`:

| Key (`options.*`) | Form label | Default | Meaning |
|---|---|---|---|
| `type` | Caption Position | `auto` | `auto`, `below`, or `aside`. |
| `mobileLayoutBreakpoint` | Mobile Layout Breakpoint | `600` | Max window width (px) for mobile layout. |
| `horizontalEdgeThreshold` | Horizontal Edge Threshold | `20` | Threshold below which the edge CSS class is applied. |
| `mobileCaptionOverlapRatio` | Mobile Caption Overlap Ratio | `0.3` | Horizontal empty-space ratio before mobile "overlap" layout. |
| `verticallyCenterImage` | Vertically Center Image | `false` | Vertically center the image in the remaining space. |

Schema: `config/schema/photoswipe_dynamic_caption.schema.yml`. Settings are a config object
(export/deploy with `drush config:export`). These options are merged into
`captionOptions` and passed to PhotoSwipe via this module's
`hook_photoswipe_js_options_alter()`; you can also override them in code by setting
`$settings['captionOptions']` in your own implementation of that hook.
