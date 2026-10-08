# Field formatters (image)

The module registers two image-field formatters. Only `image_contextual_url` does real work;
`contextual_image` is a deprecated shim.

| Formatter id | Class | Field types | Status |
|---|---|---|---|
| `image_contextual_url` | `Plugin\Field\FieldFormatter\ImageContextualUrlFormatter` | `image` | Active — outputs a contextual image **URL string** |
| `contextual_image` | `Plugin\Field\FieldFormatter\ImageFormatter` | `image` | **DEPRECATED** — empty subclass of core `image` formatter (label "DEPRECATED Contextual Crop Image"); kept only for migration, see [drush/commands.md](../drush/commands.md) |

## `image_contextual_url`

Extends core `ImageUrlFormatter` (the "URL to image" formatter) and overrides `viewElements()`.
For each image item it:

1. Loads the configured `image_style`.
2. Calls `MediaContextualCropUseCasePluginManager::findCompetent($item)` (see
   [plugins/use-cases.md](../plugins/use-cases.md)).
3. If a use-case plugin matches: builds `$context_settings` from `getCropSettings($item)` (plus
   `plugin` id and raw `item_values`) and returns
   `use_case_plugin->getContextualizedImage($context_settings, $image_uri, $style_id)` — i.e. a
   contextual derivative URL.
4. Otherwise falls back to the plain style URL (`$image_style->buildUrl()` made relative, or the
   raw file URL when no style is set).

Cacheable metadata from the image and the image style is attached. Output is `#markup` = the URL
string (matching core's URL formatter behaviour), suitable for feeding another template/JSON.

> **Note (2.2.x):** the constructor tracks Drupal 11.4's revised `ImageUrlFormatter` signature —
> it is now injected with `entity_type.manager` (`EntityTypeManagerInterface`) and
> `image.derivative_utilities` (`ImageDerivativeUtilities`, nullable) instead of the old
> `image_style` storage. This is internal; it only matters if you subclass the formatter.

**Contextual cropping on the ordinary image display** (rendered `<img>`, not a URL) is not a
formatter — it is done by the preprocess interception in
[hooks/preprocess.md](../hooks/preprocess.md), which upgrades the core image / responsive-image
formatters in place. You normally keep the standard `image` / responsive formatter and let those
hooks add the contextual crop; the deprecated `contextual_image` formatter is no longer needed.
