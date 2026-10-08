<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Multistep — custom step controller

## The hook
`hook_simple_multistep_controller_alter(array &$form)` (declared in
`simple_multistep.api.php`) lets a module replace the controller class used for a given
form. `simple_multistep_register_controller()` sets a default of
`MultistepController::class` on `$form['#multistep_controller']`, invokes the alter, then
requires the result to implement `MultistepControllerInterface` (throws `\RuntimeException`
otherwise).

```php
/**
 * Implements hook_simple_multistep_controller_alter().
 */
function my_module_simple_multistep_controller_alter(array &$form) {
  // Optionally scope to a specific form id.
  if ($form['#form_id'] === 'node_article_form') {
    $form['#multistep_controller'] = '\Drupal\my_module\MyMultistepController';
  }
}
```

The alter receives the form by reference (only `$form` — no `$form_state` argument in the
hook signature). The controller is instantiated as
`new $form['#multistep_controller']($form, $form_state)` inside `simple_multistep_form_alter()`.

## The interface
`Drupal\simple_multistep\MultistepControllerInterface`:
```php
public function rebuildForm(array &$form): void;
```
Your class must implement it. In practice, subclass the shipped
`Drupal\simple_multistep\MultistepController` (constructed with `($form, $form_state)`) and
override only what you need — it already handles step tracking (`getCurrentStep()`,
`increaseStep()`, `reduceStep()`, `updateStepInfo()`, `setFormState()`) and building the
step UI via the `FormStep`, `FormButton`, `FormText`, and `StepIndicator` helpers. Override
`rebuildForm()` (and/or the button/step-indicator building) to customize navigation,
validation gating, or the progress display.

Nothing else is pluggable — there are no services to decorate; the controller swap is the
extension point.
