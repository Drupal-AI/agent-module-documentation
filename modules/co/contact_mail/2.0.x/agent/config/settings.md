<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Mail — configuration & settings form

## Install / enable

```sh
composer require drupal/contact_mail
drush en contact_mail -y
```

Requires the core `contact` module (declared `contact:contact` in `contact_mail.info.yml`),
which is enabled automatically as a dependency. No libraries, no submodules.

## Settings form & route

- Route `contact_mail.settings` (`contact_mail.routing.yml`): path
  `/admin/config/system/contact-mail`, `_form: \Drupal\contact_mail\Form\Settings`,
  requirement `_permission: 'administer contact forms'`.
- Menu link `contact_mail.settings` (`contact_mail.links.menu.yml`) under
  `system.admin_config_system`.
- Form class `Drupal\contact_mail\Form\Settings` extends `ConfigFormBase`; form id
  `contact_mail_settings`; editable config `contact_mail.settings`. `submitForm()` writes the
  four fields straight back to that config object.

## Config object `contact_mail.settings`

Defaults ship in `config/install/contact_mail.settings.yml`. There is no `config/schema/` in
this release (`provides_config_schema` is false).

| Key | Form field | Type | Default | Effect |
|-----|-----------|------|---------|--------|
| `emails` | "Contact form Recipients" (textarea, 1 per line) | string | `''` | Extra recipient addresses appended to every contact mail's `to`. |
| `tpl` | "Rewrite submission template" (checkbox) | 0/1 | `1` | When true, replaces the mail body with the rendered HTML submission block + header. |
| `html` | "Send html instead txt" (checkbox) | 0/1 | `1` | When true, sets header `Content-Type: text/html`. |
| `header` | "Mail extra information" (textarea) | string (HTML) | see below | HTML block rendered above the submission when `tpl` is on. |

Default `header` value (HTML):

```html
<h2>Mail from website</h2>
<ul>
  <li>Do not reply to this email.</li>
  <li>Find the e-mail or phone number of the customer in the email and reply to him.</li>
</ul>
<hr>
<h2>Customer mail</h2>
```

`langcode: en` is also stored in the shipped config.

## Operating notes

- The `emails` textarea is split on newlines; each line is kept only if it contains both `@` and
  `.` (`MailAlter::addEmails()`), then trimmed and joined onto the existing `to` with `, `.
- Settings apply globally to every site contact form — there is no per-form override.
- Only the two core contact mails are affected (`contact_page_mail`, the recipient copy, and
  `contact_page_copy`, the sender's auto-reply); all other mails pass through untouched.
- The `header` field expects HTML; it is rendered through a render array (see
  [mail-alter behaviour](../api/mail-alter.md)). Editing it needs `administer contact forms`.

See [mail-alter behaviour & extension hooks](../api/mail-alter.md) for what each toggle does to
the outgoing message.
