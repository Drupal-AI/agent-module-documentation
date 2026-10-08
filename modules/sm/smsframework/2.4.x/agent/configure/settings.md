# Configuration: settings, gateways & phone numbers

Admin area (all under `_permission: administer smsframework`):

| Route | Path | What |
|---|---|---|
| `sms.admin` | `/admin/config/smsframework` | Menu landing (the module's `configure` route). |
| `sms.settings` | `/admin/config/smsframework/settings` | Global settings form. |
| `sms.gateway.list` | `/admin/config/smsframework/gateways` | Gateway instances. |
| `entity.sms_gateway.add` / `.edit_form` / `.delete_form` | `/admin/config/smsframework/gateways/...` | CRUD a gateway. |
| `sms.phone_number_settings.list` | `/admin/config/smsframework/phone_number` | Phone-number settings per bundle. |
| `entity.phone_number_settings.add` / `.edit_form` / `.delete_form` | `/admin/config/smsframework/phone_number/...` | CRUD phone-number settings. |
| `sms.phone.verify` (dynamic) | `sms.settings:page.verify` (default `/verify`) | Public verify-code form (`sms verify phone number`). |

## `sms.settings` (config object)

| Key | Default | Meaning |
|---|---|---|
| `fallback_gateway` | `log` | Gateway id used when nothing else routes the message. |
| `flood.verify_limit` | `5` | Max failed verify-code attempts per window. |
| `flood.verify_window` | `21600` | Flood window in seconds (6h). |
| `page.verify` | `/verify` | Path of the verification form; changing it rebuilds routes. |

```php
\Drupal::configFactory()->getEditable('sms.settings')
  ->set('fallback_gateway', 'my_gw')
  ->set('page.verify', '/verify')
  ->save();
```

## `sms_gateway` config entity (`sms.gateway.*`)

Exported keys (`config_export`): `id`, `label`, `plugin`, `settings` (the plugin's config, incl.
credentials), `skip_queue`, `incoming_push_path`, `reports_push_path`,
`retention_duration_incoming`, `retention_duration_outgoing`. Create one via the form, or:

```php
use Drupal\sms\Entity\SmsGateway;
$gw = SmsGateway::create([
  'id' => 'my_gw',
  'label' => 'My Gateway',
  'plugin' => 'my_gw',
  'settings' => ['api_key' => '...'],  // plugin-defined
  'skip_queue' => FALSE,
  'retention_duration_incoming' => -1, // -1 = never expire
  'retention_duration_outgoing' => -1,
]);
$gw->save();
```

`incoming_push_path` / `reports_push_path` default to a random 128-bit path at creation (see
[plugins/gateway.md](../plugins/gateway.md)). `skip_queue` sends immediately (documented as debug-only).

## `phone_number_settings` config entity (`sms.phone.<entity_type>.<bundle>`)

Binds a content-entity bundle to a phone-number field and defines verification. Exported keys:
`id`, `entity_type`, `bundle`, `automated_optout`, `verification_message`,
`verification_code_lifetime`, `purge_verification_phone_number`, `fields`
(`fields.phone_number` = telephone field name, `fields.automated_opt_out` = boolean field name).

The add form (`PhoneNumberSettingsForm`, `/admin/config/smsframework/phone_number/add`) lets you pick
a bundle, map (or auto-create) a `telephone` field + optional boolean opt-out field, set the
verification message (tokens `[sms-message:verification-code]`, `[sms:verification-url]`), and set
the code lifetime (min 60s, default 3600) and whether to purge the number when a code expires.
Typical setup: the `user`/`user` bundle. The form installs the `sms_telephone` field widget on the
mapped field.

## Verification flow (what the config drives)

When a configured entity is saved with a new phone number, `hook_entity_insert`/`update`
(`PhoneNumberVerification::updatePhoneVerificationByEntity()`) creates a
`sms_phone_number_verification` record with a generated code and texts it to the number using the
bundle's verification message. The recipient opens the verify page (`page.verify`) and submits the
code; `VerifyPhoneNumberForm` marks the record verified (flood-limited by
`flood.verify_limit`/`verify_window`). `hook_cron` → `purgeExpiredVerifications()` removes expired
unverified records (and optionally the phone value).

## Config schema

`config/schema/sms.schema.yml` defines `sms.settings`, `sms.gateway.*`, `sms.phone.*.*`, the
`sms_telephone` widget settings, and the `sms_gateway.settings.[plugin]` base type
(`sms_gateway_settings`, extended by each gateway module). Content entities `sms`, `sms_result`,
`sms_report`, `sms_phone_number_verification` are code-defined (installed by `sms.install`).
