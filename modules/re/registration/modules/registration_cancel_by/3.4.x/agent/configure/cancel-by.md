<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The cancel-by deadline

## Where it lives

`RegistrationCancelByHooks::entityBaseFieldInfo()` adds a **`cancel_by`** datetime base field to the
`registration_settings` entity, and adds a `CancelByConstraint` to that entity type. There is **no**
config object or settings form for this submodule — the deadline is a per-host value stored on the
host's registration settings, edited on the host's *Registration settings* form next to the open and
close dates.

Set/read it on a host's settings entity:

```php
$settings = $host->getSettings();          // Drupal\registration\Entity\RegistrationSettings
$settings->set('cancel_by', '2030-12-31T17:00:00');   // datetime storage format Y-m-d\TH:i:s
$settings->save();
// read: $settings->get('cancel_by')->value;
```

(Standalone settings entities can also be created directly with an `entity_type_id` + `entity_id`
pointing at the host, which is how the eval fixtures set a known `cancel_by`.)

## Enforcement

Cancellation is a workflow **transition** (hence the dependency on Registration Workflow). When a
registrant tries to cancel:

- `CancelByAccessCheck` (wired onto the cancel route by the submodule's `RouteSubscriber`) denies the
  cancel transition once `cancel_by` has passed,
- unless the account has the **`bypass cancel by access`** permission (see
  [../permissions/permissions.md](../permissions/permissions.md)).

If `cancel_by` is empty, there is no deadline and cancellation follows the normal workflow rules.
