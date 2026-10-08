<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Mail — agent index

**Contact Mail** (`contact_mail`, `8.x-1.12`) alters the emails that Drupal's **core Contact**
module sends. Via `hook_mail_alter()` it, per config: adds common extra recipients to every
contact form, optionally re-renders the submission as a formatted (HTML) table with an admin
header, and can switch the mail's Content-Type to `text/html`. Core `^9.3 || ^10 || ^11`,
package Mail. No dependencies declared, no permissions of its own, no services, no Drush, no
install hook. Small single-purpose module — everything lives in one settings form + one alter
hook, so this index covers it in full.

## Configuration route (important)

- **Real route:** `contact_mail.settings` → `/admin/config/system/contact-mail`, requirement
  `_permission: 'administer contact forms'` (core permission). Defined in
  `contact_mail.routing.yml`; also surfaced as an admin menu link under **Configuration ›
  System** ("Contact Mail Settings", `contact_mail.links.menu.yml`).
- **Known functional bug:** `contact_mail.info.yml` has `configure: synmail.config` — a stale
  pointer to a nonexistent route (leftover from a renamed "synmail" project). `drush en`
  prints `Route synmail.config does not exist` during router rebuild and the Extend page's
  "Configure" link is broken, but the module still installs and the site boots normally. Reach
  the form via the **Configuration › System** menu link or the path directly, not the Extend
  Configure link. This is a functional bug only.

## What it hooks

`contact_mail.module` implements `hook_mail_alter()` → `MailAlter::hook(&$message)`
(`src/Hook/MailAlter.php`). It acts **only** on core Contact message ids
`contact_page_mail` and `contact_page_copy` (the site-wide contact form's mail to recipients
and the "send yourself a copy" mail); all other mail is returned untouched.

Config `contact_mail.settings` (schema-backed, `config/install/contact_mail.settings.yml`) keys:

- `tpl` (bool, default 1) — "Rewrite submission template". When on and the message carries a
  `contact_message` entity: prepends the rendered `header` to `body[0]`, and replaces `body[1]`
  with a re-rendered submission built by `MailAlter::getMessage()`.
- `html` (bool, default 1) — "Send html instead txt". Sets `$message['headers']['Content-Type']
  = 'text/html'`.
- `emails` (string, default '') — newline-separated recipient list. `MailAlter::addEmails()`
  appends each line that contains both `@` and `.` (trimmed) to `$message['to']`, so the
  addresses receive **every** site contact form's mail in addition to the form's own recipient.
- `header` (string, HTML) — "Mail extra information", rendered as `#markup` and prepended to the
  body when `tpl` is on. Default is a canned "Do not reply / Customer mail" block.

## How the submission is rebuilt (`MailAlter::getMessage()`)

- Reads the contact form's view display `core.entity_view_display.contact_message.{form_id}.default`
  for `content`/`hidden` and per-field weight.
- Iterates the submitted `contact_message` fields whose key contains `field_` and that are
  visible in the display; for each emits `<div><b>Label:</b> value</div>` with the display weight.
- Value handling: entity-reference fields load the target and print `$entity->label()`;
  list/allowed-values fields map raw values to their labels; `file` fields print an
  `<a href>` to the file's absolute URL; multi-value fields are joined with `<br> — `.
- Renders through theme hook `contact_mail` (`Theme::hook()`, template
  `templates/submission.html.twig`, which just wraps `{{ submission }}` in a div).

## Extension points

Two alter hooks are invoked for other modules (no `*.api.php` ships, but they exist):

- `hook_contact_mail_alter_message_alter(&$message, $config)` — after the body rewrite.
- `hook_contact_mail_alter_emails_alter(&$message, $config)` — after extra recipients are added.

## Files

- `contact_mail.module` — hook_mail_alter + hook_theme thin wrappers.
- `src/Hook/MailAlter.php` — all mail-rewrite logic.
- `src/Hook/Theme.php` — `contact_mail` theme hook.
- `src/Form/Settings.php` — the settings ConfigForm (`contact_mail_settings`).
- `contact_mail.routing.yml`, `contact_mail.links.menu.yml` — the real admin route + menu link.
- `config/install/contact_mail.settings.yml` — default config.
- `templates/submission.html.twig` — submission wrapper template.
