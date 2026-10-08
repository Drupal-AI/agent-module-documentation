# Build a carousel in code

Two services do the work (defined in `slick.services.yml`):
- `slick.manager` → `Drupal\slick\SlickManagerInterface` (rendering)
- `slick.formatter` → `Drupal\slick\SlickFormatterInterface` (field/media prep, extends Blazy)
- `slick.skin_manager` → `Drupal\slick\SlickSkinManagerInterface` (skins)

The procedural shortcut `slick()` returns the manager (`slick('skin')` returns the skin
manager).

## Manager API (`SlickManagerInterface`)
- `build(array $build): array` — the main entry: returns a themed `#theme => 'slick'` element.
- `buildGrid(array $items, array &$settings): array` — grid-of-slides layout.
- `getSkins(): array` / `getSkinsByGroup($group, $option)` — available skins.
- `loadSafely($name): Slick` — load an optionset entity by name (falls back to default).
- `attachSkin()`, `preRenderSlick()`, `preRenderSlickWrapper()` — asset attach + pre-render.

## Minimal example
```php
$manager = \Drupal::service('slick.manager');

$build = [
  'settings' => [
    'optionset' => 'carousel',   // slick.optionset.carousel
    'skin'      => '',
  ],
  'items' => [
    ['slide' => ['#markup' => '<img src="/a.jpg">']],
    ['slide' => ['#markup' => '<img src="/b.jpg">']],
  ],
];

$element = $manager->build($build);   // render array, #theme => 'slick'
```

`items` is a list of slides (each a render array under the `slide` key); `settings.optionset`
names the optionset to apply. The manager loads the optionset, resolves the skin, attaches the
Slick + Blazy libraries, and returns a render array — no manual library attachment needed.
For field/media output prefer the field formatters (see
[../configure/optionsets.md](../configure/optionsets.md)).
