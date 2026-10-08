<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — service decoration and validation methods

The module ships no routes, forms, or public service API. Its only runtime hook into Drupal is a
**service decorator** on core Content Moderation's transition-validation service.

## The service provider
`src/ContentModerationOwnerPermissionsServiceProvider.php` —
`ContentModerationOwnerPermissionsServiceProvider extends ServiceProviderBase`. Its `alter()` runs at
container-compile time:

```php
public function alter(ContainerBuilder $container) {
  $modules = $container->getParameter('container.modules');
  if (isset($modules['content_moderation'])) {
    $def = new Definition(OwnerStateTransitionValidation::class, [
      new Reference('content_moderation.moderation_information'),
    ]);
    $def->setPublic(TRUE);
    $def->setDecoratedService('content_moderation.state_transition_validation');
    $container->setDefinition('content_moderation_owner_permissions.state_transition_validation', $def);
  }
}
```

Key points for an agent:
- Decoration is done in a `ServiceProvider`, **not** a `*.services.yml`, on purpose: core registers
  `content_moderation.state_transition_validation` conditionally, and Drupal does not support
  decorating an optional service through the normal `decorates:` key.
- The decorator is only installed when the `content_moderation` module is enabled; otherwise the
  service is untouched.
- After the decoration, any consumer that injects `content_moderation.state_transition_validation`
  (the service id is unchanged) transparently receives `OwnerStateTransitionValidation`.

## The decorator class
`src/OwnerStateTransitionValidation.php` —
`OwnerStateTransitionValidation extends \Drupal\content_moderation\StateTransitionValidation
implements StateTransitionValidationInterface`. Constructor takes the moderation-information service.
It overrides two methods; both add the own-content permissions on top of core's behavior and fall
back to `parent::` for everything else.

### `getValidTransitions(ContentEntityInterface $entity, AccountInterface $user)`
Builds the list of transitions offered to a user for an entity. When the entity has a `uid` field and
its owner is the acting user, the method adds the transitions for which the user holds
`use <workflow_id> transition <transition_id> for own content`, then merges core's globally-permitted
transitions (`array_merge($valid_transitions, parent::getValidTransitions($entity, $user))`).

**Consumed by:**
- `ModerationStateWidget::formElement()` (core `moderation_state_default` widget) — populates the
  "Change to" / "Save as" select on entity edit forms.
- `EntityModerationForm::buildForm()` (core `content_moderation_entity_moderation_form`) — the
  standalone moderation form on the latest-revision tab.

### `isTransitionValid(WorkflowInterface $workflow, StateInterface $original_state, StateInterface $new_state, AccountInterface $user, ?ContentEntityInterface $entity = NULL)`
Resolves the transition between the two states and returns TRUE when the acting user holds the
matching `use <workflow_id> transition <transition_id> for own content` permission; otherwise it
defers to `parent::isTransitionValid()` (core's global-permission check).

**Consumed by:**
- `ModerationStateConstraintValidator::validate()` (core `ModerationState` constraint on the
  `moderation_state` field) — the save-time gate that runs on **every** entity save path, including
  the entity/edit forms, the moderation form, and API writes (JSON:API / REST).

## Notes for operating the module
- Own-content permissions are additive: they never remove a transition core already allows.
- To make the own-content scope actually restrict a role, withhold the corresponding global
  `use <workflow> transition <transition>` permission — otherwise the global permission alone already
  grants the transition on all content.
- The interface method signature differs slightly from core (the `$entity` argument is nullable here);
  callers in core always pass the entity.
