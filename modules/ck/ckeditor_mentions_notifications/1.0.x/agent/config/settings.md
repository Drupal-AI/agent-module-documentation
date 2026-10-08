<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config form, tokens & per-user opt-in

## Install / enable

`drush en ckeditor_mentions_notifications` (pulls in `ckeditor_mentions`). Then configure the email
at `/admin/config/mentions_notifications`, and each user turns notifications on via their own profile
edit page.

## Admin config form

`Form/CkeditorMentionsNotificationsConfigForm` (extends `ConfigFormBase`), form id
`ckeditor_mentions_notifications_config_form`. Route `ckeditor_mentions_notifications.config_form` →
`/admin/config/mentions_notifications`, permission **`administer site configuration`**, `_admin_route: TRUE`.
Menu link `ckeditor_mentions_notifications.main_menu` parents it under `system.admin_config_system`.

Editable config object: **`ckeditor_mentions_notification.settings`** (note the singular
`notification` in the config name — the module machine name is plural). Two fields, both required:

| form key | config key | default (config/…settings.yml) |
|----------|-----------|--------------------------------|
| `email_subject` | `mentions_notifications_email_subject` | `[ckeditor_mentions_notifications:entity_owner] has mentioned you.` |
| `email_body` | `mentions_notifications_email_body` | `You have been mentioned here [ckeditor_mentions_notifications:entity_url].` |

The form fields carry `#token_types => ['user']`, but the token-tree link (`#theme => token_tree_link`)
is scoped to `['ckeditor_mentions_notifications']` with `#global_types => FALSE`. The in-code fallback
`#default_value` strings reference `[comment:author]` / `[comment:url]`, but the shipped default config
uses this module's own tokens (below), which is what actually applies on a fresh install. **No config
schema ships** (`config/schema/` is absent), so these keys are untyped from Drupal's schema system.

## Tokens (`hook_token_info` / `hook_tokens`)

Token type **`ckeditor_mentions_notifications`**:

| token | resolves to |
|-------|-------------|
| `entity_title` | `$entity->getTitle()` of the host Node/Comment |
| `entity_url` | `Request::createFromGlobals()->getSchemeAndHttpHost()` + `$entity->toUrl()->toString()` (absolute URL) |
| `entity_owner` | `\Drupal::currentUser()->getAccountName()` — the **current user (the mentioner)**, not the entity owner |

Tokens are replaced with `Token::replacePlain()` at send time, with `$data['entity']` = the host
entity. Notes from source: `entity_owner` is the account name of whoever triggered the mention (the
current request user), despite the name; `entity_title` calls `getTitle()`, which exists on `Node` but
not on `Comment` (a comment mention would error resolving this token — a functional bug, not security).
The `$text ??` guards in `hook_tokens` reference an undefined `$text`, so they are always no-ops.

## Per-user opt-in (`hook_form_alter` on `user_form`)

Adds a radios element `ckeditor_mentions_notifications_setting` (`Enable` / `Disable`, described as
"Enable or disable Mention notifications") to the user edit form, plus an extra submit handler
`ckeditor_mentions_notifications_form_user_profile_submit`. The value is stored through **`user.data`**:
key group `ckeditor_mentions_notifications`, name `mentions_notifications_settings_key`.

Important behaviour from source: both the default-value read and the submit write use
`\Drupal::currentUser()->id()` — **not the user being edited**. So the checkbox always reflects and
saves the *acting* user's own preference; an admin editing another account's form would read/write
their own preference, not that account's. The notification path (see
[events/notification-flow.md](events/notification-flow.md)) only fires when this value equals the
exact string `"Enable"`; unset/`null` (the default) means no email.

## Mail

`hook_mail()` key `send_ckeditor_mentions_notifications`: `from` = `system.site` mail, `subject` =
`$params['subject']`, `body[] = $params['message']`. Plaintext; sent with the mail manager's
`$send = TRUE`.
