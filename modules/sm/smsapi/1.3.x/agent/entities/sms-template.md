<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `smsapi_sms_template` config entity + admin send forms

## The entity

`Drupal\smsapi\Entity\SmsapiSmsTemplate` (`ConfigEntityBase`, implements
`SmsapiSmsTemplateInterface`). Config prefix `smsapi_sms_template`, admin permission
**`administer smsapi sms templates`**.

- Exported fields (`config_export`): `id`, `label`, `description`, `message`, `tokens`.
  Schema `smsapi.sms_template.*` in `config/schema/smsapi.schema.yml`.
- `getMessage(): string` returns the raw body; `getTokens(): array` splits the `tokens` string on
  `', '`/`','` (`preg_split('/, |,/', ...)`).
- Rendering is done by `SmsapiSmsTemplateService::renderTemplate($template, $values)` — a plain
  `str_replace($token, $values[$token], $message)` loop over the template's tokens. `$values` is a
  `token => replacement` map (e.g. `['@code' => '1234']`).
- **Install seed**: `smsapi_install()` creates an `auth_code` template
  (`message: "Your authorization code is: @code"`, `tokens: "@code"`) if absent.

Handlers: list builder `SmsapiSmsTemplateListBuilder` (columns Label / Machine name / Description);
add/edit form `Drupal\smsapi\Form\SmsapiSmsTemplateForm` (`EntityForm`) with fields label, machine
`id`, description, `message` (textarea), `tokens` (comma-separated); delete via core
`EntityDeleteForm`.

## Routes & permissions

| Route | Path | Access |
| --- | --- | --- |
| `entity.smsapi_sms_template.collection` | `/admin/structure/smsapi-sms-template` | `administer smsapi sms templates` |
| `entity.smsapi_sms_template.add_form` | `/admin/structure/smsapi-sms-template/add` | `administer smsapi sms templates` |
| `entity.smsapi_sms_template.edit_form` | `/admin/structure/smsapi-sms-template/{smsapi_sms_template}` | `administer smsapi sms templates` |
| `entity.smsapi_sms_template.delete_form` | `.../{smsapi_sms_template}/delete` | `administer smsapi sms templates` |

Menu link `entity.smsapi_sms_template.overview` under *Structure*; action link "Add SMSAPI SMS
Template" on the collection page.

## Admin send forms (route access `administer site configuration`)

- **`smsapi.send_sms`** (`/admin/smsapi/send-sms`, `SmsForm`) — sender select (from
  `getSenders()`), recipient (numeric), message; submit calls `SmsapiService::sendSms()`. Fields are
  disabled when no token is configured, and recipient/sender are locked in Test Environment.
- **`smsapi.sms_with_template`** (`/admin/smsapi/send-sms-with-template`, `SmsWithTemplateForm`) —
  template select with an AJAX callback (`loadTokenFields`) that renders one textfield per template
  token; submit strips the preview `sms-message` field and calls `sendSmsWithTemplate()`.
- **`smsapi.profile`** (`/admin/smsapi/profile`, `SmsapiController::profile`) — renders
  `#theme smsapi__profile` with `getProfileData()`, attaching library `smsapi/profile`.
- **`smsapi.index`** (`/admin/smsapi`) — the admin menu block landing page.

All four admin routes require `administer site configuration`; the parent admin menu lives under
*Configuration → System → SMSAPI* (`smsapi.links.menu.yml`).
