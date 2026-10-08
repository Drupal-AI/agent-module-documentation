<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media_directories_legacy_embed` filter

`Drupal\media_directories_compat\Plugin\Filter\LegacyEntityEmbed` — the module's only class.

```php
#[Filter(
  id: "media_directories_legacy_embed",
  title: new TranslatableMarkup("Legacy entity embed compatibility"),
  description: …"Converts <drupal-entity> media embeds to <drupal-media>. Must run before the 'Embed media' filter.",
  type: FilterInterface::TYPE_TRANSFORM_REVERSIBLE,
  weight: 80,
  settings: ["inline_display_modes" => []],
)]
final class LegacyEntityEmbed extends FilterBase implements ContainerFactoryPluginInterface {
  const CONSUMED_ATTRIBUTES = [
    'data-entity-embed-display',
    'data-entity-embed-display-settings',
    'data-embed-button',
  ];
}
```

Injected: `entity.repository`, `file_url_generator`.

## Conversion rules

1. Return unchanged unless the text contains `<drupal-entity`.
2. XPath `//drupal-entity[@data-entity-type="media" and normalize-space(@data-entity-uuid)!=""]`
   — non-media `<drupal-entity>` tags are never touched.
3. `getDisplaySettings()` — JSON-decode `data-entity-embed-display-settings` (`[]` on
   failure).
4. `extractViewMode($display_plugin, $settings)`:
   - `''` when `data-entity-embed-display` is empty;
   - `substr(...)` after `view_mode:media.` → e.g. `view_mode:media.full` ⇒ `full`;
   - `''` for anything else, including `entity_reference:…` plugins and settings that carry
     an `image_style` (the standard image pipeline handles those).
5. **Inline branch** — if the derived view mode is in
   `array_filter($this->settings['inline_display_modes'])`, `convertToLink()` runs:
   - load the media by UUID; if it is not a `MediaInterface`, **remove the node** entirely;
   - translate it to the current `$langcode`, read the media source's source-field entity;
     if it is not a `FileInterface`, **remove the node**;
   - otherwise replace the node with
     `<a href="{file url}" data-entity-type="media" data-entity-uuid="{uuid}">{media label}</a>`.
6. **Media branch** — otherwise build `<drupal-media>` with:
   - `data-entity-type="media"`, `data-entity-uuid="{uuid}"`,
   - `data-view-mode="{mode}"` when a mode was derived,
   - `data-width` / `data-height` from `image_width` / `image_height` **only when both are
     set and `image_style` is empty** (these are what `media_directories_image_resize` picks
     up),
   - every other original attribute except `data-entity-type`, `data-entity-uuid` and the
     three `CONSUMED_ATTRIBUTES` — so `data-align`, `data-caption`, `class`, … survive.
7. `setProcessedText()` only if something changed.

## Enabling and ordering

```bash
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $f->setFilterConfig("media_directories_legacy_embed", [
    "status" => TRUE,
    "weight" => 0,                       // must be < media_embed weight
    "settings" => ["inline_display_modes" => ["default"]],
  ]);
  $f->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100]);
  $f->save();'

drush cget filter.format.full_html filters.media_directories_legacy_embed
```

In the UI the filter's own vertical tab exposes **`inline_display_modes`**; leave it empty to
convert everything to `<drupal-media>`.

Make sure `filter_html` allows the legacy tag if it is active, e.g.
`<drupal-entity data-entity-type data-entity-uuid data-entity-embed-display data-entity-embed-display-settings data-align data-caption>`.

## Try it live

```bash
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $p = $f->filters()->get("media_directories_legacy_embed");
  $uuid = "…";   // a real media uuid
  $html = "<p><drupal-entity data-entity-type=\"media\" data-entity-uuid=\"$uuid\" "
        . "data-entity-embed-display=\"view_mode:media.full\" data-align=\"center\"></drupal-entity></p>";
  print $p->process($html, "en")->getProcessedText() . "\n";'
```

Expected: `<drupal-media data-entity-type="media" data-entity-uuid="…" data-view-mode="full"
data-align="center"></drupal-media>`.

## Not provided

No settings form of its own (only the per-format filter settings), no config object, no
permissions, no services, no hooks, no routes, no Drush commands. The module ships
`*.info.yml`, `config/schema/media_directories_compat.schema.yml`, the filter class and a
kernel test.
