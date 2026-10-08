<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin surface

## `RegistrationConstraint` — host-level validation plugins (the one custom plugin type)

Manager service `registration.validation.constraint`
(`Drupal\registration\Validation\RegistrationConstraintManager`), discovered from
**`Plugin/Validation/RegistrationConstraint/`**, attribute/annotation
`@RegistrationConstraint(id=…, label=…)`. These validate a whole registration against its host
(distinct from field-level `Symfony`/core constraints). Shipped plugins:

- `HostIsEnabled`, `HostIsOpen`, `HostHasRoom`, `HostHasSettings`, `HostAllowsRegistrant`
- `RegistrationWithinCapacity`, `RegistrationWithinMaximumSpaces`, `RegistrationAllowsRegistrant`,
  `RegistrationAllowsUpdate`, `RegistrationIsEditable`, `UniqueRegistrant`

Implement your own by adding a class under your module's
`src/Plugin/Validation/RegistrationConstraint/` with the `@RegistrationConstraint` attribute and a
matching `…Validator`, extending `RegistrationConstraintBase`. The `RegistrationValidator` service
runs all of them and returns a `RegistrationValidationResult`. (There is also a `RegistrationConstraint`
in `Plugin/Validation/Constraint/` — the core typed-data constraint that triggers this whole set on
the registration entity.)

## `registration` WorkflowType plugin

`Drupal\registration\Plugin\WorkflowType\Registration` (`id = registration`) is a core Workflows
`WorkflowType` plugin. It is why registration workflows carry the extra state flags
(`active`/`canceled`/`held`/`show_on_form`) and the `default_registration_state` /
`complete_registration_state` settings. You normally use it via the shipped `registration` workflow
rather than coding against it.

## Actions (core Action plugins)

- `registration_send_email_action` (`RegistrationEmailAction`) — email registrants; also the plugin
  Scheduled Action schedules.
- `registration_views_set_state_action` (`RegistrationSetStateAction`) — bulk-set the workflow state
  of registrations (used from the Manage Registrations Views list).

## Block

`registration_status` (`Drupal\registration\Plugin\Block\RegistrationStatus`, derived per host) —
renders remaining/reserved spaces and open/closed/full/disabled messages; message strings are block
settings (`block.settings.registration_status:*` schema: `enabled`, `disabled_before_open`,
`disabled_after_close`, `disabled_capacity`, `disabled`, `remaining_spaces_single/plural`).

## Views & tokens

Extensive Views integration (`registration.views.inc`): host fields
`HostEntitySpacesReserved/Remaining`, `HostEntityRegistrationCount`, `HostEntityUserIsRegistered`,
matching filters, and `Registration`/`RegistrationSettings` relationships. Tokens are provided via
`registration.tokens.inc` (`hook_token_info` / `hook_tokens`) for registration and host data used in
reminder/confirmation templates.
