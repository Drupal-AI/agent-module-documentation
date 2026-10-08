<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Optional Outgoing Mail (contact_optional_outgoing_mail) — agent index

info.yml name: **Contact Optional Outgoing Mail**. Version **2.1.1** (version dir `2.1.x`).
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Package: none declared.

A **tiny procedural module** (one file, `contact_optional_outgoing_mail.module`, ~85 lines) that
makes the **Recipients** field on a core Contact form **optional**, so a contact form can be saved
with no recipient and, when submitted, sends **no** outgoing email. Intended for store-only setups
(e.g. paired with `contact_storage`, which only saves submissions).

## Dependencies

- Drupal module: **`contact`** (core) — the only dependency (`.info.yml`). No Composer library or PHP
  version requirements (`composer.json` `require` is empty).

## What it provides (from source — entirely in `contact_optional_outgoing_mail.module`)

No routes, controllers, services, permissions, config, schema, forms of its own, templates, or Drush.
The whole surface is three hooks and two form-validate callbacks:

- **`hook_form_alter`** — only on `contact_form_add_form` / `contact_form_edit_form` (the admin
  contact-form config forms, gated by core `administer contact forms`). Sets
  `$form['recipients']['#required'] = FALSE`, then registers two validators.
- **`_contact_optional_outgoing_mail_form_validate`** (`array_unshift`, runs **first**) — if
  `recipients` is empty, substitutes a hard-coded placeholder address
  (`contact-optional-outgoing-mail@contact-optional-outgoing-mail.com`) so core's
  `ContactFormEditForm::validateForm()` (which requires ≥1 valid recipient) passes.
- **`_contact_optional_outgoing_mail_form_validate_after`** (appended, runs **last**) — if that sole
  placeholder is still the recipient, resets `recipients` to `[]` so the empty value is what gets
  saved. Net effect: an empty Recipients field is accepted and stored empty.
- **`hook_mail_alter`** — for messages with id `contact_page_autoreply` or `contact_page_mail` whose
  `to` is empty, inspects the `contact_message` entity's `contact_storage_options_email` fields
  (from the contrib `contact_storage` "options email" field type); if none of the selected options
  carries an `emails` value, sets `$message['send'] = FALSE` to suppress delivery. This is the
  guard that actually stops the mail when there is no recipient.

## Key behaviour facts (from source)

- The placeholder-address swap is purely a validation trick, admin-side only; it is never sent or
  stored (the after-validator strips it). Edge case: an admin who genuinely types only that exact
  literal address as the single recipient would have it stripped to empty.
- Making mail optional is by design a **silent suppression** — a recipient-less form (and the
  submitter auto-reply for such a form) sends **no** email on submission. Operators relying on the
  contact notification should keep a recipient set.
- `hook_mail_alter` keys off the message id and the `contact_storage_options_email` field type, so
  the delivery guard is specific to core Contact's messages and the `contact_storage` options-email
  field; it leaves all other mail untouched.

## Other docs

- Human setup/usage walkthrough → [../human-docs/index.md](../human-docs/index.md)
- Feature/usage summary → [../usage.md](../usage.md)
