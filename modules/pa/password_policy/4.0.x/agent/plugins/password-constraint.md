# Plugin type: PasswordConstraint

Password Policy **defines** this plugin type; every rule is one of these plugins.

- Manager: `plugin.manager.password_policy.password_constraint`
  (`PasswordConstraintPluginManager`, extends `default_plugin_manager`).
- Discovery: annotation `@PasswordConstraint` (`src/Annotation/PasswordConstraint.php`).
- Directory: `src/Plugin/PasswordConstraint/`.
- Interface: `PasswordConstraintInterface` (extends `ConfigurableInterface`,
  `PluginFormInterface`); base class `PasswordConstraintBase`.

Annotation keys: `id`, `title`, `description`, `errorMessage` (all translatable).

Implement:
```php
namespace Drupal\mymod\Plugin\PasswordConstraint;

use Drupal\password_policy\PasswordConstraintBase;
use Drupal\password_policy\PasswordPolicyValidation;
use Drupal\user\UserInterface;

/**
 * @PasswordConstraint(
 *   id = "my_rule",
 *   title = @Translation("My rule"),
 *   description = @Translation("What it checks"),
 *   errorMessage = @Translation("Why it failed")
 * )
 */
class MyRule extends PasswordConstraintBase {

  public function validate($password, UserInterface $user) {
    $validation = new PasswordPolicyValidation();
    if (/* fails */) {
      $validation->setErrorMessage($this->t('Reason shown to the user.'));
    }
    return $validation;             // no error message set = passes
  }

  public function defaultConfiguration() { return ['threshold' => 1]; }

  public function buildConfigurationForm(array $form, FormStateInterface $fs) {
    $form['threshold'] = ['#type' => 'number', '#default_value' => $this->getConfiguration()['threshold']];
    return $form;
  }
  public function submitConfigurationForm(array &$form, FormStateInterface $fs) {
    $this->configuration['threshold'] = $fs->getValue('threshold');
  }
  public function getSummary() { return $this->t('Summary: @n', ['@n' => $this->getConfiguration()['threshold']]); }
}
```

Need services (DB, entity manager)? Implement `ContainerFactoryPluginInterface`
with `create()`/`__construct()` — see `password_policy_history` and
`password_policy_delay`. Add config schema at
`password_policy.constraint.plugin.<id>` (`type: password_policy.constraint.plugin`).
`getSummary()` is shown on the policy; `validate()` returning a validation with an
error message blocks the save.
