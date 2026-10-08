# Form Wizard API

Turn several forms into one multi-step flow with tempstore-backed state.

Key classes (`Drupal\ctools\Wizard\`):
- `FormWizardBase` implements `FormWizardInterface` — subclass it and implement:
  - `getOperations($cached_values)` → ordered array of steps, each `['title' => …, 'form' => SomeForm::class]`.
  - `getRouteName()`, `getNextParameters()/getPreviousParameters()` for navigation.
  - `finish(array &$form, FormStateInterface $form_state)` — runs on the last step.
- `EntityFormWizardBase` / `EntityFormWizardInterface` — wizard variant for creating/editing an entity.
- `WizardFactory` (service `ctools.wizard.factory`) builds the wizard form via `getWizardForm()`; it stores per-step values in a `SerializableTempstore` and dispatches `WizardEvent`s.

Routing: a wizard route uses `_wizard: My\Wizard\Class` plus the `ctools.wizard_enhancer` route enhancer, and typically `_ctools_access: 'TRUE'`. Controllers `ctools.wizard.form` / `ctools.wizard.entity.form` render it.

```php
class ExampleWizard extends FormWizardBase {
  public function getRouteName() { return 'example.wizard.step'; }
  public function getOperations($cached_values) {
    return [
      'one' => ['title' => $this->t('Step one'), 'form' => StepOneForm::class],
      'two' => ['title' => $this->t('Step two'), 'form' => StepTwoForm::class],
    ];
  }
  public function finish(array &$form, FormStateInterface $form_state) {
    $values = $form_state->getTemporaryValue('wizard'); // collected step data
    parent::finish($form, $form_state);
  }
}
```

Step forms read/write shared state via `$form_state->getTemporaryValue('wizard')`. The factory clears the tempstore on finish.
