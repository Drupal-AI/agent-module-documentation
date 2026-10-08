<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals & API — how the bypass is wired

The module has **no service definitions, routes, controllers, forms, or public API of its own**. It
works by extending/overriding three core Content Moderation pieces. All three consult the same
per-workflow permission (see [../permissions/permissions.md](../permissions/permissions.md)).

## 1. Service-class swap (`ContentModerationBypassServiceProvider`)

`src/ContentModerationBypassServiceProvider.php` (`::alter(ContainerBuilder $container)`) re-classes the
existing core service `content_moderation.state_transition_validation`:

```php
$definition = $container->getDefinition('content_moderation.state_transition_validation');
$definition->setClass('\Drupal\content_moderation_bypass\ContentModerationBypass\ContentModerationBypassStateTransitionValidation');
```

So `\Drupal::service('content_moderation.state_transition_validation')` returns the subclass
`ContentModerationBypassStateTransitionValidation` (verified live). Rebuild the container (`drush cr`)
after enable/uninstall for the swap to apply.

`ContentModerationBypassStateTransitionValidation extends StateTransitionValidation` overrides two
methods:

- `getValidTransitions(ContentEntityInterface $entity, AccountInterface $user)` — if the user holds the
  workflow's bypass permission, returns **all** transitions available from the current state; otherwise
  filters to transitions the user may `use X transition Y` (core behaviour).
- `isTransitionValid(WorkflowInterface $workflow, StateInterface $original_state, StateInterface $new_state, AccountInterface $user, ContentEntityInterface $entity = NULL)` — returns `true` immediately
  for bypass holders; otherwise resolves the transition between the two states and defers to
  `use X transition Y` (core behaviour).

Note `getValidTransitions()` still enumerates transitions **from the current state**, so it alone does
not let a bypass holder jump to an arbitrary state via the widget. The unrestricted "any state" power
comes from the constraint validator below, which is what actually runs on save.

## 2. Constraint that runs on save (`BypassModerationState`)

`content_moderation_bypass_entity_base_field_info_alter(&$fields, $entity_type)` in the `.module`
attaches a constraint to the moderation field of every entity type that has one:

```php
if (isset($fields['moderation_state'])) {
  $fields['moderation_state']->addConstraint('BypassModerationState', []);
}
```

- Constraint plugin id `BypassModerationState` — `BypassModerationStateConstraint` extends core
  `ModerationStateConstraint` (same messages). By Symfony convention its validator is
  `BypassModerationStateConstraintValidator` (extends core `ModerationStateConstraintValidator`).
- `BypassModerationStateConstraintValidator::validate($value, Constraint $constraint)`:
  - returns early if the entity is not moderated (`moderationInformation->isModeratedEntity()`);
  - if the current user holds the workflow bypass permission, **removes** every already-recorded
    violation whose `propertyPath == 'moderation_state'` from the validation context.

This runs **in addition to** core's own `ModerationState` constraint (core adds the transition
violations first; this validator then strips them for bypass holders). It is the authoritative,
save-path enforcement: for a user **without** the permission the `if` is false, so nothing is removed
and core's transition violations stand — the save is blocked exactly as core would block it. The
validator does not call `parent::validate()`; it only prunes core's violations, and only for permission
holders.

## 3. WorkflowType plugin override (`content_moderation`)

`Plugin/WorkflowType/ContentModerationBypass` extends core `ContentModeration` and re-uses the same
plugin **id** `content_moderation`, so it replaces core's plugin for that workflow type. It injects
`current_user` via `create()` and overrides:

- `getTransitionsForState($state_id, $direction = DIRECTION_FROM)` — if the current user holds a
  content_moderation workflow's bypass permission, returns **all** configured transitions (so the state
  `<select>` on the edit form offers every state); otherwise falls back to core's from/to filtering.

## Interacting from code

To act as (or check for) a bypass user, use the exact permission string:

```php
use Drupal\content_moderation_bypass\ContentModerationBypassTrait;

$perm = ContentModerationBypassTrait::permissionForWorkflow($workflow); // 'bypass <id> transition restrictions'
$can  = $account->hasPermission($perm);
```

To programmatically save an entity to an arbitrary moderation state, the acting account must hold that
permission; then set `$entity->set('moderation_state', 'archived')` and `$entity->save()` — the
`BypassModerationState` constraint will drop the transition violation that core would otherwise raise.
There is no request-driven toggle: the only lever is the permission on the acting account.

## Signatures reference

| Class | Method | File |
|---|---|---|
| `ContentModerationBypassStateTransitionValidation` | `getValidTransitions($entity, $user)`, `isTransitionValid($workflow, $orig, $new, $user, $entity=NULL)` | `src/ContentModerationBypass/ContentModerationBypassStateTransitionValidation.php` |
| `BypassModerationStateConstraintValidator` | `validate($value, Constraint $constraint): void` | `src/Plugin/Validation/Constraint/BypassModerationStateConstraintValidator.php` |
| `ContentModerationBypass` (WorkflowType) | `getTransitionsForState($state_id, $direction)`, `create()`, `setAccountInterface()` | `src/Plugin/WorkflowType/ContentModerationBypass.php` |
| `ContentModerationBypassPermission` | `transitionPermissions()` | `src/ContentModerationBypassPermission.php` |
| `ContentModerationBypassTrait` | `permissionForWorkflow(WorkflowInterface): string` | `src/ContentModerationBypassTrait.php` |
| `ContentModerationBypassServiceProvider` | `alter(ContainerBuilder)` | `src/ContentModerationBypassServiceProvider.php` |
