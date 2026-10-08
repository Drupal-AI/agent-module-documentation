<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling media resize on a text format

`ckeditor_media_resize.info.yml` has no `configure` key — everything is per-text-format
config on two config entities: `filter.format.<id>` and `editor.editor.<id>`.

## Prerequisites for the CKEditor plugin to appear

The plugin declares `conditions` in `ckeditor_media_resize.ckeditor5.yml`:

| Condition | Meaning |
|---|---|
| `filter: filter_resize_media` | the **Resize media images** filter must be enabled on the format |
| `toolbarItem: drupalMedia` | the `drupalMedia` button must be in the CKEditor 5 toolbar |
| `plugins: [media_media]` | core's Media CKEditor 5 plugin must be active |

Core's `media_embed` filter ("Embed media") and `filter_html` ("Limit allowed HTML tags and
correct faulty HTML") also need to be on, and `filter_resize_media` must have a **lower
weight** than `media_embed` so it runs first.

## UI path

1. *Configuration → Content authoring → Text formats and editors* → edit a format that uses
   CKEditor 5 (e.g. **Full HTML**).
2. Drag **Media** (`drupalMedia`) into the toolbar.
3. Under *Enabled filters* tick **Resize media images**, and make sure **Embed media** and
   **Limit allowed HTML tags and correct faulty HTML** are ticked.
4. Under *Filter processing order* drag **Resize media images** above **Embed media**.
5. In the vertical tabs at the bottom, open **Media image resize** and tick/untick
   *"Enable this to dynamically scale resized images using image styles."*
6. Save.

## Doing it from code / drush

```bash
drush php:eval '
use Drupal\filter\Entity\FilterFormat;
use Drupal\editor\Entity\Editor;

$format_id = "full_html";

// 1. Enable the filter and order it before media_embed.
$format = FilterFormat::load($format_id);
$format->setFilterConfig("filter_resize_media", [
  "status" => TRUE,
  "weight" => -10,      // must be < the media_embed weight
  "settings" => [],
]);
$format->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100]);
$format->save();

// 2. Add the toolbar item and the plugin settings on the editor entity.
$editor = Editor::load($format_id);
$settings = $editor->getSettings();
if (!in_array("drupalMedia", $settings["toolbar"]["items"], TRUE)) {
  $settings["toolbar"]["items"][] = "drupalMedia";
}
$settings["plugins"]["media_media"]["allow_view_mode_override"] ??= FALSE;
$settings["plugins"]["ckeditor_media_resize_mediaResize"] = [
  "apply_image_styles" => TRUE,
  "image_styles" => [
    "cke_media_resize_small",
    "cke_media_resize_medium",
    "cke_media_resize_large",
    "cke_media_resize_xl",
  ],
];
$editor->setSettings($settings)->save();
'
```

## Settings reference

Stored at `editor.editor.<format>` → `settings.plugins.ckeditor_media_resize_mediaResize`
(schema `ckeditor5.plugin.ckeditor_media_resize_mediaResize`):

| Key | Type | Default | Effect |
|---|---|---|---|
| `apply_image_styles` | boolean (`NotNull`) | `TRUE` | When on, the filter also sets `data-view-mode` on the embed, picking the view mode whose image style is the smallest one at least as wide as the requested width. When off, only the inline `width:` style and the `media-embed-resized` class are applied. |
| `image_styles` | sequence of strings | `[cke_media_resize_small, cke_media_resize_medium, cke_media_resize_large, cke_media_resize_xl]` | The candidate styles considered for the width→view-mode mapping. **Not exposed on the settings form** — only `apply_image_styles` is; change this list by editing the editor config entity. |

`MediaResize::buildConfigurationForm()` renders only the `apply_image_styles` checkbox and
lists the configured `image_styles` in its description. `validateConfigurationForm()` casts
the submitted value to boolean because the schema requires a real bool.

## Verifying the wiring

```bash
# Is the filter on, and does it run before media_embed?
drush php:eval '
$f = \Drupal\filter\Entity\FilterFormat::load("full_html");
foreach (["filter_resize_media","media_embed","filter_html"] as $id) {
  $c = $f->filters()->has($id) ? $f->filters()->get($id) : NULL;
  printf("%s status=%s weight=%s\n", $id, $c ? var_export($c->status, TRUE) : "missing", $c->weight ?? "-");
}'

# Plugin settings on the editor entity.
drush cget editor.editor.full_html settings.plugins.ckeditor_media_resize_mediaResize

# Shipped image styles present?
drush php:eval 'foreach (["cke_media_resize_small","cke_media_resize_medium","cke_media_resize_large","cke_media_resize_xl"] as $s) { print $s . ": " . (\Drupal::entityTypeManager()->getStorage("image_style")->load($s) ? "yes" : "no") . "\n"; }'
```

## Shipped config

`config/install` (created on install, re-imported by
`ckeditor_media_resize_post_update_image_style_config_import()`):

| Image style | Label | Effect |
|---|---|---|
| `cke_media_resize_small` | CKE Media Resize Small (width 200) | `image_scale` width 200, `upscale: true` |
| `cke_media_resize_medium` | CKE Media Resize Medium (width 500) | `image_scale` width 500, `upscale: true` |
| `cke_media_resize_large` | CKE Media Resize Large (width 800) | `image_scale` width 800, `upscale: true` |
| `cke_media_resize_xl` | CKE Media Resize Extra Large (width 1200) | `image_scale` width 1200, `upscale: true` |

`config/optional` adds media view modes `media.cke_media_resize_{small,medium,large,xl}` and
`core.entity_view_display.media.image.cke_media_resize_*` displays that render
`field_media_image` with the matching image style, label `visually_hidden`, lazy loading,
and `created`/`name`/`thumbnail`/`uid` hidden. These only install when the `media.type.image`
bundle and `field.field.media.image.field_media_image` exist.
