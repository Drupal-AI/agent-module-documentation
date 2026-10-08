<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CAS Attributes event subscriber

`Drupal\cas_attributes\Subscriber\CasAttributesSubscriber` (autowired via
`cas_attributes.services.yml`, `autoconfigure: true`) is the entire runtime.

```php
CasPreRegisterEvent::class => ['onPreRegister', -1]
CasPreLoginEvent::class    => ['onPreLogin', 20]
CasPostLoginEvent::class   => ['onPostLogin']
```

## `onPreRegister()` — a brand-new Drupal account is about to be created

- If `field.sync_frequency !== 0`, computes field values from `field.mappings` and calls
  `$event->setPropertyValues($values)`.
- If `role.sync_frequency !== 0`, runs the role check. If **no** role matched and
  `role.deny_registration_no_match` is TRUE → `$event->cancelAutomaticRegistration()`.
  Otherwise it merges the `add` list into, and subtracts the `remove` list from,
  `$event->getPropertyValues()['roles']` and calls `setPropertyValue('roles', …)`.

## `onPreLogin()` — an existing account is about to be logged in

- **Fields**: only when `field.sync_frequency === 2` (Every login). For each mapping it sets
  the value when `field.overwrite` is TRUE **or** the account's field is currently empty.
- **Roles**: the role check always runs. Roles are added/removed on the account only when
  `role.sync_frequency === 2`.
- Then, independent of sync frequency: if nothing matched and `role.deny_login_no_match` is
  TRUE → `$event->cancelLogin()`.

## `onPostLogin()` — login finalised

If `sitewide_token_support` is TRUE, stores the attributes in the session key
`cas_attributes`, first filtering them through `token_allowed_attributes` (case-insensitive)
when that list is non-empty. This is what makes `[cas:attribute:?]` resolve site-wide.

## `doRoleMapCheck()` — the comparison rules

Attribute names are lower-cased on both sides. A mapping whose attribute is absent from the
CAS response is **skipped entirely** (it neither adds nor removes). Otherwise the attribute
value is coerced to an array and compared:

| `method` | Passes when |
|---|---|
| `exact_single` | the attribute has exactly **one** value and it `===` the configured value |
| `exact_any` | **any** value `===` the configured value |
| `contains_any` | **any** value contains the configured value as a substring (`strpos`) |
| `regex_any` | **any** value matches the configured value used as a PCRE pattern (`@preg_match`, delimiters included, errors suppressed) |

`negate: true` inverts the result. Then:

- match → the role id goes in the **add** list;
- no match **and** `remove_without_match: true` → the role id goes in the **remove** list;
- no match and `remove_without_match: false` → nothing happens.

## Field mapping resolution — `getFieldMappings()`

```php
$result = trim(\Drupal::token()->replace($tokenString, ['cas_attributes' => $attrs], ['clear' => TRUE]));
$result = html_entity_decode($result);
if (!empty($result)) { $fieldData[$fieldName] = $result; }
```

An empty result means the field is left untouched — you cannot use a mapping to *clear* a
field.

## Extending it

There is no plugin type and no dedicated API file. To add behaviour, subscribe to the same
CAS events yourself with a different priority (this subscriber uses **20** on
`CasPreLoginEvent` and **-1** on `CasPreRegisterEvent`, so a higher priority on pre-login runs
before role mapping and a lower priority on pre-register runs after field/role mapping):

```php
public static function getSubscribedEvents(): array {
  return [\Drupal\cas\Event\CasPreLoginEvent::class => ['onPreLogin', 10]];
}
```

Useful CAS event API: `$event->getCasPropertyBag()->getAttributes()`,
`$event->getAccount()`, `$event->cancelLogin()`, `$event->setPropertyValue()`,
`$event->cancelAutomaticRegistration()`.
