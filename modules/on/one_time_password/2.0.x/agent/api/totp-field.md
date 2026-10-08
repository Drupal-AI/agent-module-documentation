<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TOTP secret field, storage & developer API

Sources: `src/UserFieldAttach.php`, `src/Plugin/Field/FieldType/ProvisioningUriItem.php`,
`src/Plugin/Field/FieldType/ProvisioningUriItemList.php`, `src/OtpLoginTrait.php`,
`src/Exception/MissingProvisioningUriException.php`, `one_time_password.module`,
`one_time_password.services.yml`.

## The `one_time_password` base field

`UserFieldAttach` (a `ContainerInjectionInterface` service, resolved via `classResolver`) adds a base
field to the **user** entity through `hook_entity_base_field_info_alter`, and installs its storage in
`hook_install`. Definition: field name `one_time_password`, type
`one_time_password_provisioning_uri`, label "Two-Factor Authentication", display **hidden** and not
configurable in view or form.

Field type `ProvisioningUriItem` (`@FieldType id = one_time_password_provisioning_uri`, `no_ui = TRUE`,
`@internal`): a single required `uri` property, schema one `uri` `varchar(256)` column. The stored value
is the entire `otpauth://totp/<label>?secret=<BASE32>&...` provisioning URI — i.e. the **shared secret in
cleartext** — because `getOneTimePassword()` rebuilds the `OTPHP\OTPInterface` object with
`OTPHP\Factory::loadFromProvisioningUri($this->uri, $clock)`.

### Field access is force-forbidden

`hook_entity_field_access` → `UserFieldAttach::entityFieldAccess()` returns `AccessResult::forbidden()`
for **any** operation on the `one_time_password` field (neutral for all other fields). This keeps the
secret URI out of entity normalization / REST / JSON:API output and out of any generic field renderer.

## Field list helper — `ProvisioningUriItemList`

- `regenerateOneTimePassword()`: generates a fresh secret with `OTPHP\TOTP::generate($clock)` (deliberately
  the default 30s period + SHA1 so Google Authenticator accepts it), sets the label to the user's label,
  and stores `getProvisioningUri()` into item 0.
- `getOneTimePassword(): OTPInterface`: returns the `OTPHP\TOTP` object for the stored URI; throws
  `MissingProvisioningUriException` if the field is empty.

Custom code can read a user's TOTP object with:

```php
if (!$user->one_time_password->isEmpty()) {
  /** @var \OTPHP\TOTP $totp */
  $totp = $user->one_time_password->getOneTimePassword();
  $ok = $totp->verify($code, NULL, 10);
}
```

Enable via `$user->one_time_password->regenerateOneTimePassword(); $user->save();` and disable via
`$user->one_time_password = []; $user->save();`.

## `OtpLoginTrait` — login hash

Used by `EntryForm` and `OneTimeLoginEventSubscriber`. `getLoginHash($account)` =
`Crypt::hmacBase64(accountName . ':' . passwordHash . ':' . lastLoginTime, private_key . hash_salt)`.
Because it includes the last-login time and password hash, the hash naturally invalidates after the user
authenticates or changes password — it ties the `/otp/{uid}/{hash}` entry URL to one account state.

## Services & clock

`one_time_password.services.yml` registers `one_time_password.clock`
(`Symfony\Component\Clock\Clock`) and aliases `Psr\Clock\ClockInterface` to it — every TOTP
generate/verify passes this clock, which makes time mockable in tests. Also registers the three event
subscribers (`RouteSubscriber`, `OneTimeLoginEventSubscriber`, `ForceOneTimePasswordSubscriber`).

## Theme hooks

`hook_theme` defines `one_time_password_setup_instructions` and `one_time_password_enable_instructions`
(no variables); templates live in `templates/` and are overridable to reword the enrol/setup copy.
