# The `tour_tip` plugin type

Tour defines one plugin type: **tour tips**. A tip renders a single step of a tour.

- Plugin manager: `plugin.manager.tour.tip` (`Drupal\tour\TipPluginManager`).
- Discovery: attribute `#[Tip]` (`Drupal\tour\Attribute\Tip`, args `id`, `title`); legacy
  annotation `Drupal\tour\Annotation\Tip` also supported.
- Namespace: `Plugin/tour/tip` (e.g. `src/Plugin/tour/tip/MyTip.php`).
- Interface: `Drupal\tour\TipPluginInterface`; base class: `Drupal\tour\TipPluginBase`.
- Alter hook for definitions: `tour_tips_info` (see `hook_tour_tips_info_alter()`).
- Cache bin key: `tour_plugins`. Definitions are cleared on tour insert/update.

Bundled plugin: **`text`** (`TipPluginText`) — renders a token-replaced `<p>` body.

## Implementing a tip plugin

```php
namespace Drupal\my_module\Plugin\tour\tip;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\tour\Attribute\Tip;
use Drupal\tour\TipPluginBase;

#[Tip(
  id: 'my_tip',
  title: new TranslatableMarkup('My tip'),
)]
class MyTip extends TipPluginBase {

  // Add per-tip config keys.
  public function defaultConfiguration(): array {
    return parent::defaultConfiguration() + ['body' => ''];
  }

  // Return a render array for the tip's content.
  public function getBody(): array {
    return ['#type' => 'html_tag', '#tag' => 'p', '#value' => $this->get('body')];
  }

  // Add form elements for the tip's config UI (call parent first).
  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form = parent::buildConfigurationForm($form, $form_state);
    $form['body'] = ['#type' => 'textarea', '#title' => $this->t('Body')];
    return $form;
  }
}
```

`TipPluginBase` already provides `id()`, `getLabel()`, `getWeight()`, `getSelector()`,
`getLocation()` (Popper position), `get()/set()`, `getConfiguration()`, and the base config
form (label, id, weight, selector, position). Use `ContainerFactoryPluginInterface` for DI
(as `TipPluginText` does for the token service). New plugin ids become available as tip
`{type}` options at `tour.tip.add`.

## Related alter hooks (`tour.api.php`)

- `hook_tour_tips_alter(array &$tour_tips, EntityInterface $entity)` — mutate the
  instantiated tip objects (e.g. change a `body`) before render. Invoked in
  `Tour::getTips()`.
- `hook_tour_tips_info_alter(&$info)` — change tip plugin definitions (e.g. swap the class
  backing the `text` id).
- `hook_tour_build_alter(array &$build, array $entities)` — alter the final render array
  (e.g. attach a library). Invoked at the end of `TourViewBuilder::viewMultiple()`.
