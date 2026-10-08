# Reusing the base classes

The module exposes two abstract bases you can subclass to build your own formatters. Both
live in `Drupal\field_formatter\Plugin\Field\FieldFormatter`.

## FieldFormatterBase (single referenced field)

`abstract class FieldFormatterBase extends EntityReferenceFormatterBase`

- For **entity-reference** formatters that render one field of the referenced entity.
- Provides: `link_to_entity` default + settings form/summary, a `viewElements()` that builds
  each referenced entity through `getViewDisplay($bundle)` and optionally rewrites `#url` to
  the parent entity, `getAvailableFieldNames()` (lists candidate fields across target
  bundles), `isApplicable()` (target entity must be fieldable), and
  `getSettingFromFormState()`.
- Subclass responsibility: implement `abstract getViewDisplay($bundle_id)` returning an
  `EntityViewDisplayInterface` that renders your chosen field, and add your own settings
  (e.g. `field_name`, `view_mode`) in `defaultSettings()` / `settingsForm()`.
- Both shipped subclasses (`FieldFormatterWithInlineSettings`, `FieldFormatterFromViewDisplay`)
  are worked examples: the inline one builds an ad-hoc `EntityViewDisplay::create()` and calls
  `setComponent()` with the picked inner formatter; the view-display one loads an existing
  view display and strips all but the chosen component.

## FieldWrapperBase (wrap any field's output)

`abstract class FieldWrapperBase extends FormatterBase implements ContainerFactoryPluginInterface`

- For formatters that render **any** field with an inner formatter, then decorate the output.
- Provides: `type` + `settings` defaults, an AJAX settings form that lists applicable inner
  formatters (`getAvailableFormatterOptions()`, which unsets `field_link` itself),
  `getFieldOutput()` (renders the field via a throwaway `EntityViewDisplay` and returns that
  field's build array), and `getViewDisplay()`.
- Subclass responsibility: implement `viewElements()` to take `getFieldOutput($items, $langcode)`
  and wrap each child. `FieldLink` is the shipped example — it wraps each `Element::children`
  item in a `#type => 'link'` to the host entity's canonical URL.
- To make your subclass apply to all field types, mirror what `field_formatter.module` does:
  set its plugin `field_types` to `{}` in the annotation and populate them from
  `hook_field_formatter_info_alter()` (that is why `field_link` declares no field types in its
  annotation).

## Minimal wrapper example

```php
namespace Drupal\my_module\Plugin\Field\FieldFormatter;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Render\Element;
use Drupal\field_formatter\Plugin\Field\FieldFormatter\FieldWrapperBase;

/**
 * @FieldFormatter(id = "my_badge_wrapper", label = @Translation("Badge wrapper"), field_types = {})
 */
class MyBadgeWrapper extends FieldWrapperBase {
  public function viewElements(FieldItemListInterface $items, $langcode) {
    $out = $this->getFieldOutput($items, $langcode);
    $elements = [];
    foreach (Element::children($out) as $key) {
      $elements[$key] = ['#markup' => '<span class="badge">', 'child' => $out[$key], '#suffix' => '</span>'];
    }
    return $elements;
  }
}
```
