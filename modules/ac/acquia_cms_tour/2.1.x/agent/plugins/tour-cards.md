<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `@AcquiaCmsTour` (dashboard cards)

A `@AcquiaCmsTour` plugin is one **card** on the CMS Dashboard / installation wizard — a small
config form for one contrib module (Geocoder, reCAPTCHA, Google Tag Manager ship built-in; other
`acquia_cms_*` modules add their own, e.g. Site Studio/`cohesion`, `google_analytics`).

## Moving parts

| Piece | Class / id |
|---|---|
| Annotation | `Drupal\acquia_cms_tour\Annotation\AcquiaCmsTour` (`@Annotation`) |
| Manager service | `plugin.manager.acquia_cms_tour` → `AcquiaCmsTourManager` |
| Discovery dir | `Plugin/AcquiaCmsTour/` in any module |
| Interface | `Drupal\acquia_cms_tour\AcquiaCmsTourInterface` |
| Base class | `Drupal\acquia_cms_tour\AcquiaCmsTourPluginBase` (label/weight helpers only) |
| Form base actually used | `Drupal\acquia_cms_tour\Form\AcquiaCmsDashboardBase` (a `ConfigFormBase`) |
| Alter hook | `acquia_cms_tour_info` → `hook_acquia_cms_tour_info_alter(&$definitions)` |
| Cache bin/tag | `acquia_cms_tour_plugins` |

Annotation keys: `id` (should be the target module's machine name), `label`
(`@Translation`), `weight` (int; lower sorts first). The manager sorts definitions by `weight`
(`SortArray::sortByWeightElement`) and exposes `getTourManagerPlugin()` → definitions keyed by id.

## What a card must implement

In practice cards extend `AcquiaCmsDashboardBase`, not the bare `AcquiaCmsTourPluginBase`, because
the dashboard/wizard call form + state methods on each instance. Required surface:

- `protected $module = '<machine_name>'` — the contrib module this card configures.
- `getFormId()`, `getEditableConfigNames()`, `buildForm()`, `submitForm()` — normal form methods.
- `ignoreConfig(array &$form, FormStateInterface $form_state)` — the "Ignore"/"Skip" button submit;
  usually just `$this->setConfigurationState();`.
- `checkMinConfiguration(): bool` — abstract on the base; return TRUE when the target module's
  minimum config is already present (drives the green check + completion count).

`AcquiaCmsDashboardBase` provides `isModuleEnabled()`, `getModule()`, `getModuleName()`,
`getConfigurationState()`, `getStateName()` (→ `acms_<module>_configured`), and
`setConfigurationState()`. The controller calls `isModuleEnabled()` to decide whether to render the
card at all.

## Add a card

```php
// my_module/src/Plugin/AcquiaCmsTour/MyIntegrationForm.php
namespace Drupal\my_module\Plugin\AcquiaCmsTour;

use Drupal\acquia_cms_tour\Form\AcquiaCmsDashboardBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @AcquiaCmsTour(
 *   id = "my_module",
 *   label = @Translation("My Integration"),
 *   weight = 10
 * )
 */
class MyIntegrationForm extends AcquiaCmsDashboardBase {

  protected $module = 'my_module';

  public function getFormId() { return 'my_module_acms_card'; }

  protected function getEditableConfigNames() { return ['my_module.settings']; }

  public function buildForm(array $form, FormStateInterface $form_state) {
    if (!$this->isModuleEnabled()) { return $form; }
    $form['api_key'] = [
      '#type' => 'textfield',
      '#title' => $this->t('API key'),
      '#default_value' => $this->config('my_module.settings')->get('api_key'),
    ];
    // Add the Save/Ignore actions the dashboard expects.
    return $form;
  }

  public function submitForm(array &$form, FormStateInterface $form_state) {
    $this->config('my_module.settings')
      ->set('api_key', $form_state->getValue('api_key'))->save();
    $this->setConfigurationState();
  }

  public function ignoreConfig(array &$form, FormStateInterface $form_state) {
    $this->setConfigurationState();
  }

  public function checkMinConfiguration(): bool {
    return (bool) $this->config('my_module.settings')->get('api_key');
  }
}
```

## Reorder / swap another module's card

Implement the alter hook (from `acquia_cms_tour.api.php`):

```php
function my_module_acquia_cms_tour_info_alter(array &$definitions) {
  if (isset($definitions['google_tag'])) {
    $definitions['google_tag']['weight'] = 1;
    $definitions['google_tag']['class'] = '\Drupal\my_module\Form\GoogleForm';
  }
}
```
