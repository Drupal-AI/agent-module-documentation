<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending the formatter plugin

The plugins `ImageLinkFormatter` and (in the submodule) `ResponsiveImageLinkFormatter` are thin:
each extends a core formatter and mixes in **`ImageLinkFormatterTrait`**, which holds the shared
`create()`, `settingsForm()`, `settingsSummary()`, `viewElements()`, and `getLinkFieldsOptions()`.

## The trait's structure (what you inherit)

- `create()` — calls `parent::create()` then injects `entity_field.manager` into
  `$instance->entityFieldManager` (used to discover the entity/bundle's Link fields).
- `getLinkFieldsOptions()` — returns `[field_name => "Label (field_name)"]` for every `link`-type
  field on the formatter's target entity type + bundle (cached per instance).
- `settingsForm()` — adds those options into the core `image_link` (“Link image to”) select.
- `viewElements()` — after core renders, sets each element's `#url` to the same-delta Link URL.

## Adding your own dependency (recommended pattern)

Because the trait already overrides `create()`, extend the plugin class and add getters/setters
plus your own `create()` that calls `parent::create()` (per the module README):

```php
namespace Drupal\my_module\Plugin\Field\FieldFormatter;

use Drupal\Core\Session\AccountProxyInterface;
use Drupal\image_link_formatter\Plugin\Field\FieldFormatter\ImageLinkFormatter;
use Symfony\Component\DependencyInjection\ContainerInterface;

class MyImageLinkFormatter extends ImageLinkFormatter {

  protected $currentUser;

  public function getCurrentUser() {
    return $this->currentUser ?: \Drupal::currentUser();
  }

  public function setCurrentUser(AccountProxyInterface $current_user) {
    $this->currentUser = $current_user;
    return $this;
  }

  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition): static {
    $plugin = parent::create($container, $configuration, $plugin_id, $plugin_definition);
    $plugin->setCurrentUser($container->get('current_user'));
    return $plugin;
  }
}
```

Then give it its own `#[FieldFormatter(...)]` attribute id/label. Using getters/setters (rather than
overriding the constructor) lets your child add dependencies without touching the parent's
constructor — see the module's issue #3412951.

## Reusing the trait directly

To wrap a *different* core image formatter (not `image`/`responsive_image`), create a formatter that
`extends` that core formatter and `use ImageLinkFormatterTrait;` — exactly how
`ResponsiveImageLinkFormatter extends ResponsiveImageFormatter` does it. The trait needs the parent
to be an image-style-style formatter whose settings include the `image_link` key.
