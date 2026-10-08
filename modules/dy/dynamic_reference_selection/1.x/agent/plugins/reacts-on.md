# `DynamicReferenceSelectionReactsOn` plugin type + form-field-alter event

A small internal plugin type the module uses to let code alter the reference field element while the
widget form is being built. It is annotation-based (not attribute-based).

- Manager service: **`plugin.manager.dynamic_reference_selection.reacts_on`**
  (`Plugin\DynamicReferenceSelectionReactsOnManager`, `parent: default_plugin_manager`).
- Discovery dir: **`Plugin/DynamicReferenceSelectionReactsOn`**.
- Interface: `DynamicReferenceSelectionReactsOnInterface` (one method: `processForm(array &$form,
  FormStateInterface $form_state)`).
- Base class: `DynamicReferenceSelectionReactsOnPlugin` (empty `processForm()` default).
- Annotation class: `Annotation\DynamicReferenceSelectionReactsOn`.
- Alter hook: **`hook_dynamic_reference_selection_reacts_on_info(&$definitions)`**.
- Cache key: `dynamic_reference_selection_reacts_on_plugins`.

## Annotation fields (`Annotation/DynamicReferenceSelectionReactsOn.php`)

`id`, `label`, `description`, `group`, `eventName`, `priority` (int, bigger first), `hasTargetEntity`
(bool), `hasTargetBundle` (bool).

## Bundled plugin — `form_field_alter`

`Plugin/DynamicReferenceSelectionReactsOn/FormFieldAlter.php`:

```php
/**
 * @DynamicReferenceSelectionReactsOn(
 *   id = "form_field_alter",
 *   label = @Translation("Entity field form alter"),
 *   description = @Translation("Reacts when entity form field is being prepared."),
 *   group = @Translation("Entity"),
 *   eventName = "dynamic_reference_selection.form_field_alter",
 *   hasTargetEntity = TRUE,
 *   hasTargetBundle = TRUE,
 *   priority = 1000,
 * )
 */
class FormFieldAlter extends DynamicReferenceSelectionReactsOnPlugin {}
```

## How it's dispatched

In `dynamic_reference_selection_field_widget_single_element_form_alter()` (`.module:99`) the module
looks up the `form_field_alter` definition, generates a fresh UUID as `loop_control`, loads the
unchanged entity, and dispatches:

```php
$event = new DynamicReferenceSelectionEvent($element, [
  'form_state' => $form_state, 'element' => $element, 'context' => $context,
  'entity_type_id' => …, 'bundle' => …, 'entity' => …, 'entity_unchanged' => …,
  'reacts_on' => $reacts_on_definition, 'loop_control' => $uuid,
]);
$event_dispatcher->dispatch($event, $reacts_on_definition['eventName']); // 'dynamic_reference_selection.form_field_alter'
$element = $event->getArgument('element'); // altered element is written back
```

`DynamicReferenceSelectionEvent` (`Events/…`) is just a Symfony `GenericEvent` subclass — the payload
is the arguments array above; the subject is `$element`.

## Reacting to it (two ways)

The dispatch uses the Symfony event dispatcher keyed on the `eventName`, so the practical extension
point is a **normal event subscriber**:

```php
// my_module.services.yml → tagged 'event_subscriber'
public static function getSubscribedEvents(): array {
  return ['dynamic_reference_selection.form_field_alter' => 'onFormFieldAlter'];
}

public function onFormFieldAlter(\Drupal\dynamic_reference_selection\Events\DynamicReferenceSelectionEvent $event): void {
  $element = $event->getArgument('element');
  // …inspect $event->getArgument('entity') / 'bundle' / 'context'…
  $event->setArgument('element', $element); // written back into the widget
}
```

To register an additional **reacts-on plugin**, add a class under
`Plugin/DynamicReferenceSelectionReactsOn/` with the annotation (giving it its own `eventName`) or
alter definitions via `hook_dynamic_reference_selection_reacts_on_info(&$definitions)`. Note the base
`processForm()` is not invoked by the shipped hook — the shipped flow only dispatches the Symfony
event named by the plugin's `eventName`.
