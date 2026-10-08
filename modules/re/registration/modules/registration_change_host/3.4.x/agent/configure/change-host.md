<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change host configuration & API

## Settings — `registration_change_host.settings`

Defaults from `config/install/registration_change_host.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `workflow` | `multistep` | change flow: `multistep` (pick host page + confirm form) or `single_step` |
| `task_title` | `Change @host_type_label` | the local task (tab) label |
| `form_title` | `Change @host_type_label for Registration #%id` | single-step form title |
| `page_title` | `Select @host_type_label` | multistep host-selection page title |
| `confirm_form_title` | `Confirm change of @host_type_label for Registration #%id` | multistep confirm title |

Titles support placeholders `@host_type_label` and `%id`.

```php
\Drupal::configFactory()->getEditable('registration_change_host.settings')
  ->set('workflow', 'single_step')->save();
// read: drush cget registration_change_host.settings
```

(Values: `multistep` (default) or `single_step`; the controller uses the `SingleStepChangeHostForm`
when `workflow` is `single_step`.)

## Per registration type: `allow_data_loss`

Third-party boolean on the registration type (schema
`registration.type.*.third_party.registration_change_host`), default false. When true, a registration
may be moved to a host of a **different** registration type even though type-specific field data may
be dropped.

```php
$type->setThirdPartySetting('registration_change_host', 'allow_data_loss', TRUE);
$type->save();
```

## Manager service — `registration_change_host.manager`

`Drupal\registration_change_host\RegistrationChangeHostManagerInterface`:

- `getPossibleHosts(RegistrationInterface $registration): PossibleHostSetInterface`
- `changeHost($registration, $host_entity_type_id, $host_entity_id, $always_clone = FALSE): RegistrationInterface`
- `isDataLostWhenHostChanges($registration, $host_entity_type_id, $host_entity_id, $ignore_data = FALSE): bool`
- `saveChangedHost($registration, HostEntity $old_host, callable $save_callback): int`

Routes: `entity.registration.change_host` (`/registration/{registration}/host`) and
`registration_change_host.change_host_form`
(`/registration/{registration}/update/{host_id}/{host_type_id}`); both require entity access
`registration.change host`. A `RegistrationChangeHostPossibleHostsEvent` allows altering the
candidate hosts.
