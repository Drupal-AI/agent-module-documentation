<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Phone Number — field & settings

No admin settings page (`configure: null`). You configure a field of type `sms_phone_number` and
(for TFA) the `sms_phone_number.settings` config object.

## The `sms_phone_number` field type

Subclass of `phone_number`'s `PhoneNumberItem`, so it keeps all Phone Number storage/field
settings (`allowed_countries`, `allowed_types`, `extension_field`, storage `unique`) and adds:

| Setting | Values | Meaning |
|---|---|---|
| `verify` | `none` / `optional` / `required` | Whether the number must be SMS-verified. Constants: `PHONE_NUMBER_VERIFY_NONE`='none', `PHONE_NUMBER_VERIFY_OPTIONAL`='optional', `PHONE_NUMBER_VERIFY_REQUIRED`='required'. Default is `optional` when SMS is enabled, else `none`. |
| `message` | string | The verification SMS template. Default `PHONE_NUMBER_DEFAULT_SMS_MESSAGE` = `"Your verification code from !site_name:\n!code"`. |

Default widget `sms_phone_number_default`; default formatter `sms_phone_number_international`.

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_mobile', 'entity_type' => 'user', 'type' => 'sms_phone_number',
])->save();
FieldConfig::create([
  'field_name' => 'field_mobile', 'entity_type' => 'user', 'bundle' => 'user',
  'label' => 'Mobile', 'settings' => ['verify' => 'required'],
])->save();
```

## Config object `sms_phone_number.settings`

| Key | Meaning |
|---|---|
| `tfa_field` | Machine name of the user phone field used for SMS two-factor auth. |
| `verification_secret` | Secret used when hashing/validating verification codes. |

```bash
drush cget sms_phone_number.settings
drush cset sms_phone_number.settings tfa_field field_mobile -y
```

You can also set the TFA field in code via the service: `sms_phone_number.util->setTfaField(...)`
(see [../api/util-and-hooks.md](../api/util-and-hooks.md)).

## Verification requires an SMS gateway

Sending codes uses the SMS callback (default SMS Framework `sms_send`). On a site with no gateway
you can still set `verify`/`tfa_field`/templates, but no code can actually be delivered — verify
`isSmsEnabled()` before relying on delivery.
