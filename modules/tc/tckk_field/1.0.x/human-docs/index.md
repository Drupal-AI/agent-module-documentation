# T.C. Kimlik No — manual setup guide

**T.C. Kimlik No** (`tckk_field`) provides a field type for the Turkish Republic
national identity number (the *T.C. Kimlik No*), with built‑in validation. When a
value is entered, the module checks its format and checksum, so your content only
ever stores a well‑formed, verified Turkish ID. It is aimed at Turkish sites that
need to collect citizen identifiers reliably.

The module gives you three ways to work with the ID:

- **As a field.** Add it to content types, users, or taxonomy terms just like any
  other field, so editors fill it in on the entity form.
- **As a form element.** In custom forms built with the Form API, you can use the
  `tckk` element type (`'#type' => 'tckk'`) to get a validated input.
- **As a service.** A validator service (`tckk_field.validator`) lets developers
  check any T.C. Kimlik No programmatically — `->validate($number)` returns
  whether it is valid.

It depends only on core's **Node** module, supports Drupal 8 through 11, and
provides its own permission. There is no global settings form — you use the field,
element, or service directly.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The most common use is adding the field to a content type: go to **Structure →
Content types**, edit the type, open **Manage fields**, add a new field and choose
the **T.C. Kimlik No** field type. The same field is available on users and
taxonomy terms. When someone enters a number, the module validates it and rejects
malformed or checksum‑failing values.

Developers who build custom forms can add a validated input with
`$form['tc'] = ['#type' => 'tckk', '#title' => t('T.C.'), '#required' => TRUE];`,
and can validate a number anywhere in code via the
`\Drupal::service('tckk_field.validator')->validate($number)` service. Check
**People → Permissions** to assign the module's permission to the appropriate roles.
