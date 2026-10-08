<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API

## `HostEntity` — the wrapper around a registrable entity

You rarely touch a host node directly; you wrap it. Get a host entity via the host-entity handler
or from the `registration_host_entity` computed field. Interface `HostEntityInterface`
(`src/HostEntity.php`) — the workhorse for questions about capacity and eligibility:

- `createRegistration(bool $save = FALSE)` / `generateSampleRegistration()` — build a registration for this host.
- `getRegistrationCount()`, `getActiveSpacesReserved()`, `getSpacesRemaining()` — occupancy.
- `getSettings()` : `RegistrationSettings`, `getSetting($key)`, `getDefaultSettings($langcode)`.
- `getRegistrationType()`, `getRegistrationTypeBundle()`, `getRegistrationField()`.
- `getOpenDate()`, `getCloseDate()`, `getReminderDate()`, `isBeforeOpen()`, `isAfterClose()`.
- `hasRoom(int $spaces = 1)`, `hasRoomForRegistration()`, `isOpenForRegistration()`,
  `isAvailableForRegistration()`, `isEnabledForRegistration()`, `isConfiguredForRegistration()`.
- `isUserRegistered($account)`, `isEmailRegistered($email)`, `isRegistrant()`,
  `isUserRegisteredInStates()`, `isEmailRegisteredInStates()`.
- `getRegistrationList(array $states = [])`, `getRegistrationQuery(...)`, `isEditableRegistration()`.
- `validate($value)` : `RegistrationValidationResultInterface`.

Most of these return a bool by default, or a `RegistrationValidationResultInterface` when called
with `$return_as_object = TRUE` (carrying the failing constraint's reason and cacheability).

## Services (autowired; inject by interface)

| Service id | Interface | Use |
|---|---|---|
| `registration.manager` | `RegistrationManagerInterface` | site-level helpers |
| `registration.validator` | `RegistrationValidatorInterface` | run the constraint set against a registration |
| `registration.notifier` | `RegistrationMailerInterface` | send registrant emails / broadcasts |
| `registration.field_manager` | `RegistrationFieldManagerInterface` | discover registration fields (`autowire: false`) |

`RegistrationManagerInterface` (`src/RegistrationManager.php`) highlights:
`getRegistrationEnabledEntityTypes()`, `hasRegistrationField($entity_type, $bundle)`,
`getRegistrationFieldDefinitions()`, `getEntityFromParameters($params, $return_host_entity)`,
`getRoute($entity_type, $route_id)`, `getBaseRouteName($entity_type)`,
`getWorkflowStateOptions($show_on_form_only)`, `getRegistrantOptions($registration, $settings)`,
`userHasRegistrations($user)`.

## Loading things by hand

```php
// The registration_type of a host node's field, then a HostEntity wrapper.
$handler = \Drupal::entityTypeManager()->getHandler('node', 'registration_host_entity');
$host = $handler->createHostEntity($node);
$remaining = $host->getSpacesRemaining();          // int|null (null = unlimited)
$open = $host->isOpenForRegistration();            // bool
$settings = $host->getSettings();                  // RegistrationSettings entity
```

Cron services `Drupal\registration\Cron\ExpireHeldRegistrations` and `…\SendReminders` run on cron
(also exposed as queue workers `SendReminders`, `ExpireHeldRegistrations`, `Notify`). The only hook
the module invites is **`hook_registration_host__access($host_entity, $operation, $account)`** in
`registration.api.php` — return an `AccessResult` to grant/deny host operations (view/update/delete/
manage/register…); results are OR-combined.
