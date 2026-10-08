<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter: views_contact_form_email_formatter

**Class:** `Drupal\views_contact_form\Plugin\Field\FieldFormatter\ViewsContactFormEmailFormatter`
extends `FormatterBase`.
**Applies to field types:** `email` (core email field, also core's `mail` base field on User).
**Label in the UI:** "Views Contact Form".

## Settings

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `contact_type` | string (contact form id) | `feedback` | Which contact form entity supplies the form's fields, form-display, redirect, auto-reply, etc. `settingsForm()` lists every contact form **except `personal`**. |
| `contact_recipients_include` | bool | `FALSE` | When TRUE, the chosen contact form's own configured recipients are merged with the field's email value(s); otherwise the field value(s) are the only recipients. |

`settingsSummary()` shows a link to the chosen form's admin page and the Yes/No of
`contact_recipients_include`. `settingsForm()` also renders a static help item linking to
`entity.contact_form.collection` ("Manage form display").

## How the recipient is resolved

The recipient is **not** the current user and **not** a fixed config value — it is the **value(s) of
the field being formatted**. Each `$item->value` in the field's item list becomes a recipient. So on
a User email field it mails that user; on a node's email field it mails whatever address is stored;
across a Views listing each row mails its own row's address. Multiple field values ⇒ multiple
recipients. The recipients are written onto a **clone** of the contact form entity, so the persisted
`contact.form.*` config is never modified.

## What is rendered

Core's `Drupal\contact\MessageForm` for a fresh `contact_message` entity bound to the cloned form.
Consequences you can rely on:
- Name + email fields are locked to the account for authenticated users (anti-impersonation), free
  text for anonymous.
- "Send yourself a copy" is hidden for anonymous users.
- Flood control runs in `MessageForm::validateForm()` using the global `contact` flood event and
  `contact.settings` `flood.limit` / `flood.interval` — shared across every embedded form and the
  real `/contact` page.
- Subject/message and any extra fields come from the chosen contact form's form-display.

## Gotchas

- **Contact module must be enabled** — undeclared runtime dependency (info.yml lists only `views`).
- **"Display all values in the same row"** must be OFF on a multi-value email field in Views, or the
  formatter is invoked once for the joined set (historical FAQ note; still relevant).
- **Many forms per page:** every embedded instance is the same form structure; a large listing renders
  many full Form API forms (build state + tokens each) — a performance and usability consideration for
  big directories.
- **No config schema ships**, so formatter settings rely on generic/absent schema; expect no
  dedicated validation of `contact_type` beyond the select options.
- The chosen `contact_type` is stored as a plain string; if that contact form is later deleted,
  `ContactForm::load()` returns NULL and `clone`/`->set()` will error when the field renders.
