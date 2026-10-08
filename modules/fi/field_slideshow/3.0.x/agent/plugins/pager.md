# The `field_slideshow_pager` plugin type

Field Slideshow defines a small plugin type for rendering the slideshow's pager. The formatter's
**Pager type** select is populated from these plugins, and the chosen one renders the pager markup
when the field has more than one image.

## Type wiring

- Manager: `FieldSlideshowPagerPluginManager` (service `plugin.manager.field_slideshow_pager`,
  `field_slideshow.services.yml`), subdir `Plugin/FieldSlideshowPager`, alter hook
  `field_slideshow_pager_info`.
- Interface: `FieldSlideshowPagerInterface` (`label()`); base class
  `FieldSlideshowPagerPluginBase` adds `abstract viewPager(FieldItemListInterface $items): array`.
- Annotation: `@FieldSlideshowPager(id, label, description)` (`src/Annotation/FieldSlideshowPager.php`).

## Shipped plugins

| id | Class | Renders |
|---|---|---|
| `thumbnails` | `Plugin/FieldSlideshowPager/Thumbnails` | One `image_style` thumbnail (style `thumbnail`) per item, using `$item->entity->getFileUri()`. |
| `counter` | `Plugin/FieldSlideshowPager/Counter` | A `<span class="cycle-pager-item cycle-pager-item-N">N</span>` per item. |

## Implement your own

```php
namespace Drupal\my_module\Plugin\FieldSlideshowPager;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\field_slideshow\FieldSlideshowPagerPluginBase;

/**
 * @FieldSlideshowPager(
 *   id = "dots",
 *   label = @Translation("Dots"),
 *   description = @Translation("A simple dot per slide.")
 * )
 */
class Dots extends FieldSlideshowPagerPluginBase {
  public function viewPager(FieldItemListInterface $items): array {
    $out = [];
    foreach ($items as $delta => $item) {
      $out[$delta] = ['#type' => 'html_tag', '#tag' => 'span',
        '#attributes' => ['class' => ['cycle-pager-item', 'cycle-pager-item-' . ($delta + 1)]],
        '#value' => ''];
    }
    return $out;
  }
}
```

Drop it under `src/Plugin/FieldSlideshowPager/`, clear caches, and the new type appears in the
formatter's **Pager type** select. `viewPager()` returns a render array; the formatter passes it to the
`field_slideshow` theme hook and places it before/after per the pager settings.
