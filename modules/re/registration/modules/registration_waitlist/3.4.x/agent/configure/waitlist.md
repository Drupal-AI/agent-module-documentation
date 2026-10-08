<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wait list configuration

## The `waitlist` state

The module adds a `waitlist` workflow state and replaces the base host-entity handler and the
registration spaces/state widgets. When a host is at capacity, `RegistrationWaitlistHooks` sets a
new registration's `state` to `waitlist` (a `RegistrationDataAlterEvent` lets other modules change
the target state). Wait-listed registrations do not consume standard capacity.

## Per-host settings (on `registration_settings`)

- `registration_waitlist_capacity` — integer, how many wait-list places exist (default 0 = wait
  list effectively off). Validated by `MinimumWaitListCapacityConstraint`.
- `registration_waitlist_autofill` — boolean; when on, freeing a slot or raising capacity promotes
  wait-listed registrations into standard capacity.

Set via the host's registration settings form, or:

```php
$settings->set('registration_waitlist_capacity', 10);
$settings->set('registration_waitlist_autofill', TRUE);
$settings->save();
```

## Per registration type third-party settings (key `registration_waitlist`)

| Key | Type | Meaning |
|---|---|---|
| `confirmation_email` | boolean | send an email when someone is added to the wait list |
| `confirmation_email_subject` | string | subject of that email |
| `confirmation_email_message` | `{value, format}` | body (tokens supported) |
| `autofill_sort_field` | string | field used to order autofill promotion (default `registration_id`) |
| `autofill_sort_order` | string | `ASC` / `DESC` (default ascending = oldest first) |

```php
$type = \Drupal\registration\Entity\RegistrationType::load('conference');
$type->setThirdPartySetting('registration_waitlist', 'confirmation_email', TRUE);
$type->setThirdPartySetting('registration_waitlist', 'confirmation_email_subject', 'You are on the wait list');
$type->save();
// read: drush cget registration.type.conference third_party_settings.registration_waitlist
```

## Views & display

Views fields `HostEntityWaitListSpacesRemaining` / `HostEntityWaitListSpacesReserved`, a
`host-entity-waitlist-indicator` template and a Twig extension expose wait-list occupancy on the host
display and in admin listings.
