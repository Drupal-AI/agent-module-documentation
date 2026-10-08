<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a `modifier` plugin

A modifier is a plugin (type id `modifier`, subdir `Plugin/modifiers`) that implements
`Drupal\modifiers\ModifierInterface`. Its single job is a **static** factory that maps stored config
to a `Modification` object. Discovery works in **modules and themes**, in three forms.

## 1. PHP class with attribute (D10.2+/D11)

```php
namespace Drupal\my_module\Plugin\modifiers;

use Drupal\modifiers\Attribute\Modifier;
use Drupal\modifiers\Modification;
use Drupal\modifiers\ModifierPluginBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[Modifier(
  id: 'background_color',
  label: new TranslatableMarkup('Background color'),
  description: new TranslatableMarkup('Sets a background color.'),
)]
class BackgroundColor extends ModifierPluginBase {

  public static function modification($selector, array $config): ?Modification {
    if (empty($config['color'])) {
      return NULL;
    }
    $media = self::getMediaQuery($config);          // 'all' or a media query
    $css = [
      $media => [
        $selector => ['background-color: ' . $config['color']],
      ],
    ];
    return new Modification($css);
  }
}
```

The legacy annotation form (`@Modifier` from `Drupal\modifiers\Annotation\Modifier`) is still
supported by the manager.

## 2. YAML form (`my_module.modifiers.yml`)

The manager adds a `YamlDiscoveryDecorator` (base filename `modifiers`), so a `*.modifiers.yml` file
can declare plugin definitions that point at a `class`.

## Config keys

`$config` is the flattened field set for one modifier instance: field machine names with the
`field_mod_`/`field_` prefix stripped (e.g. `field_mod_color` → `color`). Media/image fields arrive
as file URLs; colour fields as `rgba()` strings; a `media_query` key (if present) is read by
`ModifierPluginBase::getMediaQuery()`.

## What a `Modification` can carry

- **css** — `[media][selector] => [properties]`, emitted inline in a single head `<style>`.
- **libraries** — `module/library` strings attached to the build.
- **settings** — JS descriptors dispatched by `modifiers.init.js` to
  `window[namespace][callback](selector, media, args)`.
- **attributes** — `[media][selector][attribute] => value`, toggled per breakpoint by JS.
- **links** — head `<link>` attribute arrays.

## Security responsibility (important for plugin authors)

`Modifiers::renderCss()` concatenates your selector and property strings **verbatim** into an inline
`<style>` block via `Markup::create()` — nothing is escaped by the framework. A plugin that copies a
raw editor-supplied text/textarea value (a "custom CSS" field, a raw selector, an unvalidated colour
or URL) into `css` properties can enable a `</style>…` breakout (stored XSS) or a
`url(javascript:…)`/`expression()` payload. Always validate/whitelist:

- colours through `Modifiers::getColorValue()` (hex-validated) or a strict regex;
- URLs by resolving through a file/media entity, not by echoing a raw string;
- never emit a free-text "custom CSS" or raw selector field without sanitisation.

Attributes and JS `settings` are likewise applied to the DOM by `modifiers.init.js`
(`elements.prop(attribute, value)`, `window[namespace][callback]`) with no sanitisation — treat any
value that originates from an editor field as untrusted.
