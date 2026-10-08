<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow transitions & settings

## Settings — `registration_workflow.settings`

Defaults from `config/install/registration_workflow.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `require_update_access` | true | user must also have update access to the registration to transition it |
| `prevent_complete_own` | false | when true, users may not run the *complete* transition on their own registrations |

```php
\Drupal::configFactory()->getEditable('registration_workflow.settings')
  ->set('prevent_complete_own', TRUE)->save();
// read: drush cget registration_workflow.settings
```

## Transitions in the UI

- `RegistrationWorkflowHooks::entityOperation()` adds a **Cancel** operation to registrations in
  listings (links to the transition route).
- On a registration's own page, a button is rendered for each **valid** transition returned by
  `\Drupal::service('registration_workflow.validation')->getValidTransitions($registration)`
  (cancel is excluded there since it is already an entity operation).
- Route `registration_workflow.transition`
  (`/registration/{registration}/transition/{transition}`) → `StateTransitionForm`, protected by the
  `_state_transition_access_check` (`StateTransitionAccessCheck`).

## Access model

A transition is allowed when: the account has the `use <workflow> <transition> transition`
permission, the transition is valid from the current state, and — if `require_update_access` is true
— the account also has update access to the registration. `prevent_complete_own` additionally blocks
the *complete* transition on one's own registration. See
[../permissions/permissions.md](../permissions/permissions.md).

## ECA

Registration state changes surface as workflow events, so ECA Workflow models can react to (or drive)
registration transitions when the `eca` module is installed.
