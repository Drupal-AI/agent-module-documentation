<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & notification mechanism

## Install & enable

```bash
composer require drupal/comment_admin_notify drupal/token
drush en comment_admin_notify -y
```

Depends on core **`comment`** and contributed **`token`**. No sub-modules, no permissions of its
own, no Drush commands.

## Settings form

- Route **`comment_admin_notify.settings`** → `/admin/config/system/comment-admin-notify`
  (menu: *Configuration → System*), permission **`administer site configuration`**.
- Class `\Drupal\comment_admin_notify\Form\CommentAdminNotifyForm` (extends `ConfigFormBase`,
  form id `comment_admin_notify_settings_form`), editing config object
  **`comment_admin_notify.settings`**.

All fields live in a `details` element titled *Comment notification*:

| Config key | Form element | Default (from code) | Meaning |
|---|---|---|---|
| `comment_admin_notify` | checkbox *Enable* | `TRUE` | Master on/off for sending notifications. |
| `comment_admin_notify_mailto` | email *E-mail to address* | site e-mail (`system.site` `mail`, else `sendmail_from`) | Recipient address. |
| `comment_admin_notify_subject` | textfield *E-mail subject* | `Comment notification` | Subject template (token-replaced). |
| `comment_admin_notify_mailtext` | textarea *E-mail content* | `comment_admin_default_mailtext()` template | Body template (token-replaced); `#element_validate` = `token_element_validate`, `#token_types` = `node`, `comment`. |
| `comment_admin_notify_content_types` | checkboxes *Content Types for Email Notifications* | all node types (`comment_admin_all_content_types()`) | Bundles whose comments trigger a mail. Options = `NodeType::loadMultiple()`. |

A `token_tree_link` (theme) below the fields lets admins browse valid `node`/`comment` tokens.

### submitForm

Calls `$form_state->cleanValues()`, then writes **every** remaining form value into the config
object by key (`$config->set($key, $value)`), re-sets `comment_admin_notify_content_types`
explicitly, and `$config->save()`. There is **no** `config/install` default file and **no**
`config/schema` on disk — defaults exist only in the `.module` helpers, so config is untyped
(schema-less) until saved by the form.

## Default body template

From `comment_admin_default_mailtext()`:

```
Dear Admin,

You have received a comment on: "[node:title]"

----
[comment:title]
[comment:body]
----

You can view the comment at the following url
[comment:url]
```

## How a notification is produced (`comment_admin_notify_comment_insert`)

1. Guard: `comment_notify_variable_get('comment_admin_notify', TRUE)` must be truthy.
2. Resolve the commented entity's bundle (`$comment->getCommentedEntity()->bundle()`); it must be
   in the selected `comment_admin_notify_content_types` list.
3. Recipient `$mailto` = `comment_admin_notify_mailto` (falls back to site e-mail).
4. Load the node when `getCommentedEntityTypeId() == 'node'` (else `$node = NULL`).
5. Token-replace **both** subject and body with `\Drupal::token()->replace($value, ['comment' => $comment, 'node' => $node])`.
6. Send via `\Drupal::service('plugin.manager.mail')->mail('comment_admin_notify', 'comment_notify_mail', $mailto, $langcode, $params)`.
7. `hook_mail()` (`comment_admin_notify_mail`) sets `$message['subject'] = $params['subject']` and
   `$message['body'][] = $params['body']` — plain text, no HTML wrapper.
8. Log a watchdog `notice`: `Nid: @nid, cid: @cid. Subject: @subject`.

## Operational notes

- `comment_notify_variable_get()` treats an **empty** stored value as unset and returns the passed
  default. Consequence: clearing the recipient reverts to the site e-mail; a `0`/empty *Enable*
  value reverts to `TRUE` (the master switch effectively can't be turned off by saving an empty
  value — it only turns off when the stored value is a truthy-but-different state; in practice the
  checkbox stores `0`/`1`, and `0` is treated as empty → default `TRUE`, so unchecking may not
  disable it as expected — verify behaviour on your Drupal version).
- Notifications are sent per-comment synchronously during the insert request; high comment volume
  means one mail per comment on selected types.
- `comment_admin_all_content_types()` and the form's options come from **node** bundles only, even
  though the insert hook checks the generic commented-entity bundle.
