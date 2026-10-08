# Color value objects

`Drupal\color_field\ColorInterface` defines a common API implemented by value
objects in `src/` (base: `ColorBase`). Use them to convert between color spaces
in custom code, Token/Feeds handlers, or formatters.

Classes: `ColorHex`, `ColorRGB`, `ColorHSL` (and `ColorCMY`, `ColorCMYK`).

## Interface
```php
interface ColorInterface {
  public function toString(): string;   // (most take a bool $opacity arg)
  public function toHex(): ColorHex;
  public function toRgb(): ColorRGB;
  public function toHsl(): ColorHSL;
}
```
`ColorBase` adds `getOpacity(): float` and `setOpacity(?float): void`.

## Example
```php
use Drupal\color_field\ColorHex;

// From a stored field item (properties: ->color hex, ->opacity float|null).
$hex = new ColorHex($item->color, $item->opacity === NULL ? NULL : (float) $item->opacity);

$hex->toString(FALSE);          // "#123abc" (no opacity)
$hex->toString(TRUE);           // hex incl. opacity
$rgb = $hex->toRgb();           // ColorRGB
$rgb->getRed();                 // int 0-255
$rgb->toString(TRUE);           // "rgba(18,58,188,1.0)"
$hex->toHsl();                  // ColorHSL
```
This is exactly what `color_field_tokens()` uses to expose the HEX/RGB/RGBA and
per-channel tokens.
