<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Storage Options Email Recipient (contact_storage_options_email_recipient) — agent index

info.yml name **"Contact Storage Options Email Recipient"**, version **2.1.0** (version dir `2.1.x`).
info.yml description: *"Removes the recipient field from the contact edit form when a form has an
options_email field."* Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Not covered by Drupal's
security advisory policy (`security_advisory_coverage: not-covered`).

A tiny **admin-UX helper** for the [Contact Storage](https://www.drupal.org/project/contact_storage)
`contact_storage_options_email` ("Options email") field type. It does **not** itself route mail or map
options to addresses — that logic lives entirely in **contact_storage**. This module only cleans up the
**contact-form edit page** (admin UI) so an admin isn't forced to also type a fixed recipient when an
"Options email" field already determines the recipient.

## Dependency

- `contact_storage:contact_storage` (hard dependency, `.info.yml`). The "Options email" field type
  (`contact_storage_options_email`) it keys off is provided by contact_storage, not here. No Composer
  library requirements (`composer.json` `require: {}`).

## What it provides (entire surface, from source)

- **`contact_storage_options_email_recipient.module`**
  - `hook_help()` — About text on `help.page.contact_storage_options_email_recipient`.
  - `hook_entity_type_alter()` — swaps the `contact_form` entity's `add` **and** `edit` form-handler
    classes to `Drupal\contact_storage_options_email_recipient\Form\ContactFormEditForm`.
- **`src/Form/ContactFormEditForm.php`** — extends contact core's
  `Drupal\contact\ContactFormEditForm` (the contact-form entity edit form; admin-only, gated by core's
  `administer contact forms` permission — unchanged by this module).
  - `getRecipientOptionsEmailField()` — via `entity_field.manager`, scans field definitions of the
    `contact_message` bundle (= contact form id) and returns the first field whose type is
    `contact_storage_options_email`, else `FALSE`.
  - `form()` — if such a field exists **and is required** → `unset($form['recipients'])` and shows a
    warning "The recipient of this form is determined by the '[field label]' field." If it exists but
    is **not required** → shows only an informational warning that the field determines an *additional*
    recipient (the `recipients` field stays).
  - `validateForm()` — when a required "Options email" field is present, core still requires the
    `recipients` value, so it temporarily sets `recipients = 'dummy@dummy.com'` to pass parent
    validation, then resets it to `[]`. Otherwise defers to `parent::validateForm()`.

## Key facts

- **No routes, controllers, permissions, services, config, config schema, templates, Drush, or JS.**
  (`provides_config_schema` is false — there is no `config/` dir or schema file.)
- The recipient decision is **contact_storage's**: an admin maps each "Options email" option to a fixed
  address; the submitter selects an option (a key), not a free-text address. This module never reads or
  writes the recipient value at submit time — it only edits the admin-facing form definition.
- Affects only the contact-form **edit/add** entity form (admin). It does not alter the front-end
  contact message submission form or its handler.
