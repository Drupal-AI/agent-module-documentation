<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Write a custom Source plugin

A Source plugin supplies the value for a component prop or slot. Add one to expose new
data (a computed value, an external API, a custom entity property) to **every** component
usable in the site.

Place it in `your_module/src/Plugin/UiPatterns/Source/MySource.php`:

```php
namespace Drupal\your_module\Plugin\UiPatterns\Source;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\ui_patterns\Attribute\Source;
use Drupal\ui_patterns\SourcePluginBase;

#[Source(
  id: 'my_greeting',
  label: new TranslatableMarkup('Greeting'),
  description: new TranslatableMarkup('A canned greeting string.'),
  // Restrict to compatible PropType ids; omit tags to offer it broadly.
  prop_types: ['string'],
)]
class MySource extends SourcePluginBase {

  public function getPropValue(): mixed {
    // $this->getSetting('name') reads this source's stored settings.
    return 'Hello ' . ($this->getSetting('name') ?? 'world');
  }

  public function settingsForm(array $form, \Drupal\Core\Form\FormStateInterface $fs): array {
    $form['name'] = ['#type' => 'textfield', '#title' => $this->t('Name'),
      '#default_value' => $this->getSetting('name')];
    return $form;
  }
}
```

Key points:
- Extend `SourcePluginBase` and implement `getPropValue()`. Use the `#[Source]` attribute
  (namespace `Drupal\ui_patterns\Attribute\Source`).
- `prop_types` lists the PropType ids this source can feed; the config UI only offers it
  for matching props. Implement `SourceWithChoicesInterface` if the source itself is a set.
- Add cacheability metadata via `$this->addCacheableDependency(...)` when the value depends
  on entities/config so component render caching stays correct.
- After adding the class run `drush cr`; the new source appears in every prop/slot picker
  whose PropType matches.

## Alter hooks instead of a plugin

For lighter changes you don't need a plugin — see
[../api/services-and-hooks.md](../api/services-and-hooks.md) for
`hook_ui_patterns_source_value_alter()`, `hook_component_info_alter()`, and
`hook_ui_patterns_component_pre_build_alter()`.
