<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration types, workflow & global settings

## `registration_type` config entity

Config prefix: **`registration.type.<id>`** (e.g. `registration.type.conference`). Collection UI:
`/admin/structure/registration/type` (`entity.registration_type.collection`); add form
`entity.registration_type.add_form`. Exported keys (from `config/schema` +
`src/Entity/RegistrationType.php`):

| Key | Meaning |
|---|---|
| `id` / `label` | machine name / human label |
| `workflow` | id of a `workflows.workflow` of type `registration` (default `registration`) |
| `defaultState` | state new registrations start in (default `pending`) |
| `heldExpireTime` | integer hours a **held** registration is kept before expiring (0 = never) |
| `heldExpireState` | state a held registration moves to when it expires (e.g. `canceled`) |

Getter/setter methods: `getWorkflowId()/setWorkflowId()`, `getDefaultState()/setDefaultState()`,
`getHeldExpirationTime()/setHeldExpirationTime()`, `getHeldExpirationState()/setHeldExpirationState()`,
plus helpers `getActiveStates()`, `getHeldStates()`, `getStatesToShowOnForm()`. A registration type
is also a **field bundle**: you add fields to it at
`/admin/structure/registration/type/<id>/fields` to collect extra data per registration.

Create one with drush:

```php
\Drupal\registration\Entity\RegistrationType::create([
  'id' => 'conference', 'label' => 'Conference',
  'workflow' => 'registration', 'defaultState' => 'pending',
  'heldExpireTime' => 24, 'heldExpireState' => 'canceled',
])->save();
```

Read back: `drush cget registration.type.conference` (or `RegistrationType::load('conference')`).

## The registration Workflow

The module ships a `workflows.workflow` config entity `registration` of **type `registration`**
(`workflow.type_settings.registration` schema). Default states: **pending**, **complete**,
**held**, **canceled**; transitions: complete (pending/held -> complete), hold (pending -> held),
cancel (-> canceled). Each state carries flags `active`, `canceled`, `held`, `show_on_form` plus a
`description` (`registration.state` schema). `default_registration_state` and
`complete_registration_state` on the workflow tell the module which state is the start and which
counts as "completed". You can create additional registration workflows (type `registration`) and
point a registration type at them via `workflow`.

## Global settings — `registration.settings`

Config object edited at **`/admin/structure/registration-settings`**
(`registration.admin_settings`, permission *administer registration*). Keys (defaults in
`config/install/registration.settings.yml`):

| Key | Default | Purpose |
|---|---|---|
| `set_and_forget` | false | deprecated set-and-forget reminder mode |
| `broadcast_filter` | true | add a status filter to the Email Registrants form |
| `lenient_access_check` | false | ignore open/close dates in the register access check |
| `limit_field_values` | false | limit registration field values by role |
| `hide_filter` | 10 | Manage Registrations filter threshold |
| `queue_notifications` | 50 | queue notifications above this recipient count |
| `html_email` | false | send email as HTML |
| `prevent_edit_disabled` | true | block editing existing registrations when new registration is disabled |
| `replace_from_header` | false | replace the "From" header on outgoing mail |
| `sync_registration_settings` | true | synchronise registration settings across languages |
| `sync_registration_settings_all_fields` | false | synchronise all settings fields, not just untranslatable ones |

Read/write: `drush cget registration.settings`, `drush cset registration.settings html_email true -y`.
