# Telephone Type — manual setup guide

**Telephone Type** (`telephone_type`) extends Drupal core's telephone field with an
optional **type** selector, so a stored phone number can be labelled — for example
mobile, home, work, or fax. Editors enter a number and optionally pick its type
from a configurable list, and the display can render the number together with its
type label. Alongside the field type it provides a matching widget and formatter,
and a small validator service for the type value.

The number itself is validated and formatted using the `libphonenumber-php` library
(the PHP port of Google's libphonenumber): numbers are stored in digits‑only form,
displayed in **National** format, and linked in **RFC3966** (`tel:`) form, while fax
numbers are shown as plain markup in National format.

The problem it solves is capturing several *kinds* of phone number on one entity in
a structured way — the sort of thing you need for contact profiles, staff
directories, and commerce customer records, where a person might have a mobile, a
work line, and a fax. Rather than juggling several separate fields, you get one
typed phone field.

This is a pure field‑type module: it has **no routes, no permissions, and no
external services**, and field access simply follows the host entity's field
access. There is **no central settings page** — you configure it on the field when
you add it to a content type. It depends on core's **Telephone** and **Field**
modules (and uses **Field UI** to configure fields), and there are no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (required, to pull
   in the libphonenumber library) and enable the module.

## How to use it

Add a field to a content type and choose the **Telephone Type** field type. On the
field's **Manage form display** the widget lets editors enter the number and choose
its type; the list of available types is configurable on the field. On **Manage
display** the formatter renders the number (National format, linked as `tel:` /
RFC3966) alongside its type label. Everything is per field — there is no site‑wide
settings page.
