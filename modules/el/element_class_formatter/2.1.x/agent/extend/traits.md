# Build your own class-adding formatter (traits)

The module has no plugin type; you extend it by writing a normal `@FieldFormatter` and mixing in
one of its reusable traits (namespace
`Drupal\element_class_formatter\Plugin\Field\FieldFormatter`).

| Trait | Adds the class to | Used by |
|---|---|---|
| `ElementClassTrait` | base helpers: default `class` setting, the "Element class" form field, summary line; `setElementClass()` → `#options.attributes.class`; `setEntityClass()` → `#item_attributes.class` | wrapper, ally, entity-reference-label, file-link |
| `ElementLinkClassTrait` | link `#options.attributes.class` (extends core link/mailto/tel formatters) | `link_class`, `email_link_class`, `telephone_link_class` |
| `ElementEntityClassTrait` | `#item_attributes.class` on entity/image formatters | `image_class` |
| `ElementListClassTrait` | wraps items in a classed `<ul>`/`<ol>` list | list/entity-reference-list/string-list formatters |

`ElementClassTrait` gives you three helpers to compose in `defaultSettings()`,
`settingsForm()`, and `settingsSummary()`:

```php
namespace Drupal\my_module\Plugin\Field\FieldFormatter;

use Drupal\element_class_formatter\Plugin\Field\FieldFormatter\ElementLinkClassTrait;
use Drupal\link\Plugin\Field\FieldFormatter\LinkFormatter;

/**
 * @FieldFormatter(
 *   id = "my_fancy_link_class",
 *   label = @Translation("Link (with my class)"),
 *   field_types = { "link" }
 * )
 */
class MyFancyLinkClassFormatter extends LinkFormatter {
  use ElementLinkClassTrait;   // adds the "Element class" field + applies it to the <a>
}
```

The simplest formatters in the module are exactly this pattern — e.g. `LinkClassFormatter`
extends core `LinkFormatter` and just `use ElementLinkClassTrait;`. For a from-scratch formatter,
`WrapperClassFormatter` shows using `ElementClassTrait` with a `FormatterBase` and building an
`html_tag` element with `$attributes->addClass($class)`. Add a matching
`field.formatter.settings.<id>` schema so your settings validate.
