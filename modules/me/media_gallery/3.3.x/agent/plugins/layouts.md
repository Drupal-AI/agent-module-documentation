<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MediaGalleryLayout plugin type

Media Gallery defines one plugin type that controls how a gallery block arranges its media items.

- **Manager service:** `media_gallery.layout_manager`
  (`Drupal\media_gallery\MediaGalleryLayoutManager`, extends `DefaultPluginManager`).
- **Discovery:** attribute-based, subdirectory `Plugin/MediaGalleryLayout`, using
  `AttributeClassDiscovery`.
- **Attribute:** `#[\Drupal\media_gallery\Attribute\MediaGalleryLayout(...)]`.
- **Interface:** `Drupal\media_gallery\Plugin\MediaGalleryLayoutInterface`
  (extends `PluginInspectionInterface`, `PluginFormInterface`).
- **Base class:** `Drupal\media_gallery\Plugin\MediaGalleryLayoutBase`.
- **Alter hook:** `media_gallery_layout_info` (alter the definitions array).
- **Cache key:** `media_gallery_layout_plugins`.

## Built-in layouts

| id | Class | Notes |
|---|---|---|
| `grid` | `Plugin/MediaGalleryLayout/Grid` | responsive CSS grid; config `grid_columns` (default 3) |
| `featured_image_grid` | `FeaturedImageGrid` | grid with one hero item; `grid_columns`, `featured_image_column_span`, `featured_image_row_span`, `thumbnail_style_first` |
| `horizontal` | `Horizontal` | horizontal strip |
| `vertical` | `Vertical` | vertical stack |
| `swiper` | `Swiper` | swipeable carousel; config `swiper_template` (needs the `swiper_formatter` module) |

`grid` is the default (`MediaGalleryConstants::DEFAULT_BLOCK_LAYOUT`).

## Attribute parameters

```php
#[MediaGalleryLayout(
  id: 'grid',
  label: new TranslatableMarkup('Grid'),
  description: new TranslatableMarkup('A responsive grid layout.'),
  preview_icon: 'grid.svg',      // file in the module's icons/ dir
)]
```

## Implement a custom layout

Extend `MediaGalleryLayoutBase` (which injects `media_gallery.item_renderer`, merges
`defaultConfiguration()`, and provides `renderItems()` + `buildLayout()` helpers), add the
attribute, and place the class in `your_module/src/Plugin/MediaGalleryLayout/`.

```php
namespace Drupal\your_module\Plugin\MediaGalleryLayout;

use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\media_gallery\Attribute\MediaGalleryLayout;
use Drupal\media_gallery\Plugin\MediaGalleryLayoutBase;

#[MediaGalleryLayout(
  id: 'masonry',
  label: new TranslatableMarkup('Masonry'),
  description: new TranslatableMarkup('A masonry layout.'),
  preview_icon: 'masonry.svg',
)]
class Masonry extends MediaGalleryLayoutBase {

  public function defaultConfiguration() {
    return ['gap' => 8];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['gap'] = [
      '#type' => 'number',
      '#title' => $this->t('Gap (px)'),
      '#default_value' => $this->configuration['gap'] ?? 8,
    ];
    return $form;
  }

  public function build(array $media_items, array $gallery_attributes = []): array {
    $gallery_attributes += ['style' => 'gap:' . $this->configuration['gap'] . 'px;'];
    return parent::build($media_items, $gallery_attributes);
  }
}
```

`build()` receives an array of `\Drupal\media\MediaInterface` items and returns a render array;
`buildLayout()` wraps items in a container with the `photoswipe-gallery` class. Only keys returned
by `defaultConfiguration()` are persisted into a block's `layout_configuration`. Add a config
schema entry `media_gallery.plugin.layout.<id>` if your layout stores settings (see the
`media_gallery.plugin.layout.grid` / `.featured_image_grid` / `.swiper` entries).

To alter existing layout definitions instead of adding one, implement
`hook_media_gallery_layout_info_alter(array &$definitions)`.
