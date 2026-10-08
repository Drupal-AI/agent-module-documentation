# PET — templates, entity fields, settings

## The `pet` entity

`ContentEntityType` id `pet` (base table `pets`, data table `pets_field_data`, translatable,
not fieldable). Managed at `/admin/structure/pets` (list/add/edit/clone/delete). Base fields
(`Pet::baseFieldDefinitions`):

| Field | Type | Purpose |
|---|---|---|
| `title` | string (req.) | Admin/reference title (not shown in the email). |
| `name` | string (entity key) | Machine name — used to refer to the template from code (`/pet/<name>`). |
| `subject` | string (req.) | Email subject; may contain tokens. |
| `mail_body` | string_long | HTML/markup body; may contain tokens. |
| `mail_body_plain` | string_long | Plain-text body (MimeMail); blank → core converts HTML. |
| `send_plain` | boolean | Send only plain text (MimeMail). |
| `recipient_callback` | string | Function name returning recipients when `uid=0`. Called with the loaded node (if `nid` present) or NULL. Returns `uid|email` strings. |
| `from_override` | email | Overrides site From for this template. |
| `cc_default` / `bcc_default` | email | Default CC/BCC (comma/line separated). |
| `user_id` | entity_reference (user) | Template owner (set from current user on create). |
| `status` | integer | Exportable status. |

The From/CC/BCC/recipient-callback fields are grouped under an **Additional options** details
element in `PetForm` that is only shown to users with `administer previewable email templates`.

## Settings form

Route `pet.settings` → `/admin/config/system/pet/settings` (permission `administer PET
entity`). Single setting `pet.settings:pet_logging`:
- `0` = log everything (success + errors),
- `1` = log errors only,
- `2` = no logging, show errors on screen (debugging).

Consumed in `pet_send_one_mail()` to decide logger vs. messenger output.

## MimeMail integration

`pet_has_mimemail()` checks whether the `mimemail` module is enabled. When it is, the template
form and preview expose the plain-text body and "send plain only" options; MimeMail builds the
multipart message. Without it, only the single body is used.

## Rules integration (legacy)

`pet.rules.inc` declares a "Send PET mail" action via `hook_rules_action_info()` and uses the
Drupal-7 `url()` function — this is the old Rules 7.x API and does **not** work with the
Drupal 8+ Rules module. Treat Rules-based sending as non-functional unless ported.
