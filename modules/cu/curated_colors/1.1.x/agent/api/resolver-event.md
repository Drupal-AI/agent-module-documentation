<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Palette resolver service & `PaletteColorsEvent`

## Service: `curated_colors.palette_resolver`

Defined in `curated_colors.services.yml`; class `ColorPaletteResolver`
(`src/ColorPaletteResolver.php`) implementing `ColorPaletteResolverInterface`
(`src/ColorPaletteResolverInterface.php`). Constructor args: `@entity_type.manager`,
`@event_dispatcher`.

```php
/** @var \Drupal\curated_colors\ColorPaletteResolverInterface $resolver */
$resolver = \Drupal::service('curated_colors.palette_resolver');
```

### `getColors(ColorPalette $palette): array`

Returns the palette's **effective** color map (keyed by color key) after firing
`PaletteColorsEvent`, so subscribers can augment it. Call this rather than
`ColorPalette::getColors()` directly whenever you need the event-augmented set. This is what
`CuratedColorItem::getAllowedColors()` and `CuratedColorComputedProperty` use, so field rendering,
options and computed properties all reflect event mutations.

### `resolveForCanvas(string $requested): ?string`

Resolves which palette id Canvas should use, walking:

1. `$requested` when non-empty **and** that palette exists;
2. a palette with id `canvas`;
3. the alphabetically-first palette (entity query, `sort('id')`, `range(0,1)`,
   `accessCheck(FALSE)` — config-entity id lookup for shape matching, not content disclosure).

Returns `NULL` when no palettes exist at all. Used by the Canvas prop-shape hook (see
[../canvas/integration.md](../canvas/integration.md)).

## Event: `PaletteColorsEvent`

`src/Event/PaletteColorsEvent.php`, extends Symfony `Event`. Name constant
**`PaletteColorsEvent::NAME`** = `'curated_colors.palette_colors'`. Fired once per
`getColors()` call.

Constructed with the `ColorPalette` (read-only context) and the current color map. Methods:

| Method | Effect |
|---|---|
| `getPalette(): ColorPalette` | the palette being resolved (context only) |
| `getColors(): array` | current color map, keyed by color key |
| `setColors(array $colors): void` | replace the whole map |
| `addColor(array $color): void` | add/replace one entry (needs a non-empty `key`; fills defaults `hex=NULL, style=NULL, groups=[], enabled=TRUE`) |
| `removeColor(string $key): void` | drop one entry by key |

Each color entry is `{key, label, hex:?, style:?, groups:string[], enabled:bool}`.

### Subscriber example

```php
use Drupal\curated_colors\Event\PaletteColorsEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

final class MyPaletteSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [PaletteColorsEvent::NAME => 'onColors'];
  }

  public function onColors(PaletteColorsEvent $event): void {
    if ($event->getPalette()->id() === 'brand') {
      // Inject a runtime "current season" color.
      $event->addColor([
        'key' => 'seasonal',
        'label' => 'Seasonal',
        'hex' => '#8844ff',
        'groups' => ['Primary'],
      ]);
      // Or hide one:
      $event->removeColor('legacy-teal');
    }
  }

}
```

Because added/removed colors flow through `getAllowedColors()`, the field's `AllowedValues`
constraint and picker options honor them at runtime — but note that a value only stays valid while
its key is present in the effective set.
