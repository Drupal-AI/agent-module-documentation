<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Birthday Wish Mail — configuration, cron engine, mail & tokens

Everything the module does, grounded in `birthday_wish_mail.module`,
`birthday_wish_mail.tokens.inc`, `birthday_wish_mail.install`, and
`src/Form/BirthdayWishMailSettingsForm.php`.

## Install / enable

1. `composer require drupal/birthday_wish_mail` and `drush en birthday_wish_mail` (pulls in
   `token`). `hook_schema` creates the `birthday_wish_mail` table.
2. Add a **date-of-birth field** to the user entity (Manage fields on `/admin/config/people/accounts/fields`).
   Any field whose stored value contains the birthday's `MM-DD` works; the module matches on a
   `LIKE %m-d%` substring of `user__<field>.<field>_value`.
3. Configure at `/admin/config/birthday_wish_mail/bwm_settings_advanced` (see below).
4. Ensure cron runs — sending happens only in `hook_cron`.

## Settings form (`BirthdayWishMailSettingsForm`, id `birthday_wish_mail_settings_advanced`)

`ConfigFormBase`; `getEditableConfigNames()` → `birthday_wish_mail.settings_advanced`. Fields:

- `bwm_dob` — textfield, **required**. The DOB **field machine name** (e.g. `field_date_of_birth`).
  `validateForm()` rejects it unless `Database::schema()->fieldExists('user__' . $dob, $dob . '_value')`
  is true, so an admin cannot save a non-existent field.
- `site` → `bcc` — `#type => email` (format-validated), optional BCC address.
- `site` → `title` — textfield, **required** — the mail **Subject**.
- `site` → `content` — `#type => text_format` (default format `full_html`), **required** — the mail
  **Message** body. Carries `token_element_validate` with `#token_types => ['user']` and a
  `token_tree_link` UI (`#show_restricted => TRUE`, `#global_types => FALSE`).

`submitForm()` writes **flat** keys: `bwm_dob`, `site_title` (from `site.title`), `site_value`
(from `site.content.value`), `site_format` (from `site.content.format`), `site_bcc` (from
`site.bcc`).

### Config-key caveat (schema/install mismatch)

The runtime keys used by the form and by `hook_mail` are `bwm_dob`, `site_title`, `site_value`,
`site_format`, `site_bcc`. But `config/install/birthday_wish_mail.settings_advanced.yml` ships a
**nested** shape (`site: {title: '', content: ''}`), and `config/schema/birthday_wish_mail.schema.yml`
only types `site.title` (label) and `site.content` (text). So the actual runtime keys are
**undeclared in schema** (expect config-inspector warnings) and the install defaults are written
under keys the code never reads. In practice the values are created/overwritten the first time the
admin saves the form. `config_translation` is declared for this config object.

## Routes & access

| Route | Path | Handler | Permission |
|---|---|---|---|
| `birthday_wish_mail.admin` | `/admin/config/birthday_wish_mail` | `SystemController::systemAdminMenuBlockPage` | `administer site configuration` |
| `birthday_wish_mail.settings_advanced` | `/admin/config/birthday_wish_mail/bwm_settings_advanced` | `BirthdayWishMailSettingsForm` | `administer site configuration` |

Menu links in `*.links.menu.yml` (under Configuration), a task tab in `*.links.task.yml`. The
module defines **no permissions of its own** and exposes **no visitor-facing routes**.

## Cron engine (`birthday_wish_mail_cron`)

1. Reads `bwm_dob` from the (editable) config, computes `$today = date("m-d", REQUEST_TIME)`.
2. Builds a DB `select('user__<dob>', 'udob')` joined to `users_field_data ufd` on
   `ufd.uid = udob.entity_id`, with conditions: `udob.bundle = 'user'`,
   `udob.<dob>_value LIKE '%' . escapeLike($today) . '%'`, and `ufd.status = 1`. Selects the DOB
   value plus `uid, preferred_langcode, name, mail`.
3. Invokes the alter hook **`hook_birthday_wish_mail_users_alter(&$result)`** so other modules can
   add/remove recipients.
4. For each row: `$to = $mail`; skip when `birthday_wish_mail_check($to)` is non-zero (already sent
   today). Otherwise `MailManager::mail('birthday_wish_mail', 'send_birthday_wish_mail', $to,
   $preferred_langcode, ['account' => User::load($uid)], NULL, TRUE)`.
5. On success, `insert` into `birthday_wish_mail` (`mail => $to`, `created => date("m-d-Y")`) and
   log/message a notice. On failure it warns, logs an error, and **`return`s** — aborting the whole
   cron run, so users later in the batch are not attempted until the next cron. (`$result` is
   reused as both the row set and the mail result inside the loop; the `foreach` still iterates the
   original array copy.)

`birthday_wish_mail_check($mail)` counts `birthday_wish_mail` rows where `mail = $mail` AND
`created = date("m-d-Y")` — the per-day dedupe guard.

## Mail template (`birthday_wish_mail_mail`, key `send_birthday_wish_mail`)

- Loads `birthday_wish_mail.settings_advanced` and switches the language manager's config-override
  language to the recipient's `getPreferredLangcode()` (so a translated Subject/Message is used).
- Subject: `$message['subject'] .= PlainTextOutput::renderFromHtml(Token::replace($site_title, ['user' => $account], $opts))`
  — tags stripped to plain text.
- Body: `$message['body'][] = Markup::create(Token::replace($site_value, ['user' => $account], $opts))`.
- Token options: `{langcode, callback: 'birthday_wish_mail_mail_tokens', clear: TRUE}`.
- If `site_bcc` is set, adds `$message['headers']['bcc']`.

## Tokens (`birthday_wish_mail.tokens.inc`)

- `hook_token_info` (declared as `birthday_wish_mail_info()` — note the non-standard function name;
  it mirrors core's `user` token set: `uid`, `name` (deprecated), `account-name`, `display-name`,
  `mail`, `url`, `edit-url`, `last-login`, `created`).
- `birthday_wish_mail_tokens()` (`hook_tokens`) resolves those `user` tokens from the account, plus
  chained `last-login:`/`created:` date tokens.
- The mail callback `birthday_wish_mail_mail_tokens()` adds two extra replacements when a `user` is
  present: `[user:one-time-login-url]` (`user_pass_reset_url()`) and `[user:cancel-url]`
  (`user_cancel_url()`) — use these in the Message body to embed a reset/cancel link.

## Uninstall

`birthday_wish_mail_uninstall()` drops the `birthday_wish_mail` table. Config is removed with the
module as usual.
