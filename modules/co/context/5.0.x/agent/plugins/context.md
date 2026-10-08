# Plugin type: ContextReaction (write a custom reaction)

Context defines **one** plugin type — the reaction. (Conditions are *not* a Context plugin
type; they reuse core `plugin.manager.condition`.)

| | |
|---|---|
| Plugin manager service | `plugin.manager.context_reaction` (`Drupal\context\ContextReactionManager`, `parent: default_plugin_manager`) |
| Plugin namespace | `Plugin/ContextReaction` |
| Annotation | `@ContextReaction` (`Drupal\context\Reaction\Annotation\ContextReaction`; props `id`, `label`, `description`) |
| Interface | `Drupal\context\ContextReactionInterface` |
| Base class | `Drupal\context\ContextReactionPluginBase` |
| Alter hook | `hook_context_condition_info_alter()` (manager `alterInfo('context_condition_info')`) |

The interface extends `ConfigurableInterface`, `PluginFormInterface`,
`PluginInspectionInterface`, `ExecutableInterface`, and adds `getId()` and `summary()`. The
base class implements config handling and a default `defaultConfiguration()` of
`['saved' => FALSE]`; you supply the reaction's config form and `execute()`.

## Minimal reaction

```php
namespace Drupal\my_module\Plugin\ContextReaction;

use Drupal\context\ContextReactionPluginBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @ContextReaction(
 *   id = "my_reaction",
 *   label = @Translation("My reaction")
 * )
 */
class MyReaction extends ContextReactionPluginBase {

  public function summary() {
    return $this->t('Does something when the context is active.');
  }

  public function defaultConfiguration() {
    return ['message' => ''] + parent::defaultConfiguration();
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['message'] = ['#type' => 'textfield', '#default_value' => $this->configuration['message']];
    return $form;
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) {
    $this->configuration['message'] = $form_state->getValue('message');
  }

  // ExecutableInterface: called by your integration point.
  public function execute() {
    return $this->configuration['message'];
  }
}
```

## Firing a reaction

Context does **not** auto-run arbitrary reactions — each built-in reaction is wired in by a
hook/subscriber (e.g. `context_preprocess_html` runs `body_class`/`page_title`/`regions`;
`context_theme_suggestions_page_alter` runs `page_template_suggestions`;
`BlockPageDisplayVariantSubscriber` runs `blocks`; the theme negotiator runs `theme`). To run
your custom reaction, add your own integration point that calls
`\Drupal::service('context.manager')->getActiveReactions('my_reaction')` and invokes
`->execute()` on each (see [../api/context.md](../api/context.md)). Add a
`config/schema/*.schema.yml` entry `reaction.plugin.my_reaction` so the config validates.
