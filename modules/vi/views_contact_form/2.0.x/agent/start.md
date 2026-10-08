<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Contact Form (views_contact_form) — agent index

Version **2.0.3**. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually is (2.0.x)

A **single field formatter**, id `views_contact_form_email_formatter`, label "Views Contact Form",
for core **`email`** field types. Set it as an email field's format on any entity view display or in
a Views "field" row and, instead of printing the address (value or `mailto:` link), it renders an
**inline core contact form** whose recipient is the field's email value.

That is the entire installed surface. The `.module` file is empty. There is **no** Views style
plugin, **no** Views handler, **no** config schema, **no** permissions, **no** Drush, and **no**
submodules — despite the drupal.org project page, which still describes the Drupal 7 era Views
style/handler and Honeypot/Mollom submodules. Treat that page as historical; only the formatter ships.

## Mechanism (src/Plugin/Field/FieldFormatter/ViewsContactFormEmailFormatter.php)

`viewElements()`:
1. Collects `$item->value` for every item in the field list into `$recipients`. Returns `[]` if empty.
2. `clone ContactForm::load($this->getSetting('contact_type'))` — the admin-chosen contact form
   entity (default `feedback`; the `personal` form is excluded from the settings options).
3. If setting `contact_recipients_include` is TRUE, merges the contact form's own configured
   `recipients` into the list; then `array_unique()`.
4. `$contact_form->set('recipients', $recipients)` on the **clone** (the stored config entity is not
   mutated).
5. Creates a transient `contact_message` entity bound to that form, sets `->contact_form->entity`,
   and renders it with `entity.form_builder` → the markup replaces the field output.

Because it reuses core `Drupal\contact\MessageForm`, core behavior is preserved: subject/message
fields per the chosen form's form-display, authenticated name/mail lock, anonymous "send yourself a
copy" hidden, and **core contact flood control** (checked in `MessageForm::validateForm()` against
`contact.settings` flood limit/interval).

## Settings (defaultSettings / settingsForm)

- `contact_type` (string, default `feedback`) — which non-`personal` contact form supplies the form.
- `contact_recipients_include` (bool, default FALSE) — also mail the contact form's default recipients.

## Dependencies — read this

- `info.yml` declares **only** `drupal:views`.
- The code hard-requires the core **Contact** module at runtime (`ContactForm`, `contact_message`).
  If Contact is disabled the formatter fatals. On this doc site Contact was disabled while the module
  was enabled — enable `contact` before using. Views itself is not strictly needed to use the
  formatter on a normal entity display; it is declared because the intended use is Views field rows.

## Detail docs

- `plugins/formatter.md` — the field formatter, its settings, how recipients resolve, gotchas.
