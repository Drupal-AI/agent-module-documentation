# Phone Number — manual setup guide

**Phone Number** (`phone_number`) gives Drupal a proper, validated
**international phone‑number field type**. Instead of storing phone numbers in a
plain text field where anything goes, you get a field that understands real phone
numbers: it validates them against Google's phone‑number rules (via the
`giggsey/libphonenumber-for-php` library), stores them in canonical **E.164**
format alongside the country and local parts, and offers a country‑aware input
widget and several display formatters.

You can add the field to any entity — a content type, users, taxonomy terms, and
so on. Editors get an input where they pick a country (with a flag selector or a
dropdown) and type the number, and invalid numbers are rejected on save. You can
restrict a field to particular countries, to particular number types (mobile,
fixed line, …), capture an optional extension, and even enforce that a number is
unique across entities. On display, you can render the number in international
format as a clickable `tel:` link (great for a "call us" link that works on
mobile), in local national format, or show its country.

For developers, all the parsing, validation, and formatting is exposed through the
`phone_number.util` service, so you can validate or normalise numbers in your own
code. The module also ships a **Webform element** and a **Feeds target** for the
field type, and an optional submodule, **`sms_phone_number`**, that adds SMS
verification and two‑factor authentication on top.

It depends on core's **Field** module and — crucially — on the
`giggsey/libphonenumber-for-php` PHP library, which Composer installs for you (see
[Installation](installation/index.md)). There's no central admin settings page:
you configure everything **per field** on the usual field‑management screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (which
   pulls in the libphonenumber library) and enable it.
2. [Configuration](configuration/index.md) — add a Phone Number field and tune its
   storage, field, widget, and formatter settings.

## Where it lives in the admin menu

Phone Number has no settings page of its own. You add and configure a Phone Number
field where you manage any field:

- **Add the field** — on a bundle's **Manage fields** screen (e.g. **Structure →
  Content types → [type] → Manage fields → Add field**), choose **Phone Number**.
- **Input options** — the field's widget settings on **Manage form display**.
- **Display options** — the field's formatter on **Manage display**.

## How to use it

1. Add a **Phone Number** field to your content type (or other entity), and choose
   which countries and number types it accepts.
2. On **Manage form display**, set the default country and how editors pick the
   country (flag or dropdown).
3. On **Manage display**, choose a formatter — for example the international
   formatter with the "as link" option to get a clickable `tel:` link.
4. Editors then enter numbers that are validated as they save. See
   [Configuration](configuration/index.md) for every setting.
