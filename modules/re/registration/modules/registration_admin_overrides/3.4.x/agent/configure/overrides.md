<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The five overrides

Each override is a boolean **third-party setting** on a `registration_type`, keyed
`registration_admin_overrides`:

| Setting key | Relaxes | Permission required to use |
|---|---|---|
| `status` | host registration being disabled (enabled status) | `registration override status` |
| `maximum_spaces` | the maximum spaces allowed per single registration | `registration override maximum spaces` |
| `capacity` | total host capacity | `registration override capacity` |
| `open` | the open date (register before it) | `registration override open` |
| `close` | the close date (register after it) | `registration override close` |

An override takes effect only when **both** are true: the type has the boolean enabled, and the
account has the matching permission (or `administer registration` / `administer <type> registration`).

## Where it is stored

Config prefix `registration.type.<id>`:

```yaml
third_party_settings:
  registration_admin_overrides:
    status: false
    maximum_spaces: false
    capacity: true      # e.g. allow exceeding capacity for this type
    open: false
    close: true         # and allow late registrations after close
```

## Read / write with drush

```bash
drush cget registration.type.conference third_party_settings.registration_admin_overrides
```

```php
$type = \Drupal\registration\Entity\RegistrationType::load('conference');
$type->setThirdPartySetting('registration_admin_overrides', 'capacity', TRUE);
$type->save();
// read: $type->getThirdPartySetting('registration_admin_overrides', 'capacity');
```

On the UI these appear as checkboxes on the registration type edit form
(`/admin/structure/registration/type/<id>`).

## The checker service

`registration_admin_overrides.checker`
(`Drupal\registration_admin_overrides\RegistrationOverrideChecker`):

- `accountCanOverride(?HostEntity $host, AccountInterface $account, string $setting, …): bool` —
  TRUE when the type enables `$setting` and the account has the override permission (or admin).
- `getOverridableSettings(RegistrationTypeInterface $type): array` — the enabled override keys.

`RegistrationEventSubscriber` and `RegistrationValidationEventSubscriber` consult it during
registration validation to skip the corresponding host constraint.
