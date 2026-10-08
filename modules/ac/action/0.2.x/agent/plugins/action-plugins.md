<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a configurable Action plugin

The Action **plugin type** is defined by Drupal core (`plugin.manager.action`,
`Drupal\Core\Action\Attribute\Action`), not by this module. This module ships three
*configurable* examples (`src/Plugin/Action/`) and provides the UI that lets admins
create/configure instances of any configurable Action as `action.action.*` config
entities. To make your own advanced action appear in the "Create an advanced action"
select and get a config form, follow the same pattern.

## Simple vs configurable

- **Simple action** — extend `Drupal\Core\Action\ActionBase`. No config form; appears
  automatically in the actions list. Nothing to configure.
- **Configurable (advanced) action** — extend
  `Drupal\Core\Action\ConfigurableActionBase` and implement
  `PluginFormInterface` (`buildConfigurationForm` / `validateConfigurationForm` /
  `submitConfigurationForm`) + `defaultConfiguration()`. The Actions UI edit form
  (`ActionFormBase`) embeds your config form.

## Skeleton (mirrors `UnpublishByKeywordNode`)

```php
namespace Drupal\my_module\Plugin\Action;

use Drupal\Core\Action\ConfigurableActionBase;
use Drupal\Core\Action\Attribute\Action;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Session\AccountInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[Action(
  id: 'my_flag_by_keyword_action',
  label: new TranslatableMarkup('Flag content containing keyword(s)'),
  type: 'node',            // target entity type id; drives which entities it applies to
)]
class MyFlagByKeyword extends ConfigurableActionBase {

  public function defaultConfiguration() {
    return ['keywords' => []];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['keywords'] = [
      '#type' => 'textarea',
      '#title' => $this->t('Keywords'),
      '#default_value' => implode(', ', $this->configuration['keywords']),
    ];
    return $form;
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) {
    $this->configuration['keywords'] = array_map('trim',
      explode(',', $form_state->getValue('keywords')));
  }

  public function execute($entity = NULL) {
    // Do the work on $entity (matched by the `type` above).
  }

  public function access($object, ?AccountInterface $account = NULL, $return_as_object = FALSE) {
    $result = $object->access('update', $account, TRUE);
    return $return_as_object ? $result : $result->isAllowed();
  }
}
```

Add a config schema entry so the saved instance validates:

```yaml
# my_module.schema.yml
action.configuration.my_flag_by_keyword_action:
  type: mapping
  label: 'Flag content containing keyword(s) configuration'
  mapping:
    keywords:
      type: sequence
      sequence:
        type: string
```

## Notes from the shipped plugins

- `type` selects the entity type the action operates on (`node`, `comment`, `user`, …).
  Simple actions with a specific `type` are auto-listed; configurable ones need the UI.
- Need services? implement `ContainerFactoryPluginInterface` and add a
  `create()`/`__construct()` (see `AssignOwnerNode` injecting `database`,
  `UnpublishByKeywordComment` injecting the comment view builder + renderer).
- `execute()` receives one entity; core calls `executeMultiple()` for bulk. Save the
  entity yourself inside `execute()` if you mutate it (the shipped plugins call
  `$entity->save()`).
- Keyword parsing in the shipped plugins uses `Drupal\Component\Utility\Tags`
  (`Tags::explode()` / `Tags::implode()`), which understands quoted, comma-separated
  phrases like `funny, "Company, Inc."`.
