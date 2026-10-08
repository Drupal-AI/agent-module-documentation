# Telephone Advanced — manual setup guide

**Telephone Advanced** (`telephone_advanced`) teaches Drupal's core telephone
field to actually validate and format phone numbers. Instead of the loose
string‑storage that core provides, it wires in `giggsey/libphonenumber-for-php`,
the PHP port of Google's libphonenumber library, so numbers are checked against
real, country‑specific rules and can be stored and displayed in a consistent
format.

The problem it solves is messy phone data. Core's telephone field checks almost
nothing, so a site ends up with `07700 900123`, `+447700900123` and
`(0770) 090‑0123` all meaning the same number and none of them comparable. Phone
numbers are genuinely hard — valid lengths, prefixes and formatting are
country‑specific and change over time — which is why libphonenumber is the
standard answer. This module adds validation (reject an impossible number at
entry), formatting (store in E.164, display in national or international form),
and line‑type awareness (mobile, fixed line, toll‑free), so you can, for example,
restrict a field to mobile numbers or normalise imported legacy data.

Crucially, it **extends the core telephone field rather than defining a new field
type**, so an existing site can adopt it with no data migration and no field
conversion — you just switch the field's widget and formatter over to the ones
this module supplies. One thing worth knowing: because previously stored values
now get validated on save, numbers that core happily accepted before may start
failing validation the next time an editor edits that content.

There is **no admin settings page** — all configuration is per field, done through
the field's widget and formatter settings (see below). The module depends on core's
**Telephone** module and on the `giggsey/libphonenumber-for-php` library (pulled in
by Composer). There are no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the libphonenumber library) and enable the module.
2. [Configuration](configuration/index.md) — switch a telephone field over to the
   module's widget and formatter, and choose validation and format options.

## How to use it

Add or edit a **telephone** field on any content type, then set that field's form
widget and display formatter to the ones Telephone Advanced provides. All the
behaviour — validation, the default country, the output format, any line‑type
restriction — is configured on the field itself, not on a central page.
