<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling registration on an entity (field + per-host settings)

## The `registration` field type

To make a bundle registrable, add a field of type **`registration`** to it (Field UI:
*Manage fields -> Add field -> Registration*, or in code). The field is single-valued and stores
one property, `registration_type` (varchar 32), the id of the `registration_type` that applies to
that host. Field storage setting `allowed_types` (a sequence, `field.field_settings.registration`)
restricts which registration types may be selected. The widget is `registration_type`
(setting `hide_register_tab`); formatters include `registration_form`, `registration_link`,
`registration_id`, `registration_type`, `registration_state`, `registration_host_entity`.

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_registration', 'entity_type' => 'node', 'type' => 'registration',
])->save();
FieldConfig::create([
  'field_name' => 'field_registration', 'entity_type' => 'node', 'bundle' => 'event',
  'label' => 'Registration', 'settings' => ['allowed_types' => ['conference']],
])->save();
```

Once a host has a value in its registration field it becomes a **host entity** and gains three
routes (added dynamically by `RouteSubscriber`, named `entity.<host_type>.registration.*`):

- `…registration.register` — the register form (e.g. `/node/{node}/register`).
- `…registration.manage_registrations` — admin list + broadcast form.
- `…registration.registration_settings` — the per-host settings form.

## Per-host `registration_settings` content entity

Each host has one `registration_settings` entity (created on demand) holding the operational
limits. Base fields (`src/Entity/RegistrationSettings.php`):

| Field | Type | Meaning |
|---|---|---|
| `status` | boolean | registration enabled for this host |
| `capacity` | integer | total spaces (0 = unlimited) |
| `open` / `close` | datetime | window during which registration is allowed |
| `maximum_spaces` | integer | max spaces one registration may reserve (0 = unlimited) |
| `multiple_registrations` | boolean | allow a user to register more than once |
| `send_reminder` | boolean | send a reminder email |
| `reminder_date` | datetime | when to send the reminder |
| `reminder_template` | text_long | reminder body |
| `from_address` | string | From address for this host's mail |
| `confirmation` | string | confirmation message shown after registering |
| `confirmation_redirect` | string | path to redirect to after registering |
| `host_entity`, `entity_type_id`, `entity_id`, `langcode` | — | link back to the host |

Load/modify settings for a host through the `HostEntity` wrapper (see
[../api/services.md](../api/services.md)): `$host->getSettings()`, `$host->getSetting('capacity')`,
or edit them on the host's *Registration settings* tab. Default values for new hosts come from the
`registration_settings.registration_settings` form display and can be edited at
`/admin/structure/registration-settings` (Settings fields / form display links there).

## Registration entities

Each sign-up is a `registration` content entity (`src/Entity/Registration.php`). Notable base
fields: `workflow`, `entity_type_id`/`entity_id` (host), `host_entity`, `anon_mail` (anonymous
registrant email), `user_uid` (registrant account), `author_uid`, `count` (spaces), `mail`,
`state` (workflow state id), `created`, `changed`, `completed`. Collection: `/admin/registrations`
listing; user tab at `/user/{user}/registrations` (`registration.user_registrations`).
