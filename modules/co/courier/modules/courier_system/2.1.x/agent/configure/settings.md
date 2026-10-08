# Courier system — configuration

## Settings form — `courier_system.config` (`Form\Settings`)

Path `/admin/config/communication/courier_system`, requirement core permission
**`administer account settings`** (a restricted permission). The form has two parts:

1. **Replace Drupal mails** — a `courier_template_collection_list` of user mails that already have a
   `courier_system.<mail_id>` global collection, each showing status (*enabled – using Courier* /
   *disabled – using Drupal*). A "With selection" operation select applies to checked rows:
   - `copy_email` — copy the current Drupal email text into the Courier email template.
   - `enable` — set `override[<mail_id>] = TRUE` (start using Courier).
   - `disable` — set it FALSE (restore Drupal's mail).
   - `delete` — delete the global collection + its template collection and drop the override.
2. **Add missing messages** — a table of supported mail ids that don't yet have a collection; submitting
   `submitCreateMessages()` creates the `GlobalTemplateCollection`, ensures a `courier_system_user`
   CourierContext (tokens `['user']`), copies the core email text in, and enables the override.

## Config stored — `courier_system.settings`

Only an `override` mapping (schema `courier_system.schema.yml`), one boolean per supported mail id:
`user_cancel_confirm`, `user_password_reset`, `user_status_activated`, `user_status_blocked`,
`user_status_canceled`, `user_register_admin_created`, `user_register_no_approval_required`,
`user_register_pending_approval`.

## Runtime behaviour — `courier_system_mail_alter()` (`courier_system.module`)

For each sent mail whose id has `override[<mail_id>]` truthy:
1. `$message['send'] = FALSE` — cancel the core send.
2. Load `GlobalTemplateCollection::load('courier_system.' . $mail_id)` → its template collection.
3. Set token `user` to the recipient `User` (from `$message['params']['account']`, valid for
   user.module mails) and set the token option `callback => 'user_mail_tokens'` so
   `[user:one-time-login-url]` and `[user:cancel-url]` resolve.
4. `courier.manager->sendMessage($template_collection, $identity)` — deliver via Courier.

## Import detail — `copyCoreToCourierEmail()`

Reads the current text from core `user.mail` config for the mail id, converts `[user:name]` →
`[identity:label]`, applies `nl2br()` to values, and writes subject/body into the collection's
`courier_email` template. Only `user_*` mails are supported (the key is derived by stripping the
`user_` prefix).

## Access

`hook_entity_access()` grants the `templates` operation on a `courier_system.*` template collection to
users with **`administer account settings`** — so editing these collections' per-channel templates is
tied to that same restricted permission.
