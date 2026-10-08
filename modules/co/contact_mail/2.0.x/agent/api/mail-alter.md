<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Mail — mail-alter behaviour & extension hooks

All work happens in `Drupal\contact_mail\Hook\MailAlter`, wired as service
`contact_mail.mail_alter` (`contact_mail.services.yml`) and invoked from
`contact_mail_mail_alter()` in `contact_mail.module` (a thin `hook_mail_alter()` shim).

## Entry point: `MailAlter::hook(array &$message)`

1. **Guard.** Returns immediately unless `$message['id']` is one of
   `MailAlter::CONTACT_MESSAGE_IDS` = `['contact_page_mail', 'contact_page_copy']`. Everything
   else is left untouched.
2. **Rewrite body** (only if config `tpl` is set and `$message['params']['contact_message']`
   exists):
   - `body[0]` gets the original first line plus `getWarning($config)` (the rendered `header`).
   - `body[1]` is replaced with `getMessage($message)` (the rendered submission block).
   - Both are wrapped in `Markup::create(...)`.
3. **`alter($message, $config, 'contact_mail_alter_message')`** — lets other modules adjust the
   message after the body rewrite.
4. **`addEmails($config, $message)`** — appends configured extra recipients.
5. **`alter($message, $config, 'contact_mail_alter_emails')`** — lets other modules adjust the
   recipient list.
6. **HTML header** (only if config `html` is set): sets `$message['headers']['Content-Type']`
   to `text/html`.

## `addEmails(ConfigBase $config, array &$message)`

- No-op unless config `emails` is non-empty.
- Seeds `$to` with the existing string `$message['to']`, then explodes `emails` on `"\n"`; each
  address is kept only if it contains both `@` and `.`, then `trim()`ed and appended.
- Writes `$message['to'] = implode(', ', $to)`. Recipients come solely from admin config, not
  from the submission.

## `getMessage(array $message): string`

Builds the per-field HTML block. Returns `''` unless `params['contact_form']` is a
`ContactFormInterface` and `params['contact_message']` a `MessageInterface`.

- Reads the form's default view display config
  `core.entity_view_display.contact_message.{form_id}.default` and only renders `field_*` keys
  that appear in that display's `content` (so display visibility/weight is respected;
  `#weight` is copied from the display).
- Per field it derives `$val`:
  - **Entity-reference** items (`target_id` present): loads each target via
    `entity_type.manager` storage and concatenates `label()`s as `<br> — label`.
  - **Multi-value list** (`value[1]['value']` set): maps each stored value through the field
    storage's `allowed_values` and joins with `<br> — `.
  - **Single value**: maps the first item's `value` through `allowed_values` (falls back to the
    raw value).
  - **File** fields: loads the `File`, builds an absolute URL via
    `file_url_generator->generateAbsoluteString()` and emits `<a href='…'>filename</a>`.
- Each field becomes a render element (`#prefix`/`#suffix` `<div>`, a `<b>label:</b>` title, and
  the value), assembled under `#theme => 'contact_mail'` and rendered by the `renderer` service.
  Field values are placed in render-array `#markup`, so Drupal applies its standard admin markup
  filtering during render.

## `getWarning(ConfigBase $config): string`

Renders the admin-configured `header` string through a `['#markup' => …]` render array and
returns the result. Used for `body[0]`.

## Theme

`Drupal\contact_mail\Hook\Theme::hook()` (via `contact_mail_theme()`) registers theme hook
`contact_mail` → `templates/submission.html.twig`, variables `type` (string) and `submission`
(render array). The template wraps `{{ submission }}` in `<div id="submission" class="form-{{ type }}">`.

## Extension hooks

`MailAlter::alter()` clones the message/config, calls
`module_handler->alter($hook, $alteredMessage, $alteredConfig)`, and throws a `RuntimeException`
if a listener corrupts the types (message must stay an array, config a `ConfigBase`). Two hook
names are exposed:

- `hook_contact_mail_alter_message_alter(array &$message, ConfigBase &$config)` — adjust the
  message after the body has been rewritten.
- `hook_contact_mail_alter_emails_alter(array &$message, ConfigBase &$config)` — adjust the
  message/recipients after extra emails are added.

Both receive the live config as the second alterable argument.
